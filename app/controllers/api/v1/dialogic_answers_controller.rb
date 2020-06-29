# frozen_string_literal: true

class Api::V1::DialogicAnswersController < Api::V1::BaseController
  before_action :set_dialogic_answer, only: %i[show update destroy]

  # GET /dialogic_answers
  def index
    @dialogic_answers = DialogicAnswer.all

    render json: @dialogic_answers
  end

  # GET /dialogic_answers/1
  def show
    render json: @dialogic_answer
  end

  # POST /dialogic_answers
  def create
    @dialogic_answer = DialogicAnswer.new(dialogic_answer_params)

    if @dialogic_answer.save
      render json: serialize_rec(@dialogic_answer), status: :created, location: @dialogic_answer
    else
      render json: @dialogic_answer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dialogic_answers/1
  def update
    if @dialogic_answer.update(dialogic_answer_params)
      render json: @dialogic_answer
    else
      render json: @dialogic_answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dialogic_answers/1
  def destroy
    @dialogic_answer.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dialogic_answer
    @dialogic_answer = DialogicAnswer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def dialogic_answer_params
    params.require(:dialogic_answer).permit(:dialogic_evaluation_id, :dialogic_question_id, :answer, :evaluated, :follow_up_answer)
  end

  def serializer
    Learner::DialogicAnswerSerializer
  end
end
