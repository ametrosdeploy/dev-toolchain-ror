class GenerateFinalEvalService < BaseService
  require 'aws-sdk-s3'
  include WickedPdf::WickedPdfHelper::Assets
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::NumberHelper

  def initialize json_data, user_section
    @user_section = user_section
    @json_data = json_data
  end

  def generate_pdf
    @view                      = ActionView::Base.new(ActionController::Base.view_paths, {})
    content                    = File.read('templates/final_evaluation.html.erb')
    template                   = ERB.new(content)
    pdf                        = WickedPdf.new.pdf_from_string(template.result(binding), show_as_html: true)
    file_name = "filename-#{@user_section.id}.pdf"
    save_path = Rails.root.join('tmp', file_name)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
    upload_to_s3(file_name, save_path)
  end

  def upload_to_s3(file_name, file_path)
    begin
      s3 = Aws::S3::Resource.new(access_key_id: ENV['IBM_ACCESS_KEY'],
                                 secret_access_key: ENV['IBM_SECRET'],
                                 region: ENV['IBM_REGION'],
                                 endpoint: ENV['IBM_ENDPOINT'] )
      obj = s3.bucket(ENV['IBM_BUCKET']).object('final_evaluation')
      obj.upload_file(file_path)

    rescue Exception => e
      raise e
    end
  end
end
