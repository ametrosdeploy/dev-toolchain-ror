# frozen_string_literal: true

require 'httparty'
# IBM Service for resource creation ...
module IbmService
  URL = 'https://resource-controller.cloud.ibm.com/v2/resource_instances'
  LITE_PLAN_ID = 'bd16e38-3da0-11e6-bce3-54ee75149186'
  PLUS_TRIAL_PLAN_ID = 'a7c3614c-c75f-4c45-85e4-0626492539d3'
  STANDARD_PLAN_ID = 'd9c80e46-3195-11e6-a92b-54ee7514918e'
  PLUS_PLAN_ID = 'f0a3dd47-b693-4d73-a8df-aa6baf07a933'
  PREMIUM_PLAN_ID = '45333bd7-79f5-475f-9b14-9fe99734592a'

  def self.generate_instance(name)
    response = HTTParty.post(URL, body: body_hsh(name),
                                  headers: header_hsh)
    response ? response['guid'] : nil
  end

  def self.body_hsh(instance_name)
    {  "name": instance_name, "target": 'us-south',
       "resource_group": ENV['IBM_RESOURCE_GROUP'],
       "resource_plan_id": PLUS_TRIAL_PLAN_ID,
       "tags": ['ELP_generated'] }.to_json
  end

  def self.header_hsh
    auth_token = ibm_auth_token
    return nil unless auth_token

    { 'Content-Type': 'application/json',
      'Authorization': "Bearer #{auth_token}" }
  end

  def self.ibm_auth_token
    api_key = ENV['IBM_IAM_API_KEY']
    iam_token_url = 'https://iam.cloud.ibm.com/identity/token'
    query = {
      'grant_type': 'urn:ibm:params:oauth:grant-type:apikey',
      'apikey': api_key
    }
    headers = { 'Content-Type': 'application/x-www-form-urlencoded',
                'Accept': 'application/json' }
    response = HTTParty.post(iam_token_url, query: query, headers: headers)
    response.blank? ? nil : response['access_token']
  end
end
