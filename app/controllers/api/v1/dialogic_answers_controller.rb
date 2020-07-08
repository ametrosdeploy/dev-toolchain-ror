# frozen_string_literal: true

class Api::V1::DialogicAnswersController < Api::V1::BaseController
  before_action :set_evaluation_obj, only: %i[index create next_questions]
  before_action :set_dialogic_answer, only: %i[show update destroy]

  # GET /dialogic_answers
  def index
    @dialogic_answers = @evaluation_obj.dialogic_answers
    render json: serialize_rec(@dialogic_answers)
  end

  # GET /dialogic_answers/1
  # def show
  #   render json: @dialogic_answer
  # end

  # POST /dialogic_answers
  def create
    @dialogic_ans = @evaluation_obj.dialogic_answers
                                   .create(dialogic_answer_params)
    hanlder = EvaluationHandler::Dialogic::QuestionEvaluator.new(@dialogic_ans)
    hanlder.evaluate
    if @dialogic_ans.save
      render json: serialize_rec(@dialogic_ans), status: :created
    else
      render json: @dialogic_ans.errors, status: :unprocessable_entity
    end
  end

  def questions
    # If dialogic is complete
    # Clear all the save data & Retry Again

    # @user_learn_objs = UserLearnObj.find(params[:user_learn_obj_id])
    @var_ids = if @evaluation_obj.complete? &.clear_answers_debriefs
               &.increment(:repeat_count)
                 @evaluation_obj.new_variation_set
                 # Reset complete
               else
                 @evaluation_obj.variation_order_ids
               end
    @variations = QuestionVariation.find(@var_ids)
    render json: serialize_rec(@variations)
  end

  # PATCH/PUT /dialogic_answers/1
  # def update
  #   if @dialogic_answer.update(dialogic_answer_params)
  #     render json: @dialogic_answer
  #   else
  #     render json: @dialogic_answer.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /dialogic_answers/1
  # def destroy
  #   @dialogic_answer.destroy
  # end

  swagger_controller :dialogic_answers, 'Dialogic Answers'

  swagger_api :index do
    summary 'Get learner answers with question'
    notes 'Should be used to get Get learner answers with question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_evaluation_id', :integer, :required,
          'dialogic_evaluation_id'
    response :unauthorized
  end

  swagger_api :create do
    summary 'Creates and evaluates a learner answer to question'
    notes 'Should be used to creates and evaluates a learner answer to question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'dialogic_evaluation_id', :integer, :required,
          'dialogic_evaluation_id'
    param :form, 'dialogic_answer[dialogic_question_id]', :string, :required,
          'dialogic_question_id'
    param :form, 'dialogic_answer[answer]', :string, :required
    param :form, 'dialogic_answer[follow_up_answer]', :boolean, :optional,
          'Set to true if response of a follow-up question'
    response :unauthorized
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_answer
    @dialogic_answer = DialogicAnswer.find(params[:id])
  end

  def set_evaluation_obj
    @evaluation_obj = DialogicEvaluation.find(params[:dialogic_evaluation_id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_answer_params
    params.require(:dialogic_answer).permit(:dialogic_evaluation_id,
                                            :dialogic_question_id,
                                            :answer, :evaluated,
                                            :follow_up_answer)
  end

  def serializer
    Learner::DialogicAnswerSerializer
  end
end
