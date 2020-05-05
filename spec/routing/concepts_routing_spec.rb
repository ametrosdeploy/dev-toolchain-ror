require "rails_helper"

RSpec.describe ConceptsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/concepts").to route_to("concepts#index")
    end

    it "routes to #show" do
      expect(:get => "/concepts/1").to route_to("concepts#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/concepts").to route_to("concepts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/concepts/1").to route_to("concepts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/concepts/1").to route_to("concepts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/concepts/1").to route_to("concepts#destroy", :id => "1")
    end
  end
end
