require "rails_helper"

RSpec.describe EmailResponsesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/email_responses").to route_to("email_responses#index")
    end

    it "routes to #show" do
      expect(:get => "/email_responses/1").to route_to("email_responses#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/email_responses").to route_to("email_responses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/email_responses/1").to route_to("email_responses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/email_responses/1").to route_to("email_responses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/email_responses/1").to route_to("email_responses#destroy", :id => "1")
    end
  end
end
