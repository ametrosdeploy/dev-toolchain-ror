# frozen_string_literal: true

# == Schema Information
#
# Table name: global_resources
#
#  id              :bigint           not null, primary key
#  title           :string
#  description     :text
#  resource_type   :integer
#  customer_id     :bigint
#  private         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cached_tag_list :string
#  content_type    :integer
#  is_pdf          :boolean          default(FALSE)
#
class GlobalResource < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  PER_PAGE = 10
  acts_as_ordered_taggable
  strip_attributes

  enum resource_type: %i[image document]
  # enum content_type: %i[global content plot_point module_intro]

  belongs_to :customer, optional: true

  has_many :world_global_resources
  has_many :worlds, through: :world_global_resources

  # has_one_attached :attachment
  has_one_base64_attached :attachment

  validates :customer_id, presence: true, if: :private?
  # validates :title, presence: true

  validates :resource_type, :attachment, presence: true
  validate :validate_attachment
  before_validation :set_is_pdf
  scope :with_image, lambda {
                       where(resource_type:
                                     GlobalResource.resource_types['image'])
                     }
  scope :with_document, lambda {
                          where(resource_type:
                                   GlobalResource.resource_types['document'])
                        }
  scope :with_pdf, -> { where(is_pdf: true) }

  # Validate attachment type
  def validate_attachment
    return unless attachment.attached?

    if image? && !valid_image?
      errors.add(:document, 'Must be a jpg, jpeg or png')
    elsif document? && !valid_document?
      errors.add(:document, 'Must be a PDF or a DOC file')
    end
  end

  # Used for searching Global Resource
  def self.search(keyword)
    where("active_storage_blobs.filename ilike :search or LOWER(cached_tag_list)
     ILIKE :search", search: "%#{keyword.downcase}%")
  end

  # Checks weather the resource is a PDF
  def pdf?
    document? && valid_pdf?
  end

  def set_is_pdf
    self.is_pdf = pdf?
  end

  private

  def valid_document?
    attachment.content_type.in?(valid_doc_list)
  end

  def valid_image?
    attachment.content_type.in?(%w[image/jpeg image/jpg image/png])
  end

  def valid_pdf?
    attachment.content_type.in?(%w[application/pdf])
  end

  def valid_doc_list
    ['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
     'application/msword',
     'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
     'application/pdf']
  end
end
