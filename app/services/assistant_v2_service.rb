# frozen_string_literal: true

require 'json'
require 'ibm_watson/authenticators'
require 'ibm_watson/assistant_v2'

# Watson Assistant related requests
class AssistantV2Service < BaseService
  include IBMWatson

  def initialize(assistant_api_key, assistant_id)
    super()
    base_url = ENV['ASST_SERVICE_BASE_URL'].chomp("/instances/")
    @assistant_v2 = connect_assistant_v2(base_url, assistant_api_key)
  end

  def connect_assistant_v2(base_url, assistant_api_key)
    authenticator = Authenticators::IamAuthenticator.new(
      apikey: assistant_api_key
    )
    @assistant_v2 = AssistantV2.new(
      version: '2020-04-01',
      authenticator: authenticator
    )
    @assistant_v2.service_url = base_url
    @assistant_v2
  end


  def create_assistant_session(assistant_id) 
    @assistant_v2.create_session(
      assistant_id: assistant_id
    )
  end

  def send_test_message_to_assistant(test_chat_message_id, assistant_id, session_id, test_message)
    @assistant_v2.message(
      assistant_id: assistant_id, 
      session_id: session_id, 
      input: {
        text: test_message
      }
    )
  end 

  def send_message_to_assistant(assistant_id, session_id, message)
    @assistant_v2.message(
      assistant_id: assistant_id, 
      session_id: session_id, 
      input: {
        text: message
      }
    )
  end 

end
