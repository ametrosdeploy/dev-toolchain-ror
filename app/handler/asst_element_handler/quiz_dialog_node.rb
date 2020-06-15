# frozen_string_literal: true

module AsstElementHandler
  # Quiz Learn Object

  # Currently used only for Quiz Lo; where the dialog node
  # setup per question not for entire LO
  class QuizDialogNode < AsstElementHandler::Base
    def initialize(args)
      super
      @question = args[:question]
      @eval = args[:entity_eval]
      @name = "question-#{@question.id}"
      prep_output_arg
    end

    def prep_condition
      conditions = evaluations&.pluck(:condition)
      cond_arr = add_intent_check_condition(conditions)
      cond_arr&.join('||')
    end

    def prep_output_arg
      @responses = []
      @responses << { response_type: 'text',
                      values: [{ text: 'Correct' }] }
    end

    def add_intent_check_condition(eval_arr)
      intent = "##{@name} && "
      eval_arr.map { |eval| eval.prepend(intent) }
    end

    def evaluations
      @question.entity_evaluations
    end

    def node_already_created?
      # it is expected that once first eval is added for a question,
      # Asst node will be created in Watson
      evaluations.count > 1
    end

    def create_or_update_dialog_node
      condition = prep_condition
      node_already_created? ? update_dialog_node : create_dialog_node
     end

    def create_dialog_node
      @assistant_service.create_dialog_node(@name, prep_condition,
                                            @name, @responses)
    end

    def update_dialog_node
      @assistant_service.update_dialog_node(@name,
                                            prep_condition)
    end

    def destroy_dialog_node
      @assistant_service.delete_dialog_node(@name)
    end
  end
end
