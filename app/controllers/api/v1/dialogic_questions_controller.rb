# frozen_string_literal: true

# Controller for Dialogic Questions
class Api::V1::DialogicQuestionsController < Api::V1::BaseController
  def index
    @user_learn_objs = UserLearnObj.find(params[:user_lo_id])
    @limit_exceed = false
    variations_ids = fetch_variations
    if @limit_exceed
      render json: limit_exceeded, status: :unprocessable_entity
    else
      @variations = QuestionVariation.find(variations_ids)
      render json: { variations: serialize_rec(@variations),
                     evaluation_id: @eval.try(:id) }
    end
  end

  swagger_controller :dialogic_questions, 'DialogicQuestion'

  swagger_api :index do
    summary 'Get Dialogic questions'
    notes 'Should be used for Dialogic Questions'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'dilogic_learn_obj_id', :integer, :required,
          'dilogic_learn_obj_id'
    param :query, 'user_lo_id', :integer, :required, 'User LO ID'
    param :query, 'retry', :boolean, :optional, 'Set to true when requesting
          for retry questions'
  end

  private

  def serializer
    Learner::QuestionVariationSerializer
  end

  def limit_exceeded
    {
      message: I18n.t(:dialogic_retry_exceed)
    }
  end

  def fetch_variations
    if retrying?
      if @user_learn_objs.retry_limit_remain?
        @eval = @user_learn_objs.dialogic_evaluations.build
        @eval.save && @eval.new_variation_set(params[:dilogic_learn_obj_id])
      else
        @limit_exceed = true
      end
    else
      @user_learn_objs.current_evaluation.variation_ids(dialogic_id)
    end
  end

  def retrying?
    params[:retry] == true || (params[:retry] == 'true')
  end

  def dialogic_id
    params[:dilogic_learn_obj_id]
  end
end
