# frozen_string_literal: true

class Api::Admin::V1::ChatLearnObjsController < Api::Admin::V1::BaseController
    before_action :set_chat_learn_obj, only: %i[import_skills]
    CHAT_LO_ID = 'Chat Learn Obj ID'

    def import_skills 

    end
  
  
    swagger_controller :chat_learn_obj, 'Chat Learn Obj'
  
    swagger_api :import_skills do
        summary 'Import skills from Assistant'
        notes 'Should be used to import skills from Assistant dialog skill dialog nodes'
        param :header, :Authorization, :string, :required, 'Authorization'
        param :path, 'id', :integer,
              :required, CHAT_LO_ID
    end
    
  
    private
  
    def set_chat_learn_obj
      @chat_lo = ChatLearnObj.find(params[:id])
      @lo = @chat_lo.learning_object
    end
  
    
  end
  