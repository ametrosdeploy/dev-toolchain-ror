require "rails_helper"

RSpec.describe ChatLearnObjsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/chat_learn_objs").to route_to("chat_learn_objs#index")
    end

    it "routes to #show" do
      expect(:get => "/chat_learn_objs/1").to route_to("chat_learn_objs#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/chat_learn_objs").to route_to("chat_learn_objs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/chat_learn_objs/1").to route_to("chat_learn_objs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/chat_learn_objs/1").to route_to("chat_learn_objs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/chat_learn_objs/1").to route_to("chat_learn_objs#destroy", :id => "1")
    end
  end
end
