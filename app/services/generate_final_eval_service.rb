class GenerateFinalEvalService < BaseService
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
    save_path = Rails.root.join('tmp',"filename-#{@user_section.id}.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
    upload_to_s3(invoice_pdf, save_path)
  end

  def upload_to_s3(pdf_file, file_path)
    begin
      s3 = Aws::S3::Resource.new(access_key_id: ENV['IBM_ACCESS_KEY'], secret_access_key: ENV['IBM_SECRET'], region: ENV['IBM_REGION'])
      obj = s3.bucket('bucket-name').object('final_evaluation')
      obj.upload_file(file_path)
    rescue Exception => e
      raise e
    end
  end
end
