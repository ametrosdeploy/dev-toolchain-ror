# frozen_string_literal: true

require 'httparty'
module WatsonAssistant
  # This is for Watson assistant service creation ...
  module ServiceGenerator
    extend ActiveSupport::Concern
    URL = 'https://resource-controller.cloud.ibm.com/v2/resource_instances'
    LITE_PLAN_ID = 'bd16e38-3da0-11e6-bce3-54ee75149186'
    PLUS_TRIAL_PLAN_ID = 'a7c3614c-c75f-4c45-85e4-0626492539d3'
    STANDARD_PLAN_ID = 'd9c80e46-3195-11e6-a92b-54ee7514918e'
    PLUS_PLAN_ID = 'f0a3dd47-b693-4d73-a8df-aa6baf07a933'
    PREMIUM_PLAN_ID = '45333bd7-79f5-475f-9b14-9fe99734592a'
    RESOURCE_GROUP = '5ce29e5ae841428ca71e7bb506615ce7'

    def generate_instance
      instance_name = 'NEW TEST ASSISTANT VIA API'
      auth_token = ibm_auth_token
      return nil unless auth_token

      puts 'Auth token generated...'
      response = HTTParty.post(URL,
                               body: {
                                 "name": instance_name,
                                 "target": 'us-south',
                                 "resource_group": RESOURCE_GROUP,
                                 "resource_plan_id": STANDARD_PLAN_ID,
                                 "tags": ['api-created-resource']
                               }.to_json,
                               headers: { 'Content-Type': 'application/json', 'Authorization': "Bearer #{auth_token}" })
      puts 'Instance Created Successfully!...' if response
      # instance_id = response['id']
      instance_credentials(auth_token)
      # Save instance credentials
    end

    def instance_credentials(auth_token = nil)
      auth_token ||= ibm_auth_token
      credentials_url = 'https://resource-controller.cloud.ibm.com/v2/resource_keys/'
      response = HTTParty.get(credentials_url.to_s, headers: { 'Authorization': "Bearer #{auth_token}" })
      resources = response['resources']
      resource = resources.last
      puts "recource: #{resource}..." if resource
      credentials = resource['credentials'] # instance of last - proper selection is required ...
      puts "credentials: #{credentials}..."
      instance_api_key(credentials)
    end

    def instance_api_key(credentials)
      apikey = credentials['apikey']
      url = credentials['url']
      # Store credentials
    end

    def ibm_auth_token
      api_key = ENV['IBM_IAM_API_KEY']
      iam_token_url = 'https://iam.cloud.ibm.com/identity/token'
      query = {
                'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
                'apikey': api_key
      }
      headers = { 'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json' }
      response = HTTParty.post(iam_token_url, query: query, headers: headers)
      response.blank? ? nil : response['access_token']
    end
  end
end
