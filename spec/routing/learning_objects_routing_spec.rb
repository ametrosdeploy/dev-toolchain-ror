require "rails_helper"

RSpec.describe LearningObjectsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/learning_objects").to route_to("learning_objects#index")
    end

    it "routes to #show" do
      expect(:get => "/learning_objects/1").to route_to("learning_objects#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/learning_objects").to route_to("learning_objects#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/learning_objects/1").to route_to("learning_objects#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/learning_objects/1").to route_to("learning_objects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/learning_objects/1").to route_to("learning_objects#destroy", :id => "1")
    end
  end
end
