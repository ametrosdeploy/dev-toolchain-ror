require "rails_helper"

RSpec.describe DialogicInteractionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/dialogic_interactions").to route_to("dialogic_interactions#index")
    end

    it "routes to #show" do
      expect(:get => "/dialogic_interactions/1").to route_to("dialogic_interactions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/dialogic_interactions").to route_to("dialogic_interactions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dialogic_interactions/1").to route_to("dialogic_interactions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dialogic_interactions/1").to route_to("dialogic_interactions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dialogic_interactions/1").to route_to("dialogic_interactions#destroy", :id => "1")
    end
  end
end
