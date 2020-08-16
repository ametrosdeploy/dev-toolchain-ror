class GenerateFinalEvalService < BaseService
  include WickedPdf::WickedPdfHelper::Assets
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::NumberHelper

  def initialize json_data
    # @user_section = user_section
    @json_data = json_data
    # set_data
  end

  def generate_pdf
    # if complete?
      @view                      = ActionView::Base.new(ActionController::Base.view_paths, {})
      content                    = File.read('templates/final_evaluation.html.erb')
      template                   = ERB.new(content)
      pdf                        = WickedPdf.new.pdf_from_string(template.result(binding), show_as_html: true)
      debugger

      save_path = Rails.root.join('storage','filename.pdf')
      File.open(save_path, 'wb') do |file|
        file << pdf
      end
     # end
  end

 # def set_data
 #    final_data = FinalEvaluationService.new(@user_section).call
 #    @json_data = {
 #      data: final_data,
 #      final_debrief_overview: @user_section.learn_mod.final_debrief_overview,
 #      name: @user_section.learn_mod.name
 #    }
 # end

 def complete?
   @user_section.complete?
 end
end
