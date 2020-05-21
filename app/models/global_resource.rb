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
#
class GlobalResource < ApplicationRecord
  PER_PAGE = 10
  acts_as_ordered_taggable
  strip_attributes

  enum resource_type: %i[image document]
  # enum content_type: %i[global content plot_point module_intro]

  belongs_to :customer, optional: true

  has_many :world_global_resources
  has_many :worlds, through: :world_global_resources

  has_one_attached :attachment

  validates :customer_id, presence: true, if: :private?
  # validates :title, presence: true

  validates :resource_type, :attachment, presence: true
  validate :validate_attachment

  scope :with_image, lambda {
                       where(resource_type:
                                     GlobalResource.resource_types['image'])
                     }
  scope :with_document, lambda {
                          where(resource_type:
                                   GlobalResource.resource_types['document'])
                        }

  # Validate attachment type
  def validate_attachment
    if attachment.attached? && image? && !valid_image?
      errors.add(:document, 'Must be a jpg, jpeg or png')
    elsif attachment.attached? && document? && !valid_document?
      errors.add(:document, 'Must be a PDF or a DOC file')
    end
  end

  # Used for searching Global Resource
  def self.search(keyword)
    where("active_storage_blobs.filename ilike :search or LOWER(cached_tag_list)
     ILIKE :search", search: "%#{keyword.downcase}%")
  end

  private

  def valid_document?
    attachment.content_type.in?(%w[application/docx application/doc
                                   application/pdf])
  end

  def valid_image?
    attachment.content_type.in?(%w[image/jpeg image/jpg image/png])
  end
end
