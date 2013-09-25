require "spec_helper"

describe HostingsController do
  describe "routing" do

    it "routes to #index" do
      get("/hostings").should route_to("hostings#index")
    end

    it "routes to #new" do
      get("/hostings/new").should route_to("hostings#new")
    end

    it "routes to #show" do
      get("/hostings/1").should route_to("hostings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hostings/1/edit").should route_to("hostings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hostings").should route_to("hostings#create")
    end

    it "routes to #update" do
      put("/hostings/1").should route_to("hostings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hostings/1").should route_to("hostings#destroy", :id => "1")
    end

  end
end
