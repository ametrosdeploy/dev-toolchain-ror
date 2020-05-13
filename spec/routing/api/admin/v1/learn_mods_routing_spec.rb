require "rails_helper"

RSpec.describe Api::Admin::V1::LearnModsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/admin/v1/learn_mods").to route_to("api/admin/v1/learn_mods#index")
    end

    it "routes to #show" do
      expect(:get => "/api/admin/v1/learn_mods/1").to route_to("api/admin/v1/learn_mods#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/admin/v1/learn_mods").to route_to("api/admin/v1/learn_mods#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/admin/v1/learn_mods/1").to route_to("api/admin/v1/learn_mods#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/admin/v1/learn_mods/1").to route_to("api/admin/v1/learn_mods#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/admin/v1/learn_mods/1").to route_to("api/admin/v1/learn_mods#destroy", :id => "1")
    end
  end
end
