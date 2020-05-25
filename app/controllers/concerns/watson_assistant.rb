require "ibm_watson/authenticators"
require "ibm_watson/assistant_v1"
require 'httparty'

module WatsonAssistant
    extend ActiveSupport::Concern
    include IBMWatson
  
    class_methods do
        def create_assistant_service(name)
            auth_token = get_iam_token
            url =  'https://resource-controller.cloud.ibm.com/v2/resource_instances'
            result = HTTParty.post(url.to_str, 
            :body => { 
                    "name": name,
                        "target": "us-south",
                        "resource_group": "5ce29e5ae841428ca71e7bb506615ce7",
                        "resource_plan_id": "a7c3614c-c75f-4c45-85e4-0626492539d3",
                        "tags": [
                        "api-created-resource"
                        ]
                    }.to_json,
            :headers => { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{auth_token}" })
            # To get the credentials required ...
            id = result['id']
            credentials = get_assistant_credentials(id, auth_token)
        end
        
        def get_assistant_credentials(id, auth_token)
            url = "https://resource-controller.cloud.ibm.com/v2/resource_keys/#{id}"
            result = HTTParty.get(url, :headers => {'Authorization' => "Bearer #{auth_token}" })
            result['resources'].last['credentials']  # check why many resources here....
        end
        
        def get_iam_token
            api_key  = ENV['IBM_IAM_API_KEY']
            iam_token_url  = "https://iam.cloud.ibm.com/identity/token"
            query = { 
                'grant_type': "urn:ibm:params:oauth:grant-type:apikey",
                'apikey': api_key
            }
            headers = {'Content-Type' => 'application/x-www-form-urlencoded', 'Accept' => 'application/json' }
            ibm_response = HTTParty.post(iam_token_url.to_str, :query => query, :headers => headers)
            ibm_response['access_token']
        end
    end
end
  