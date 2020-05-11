require "rails_helper"

RSpec.describe EmailInteractionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/email_interactions").to route_to("email_interactions#index")
    end

    it "routes to #show" do
      expect(:get => "/email_interactions/1").to route_to("email_interactions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/email_interactions").to route_to("email_interactions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/email_interactions/1").to route_to("email_interactions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/email_interactions/1").to route_to("email_interactions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/email_interactions/1").to route_to("email_interactions#destroy", :id => "1")
    end
  end
end
