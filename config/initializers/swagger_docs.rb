# frozen_string_literal: true

# Swagger config
module Swagger
  module Docs
    # Swagger Config
    class Config
      def self.base_api_controller
        [ActionController::API, ActionController::Base]
      end

      def self.transform_path(path, _api_version)
        "apidocs/#{path}"
      end
    end
  end
end
Swagger::Docs::Config.register_apis({
                                      "1.0": {
                                        # the extension used for the API
                                        api_extension_type: :json,
                                        # the output location where your .json
                                        # files are written to
                                        api_file_path: 'public/apidocs',
                                        # the URL base path to your API
                                        base_path: ENV['BASE_URL'],
                                        # if you want to delete all .json files
                                        # at each generation
                                        clean_directory: false,
                                        # Ability to setup base controller for
                                        # each api version.
                                        # Api::V1::SomeController for example.
                                        # parent_controller:
                                        # Api::ApplicationController,
                                        # add custom attributes to api-docs
                                        attributes: {
                                          info: {
                                            title: 'Ametros API doc'
                                          }
                                        }
                                      }
                                    })
