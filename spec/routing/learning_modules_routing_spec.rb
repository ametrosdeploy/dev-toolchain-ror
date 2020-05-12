require "rails_helper"

RSpec.describe LearningModulesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/learning_modules").to route_to("learning_modules#index")
    end

    it "routes to #show" do
      expect(:get => "/learning_modules/1").to route_to("learning_modules#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/learning_modules").to route_to("learning_modules#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/learning_modules/1").to route_to("learning_modules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/learning_modules/1").to route_to("learning_modules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/learning_modules/1").to route_to("learning_modules#destroy", :id => "1")
    end
  end
end
