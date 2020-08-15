class GenerateFinalEvalService < BaseService
  def initialize user_section
    @user_section = user_section
    set_data
  end

  def generate
    if complete?


     end
  end

 def set_data
    final_data = FinalEvaluationService.new(@user_section).call
    @json_data = {
      data: final_data,
      final_debrief_overview: @user_section.learn_mod.final_debrief_overview,
      name: @user_section.learn_mod.name
    }
 end

 def complete?
   @user_section.complete?
 end
end
