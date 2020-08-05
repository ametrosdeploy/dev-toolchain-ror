require "rails_helper"

RSpec.describe Api::Admin::V1::TestEmailIterationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/test_email_iterations").to route_to("test_email_iterations#index")
    end

    it "routes to #show" do
      expect(:get => "/test_email_iterations/1").to route_to("test_email_iterations#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/test_email_iterations").to route_to("test_email_iterations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_email_iterations/1").to route_to("test_email_iterations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_email_iterations/1").to route_to("test_email_iterations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_email_iterations/1").to route_to("test_email_iterations#destroy", :id => "1")
    end
  end
end
