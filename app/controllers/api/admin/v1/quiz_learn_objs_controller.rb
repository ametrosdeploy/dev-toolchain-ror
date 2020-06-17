# frozen_string_literal: true

class Api::Admin::V1::QuizLearnObjsController < Api::Admin::V1::BaseController
  before_action :set_quiz_learn_obj, only: %i[show update destroy]

  def show
    render json: serialize_rec(@quiz_learn_obj)
  end

  def update
    if @quiz_learn_obj.update(quiz_lo_params)
      render json: serialize_rec(@quiz_learn_obj)
    else
      render json: @quiz_learn_obj.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @quiz_learn_obj.destroy
  end

  swagger_controller :quiz_learn_objs, 'Quiz Learning Object', resource_path:
     '/api/admin/v1/quiz_learn_objs'
  swagger_api :show do
    summary 'Show Quiz Learning Object'
    notes 'Should be used to show a quiz learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Quiz LO ID'
  end

  swagger_api :update do
    summary 'Update quiz learning object'
    notes 'Should be used to update a quiz learning object'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :integer, :required, 'Quiz learning object ID'
    param :form, 'quiz_learn_obj[title]', :string, :required
    param :form, 'quiz_learn_obj[description]', :string, :required
    param :form, 'quiz_learn_obj[score_view_type]', :string, :required,
          'Options: "multiple_choice", "numeric", "percentage", "no_score"'
  end

  swagger_api :destroy do
    summary 'Destroy a quiz question'
    notes 'Should be used to destroy a quiz question'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'quiz_learn_obj_id', :integer, :required, 'Quiz LO ID'
    param :path, 'id', :integer, :required, 'Quiz Question ID'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quiz_learn_obj
    @quiz_learn_obj = QuizLearnObj.find(params[:id])
  end

  def serializer
    QuizLearnObjSerializer
  end

  def quiz_lo_params; end
end
