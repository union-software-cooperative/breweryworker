require "rails_helper"

describe SupergroupsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/en/1/companies")).to route_to("supergroups#index", type: "Company", division_id: "1", locale: "en")
    end

    it "routes to #new" do
      expect(get("/en/1/companies/new")).to route_to("supergroups#new", type: "Company", division_id: "1", locale: "en")
    end

    it "routes to #show" do
      expect(get("/en/1/companies/1")).to route_to("supergroups#show", id: "1", type: "Company", division_id: "1", locale: "en")
    end

    it "routes to #edit" do
      expect(get("/en/1/companies/1/edit")).to route_to("supergroups#edit", id: "1", type: "Company", division_id: "1", locale: "en")
    end

    it "routes to #create" do
      expect(post("/en/1/companies")).to route_to("supergroups#create", type: "Company", division_id: "1", locale: "en")
    end

    it "routes to #update" do
      expect(put("/en/1/companies/1")).to route_to("supergroups#update", id: "1", type: "Company", division_id: "1", locale: "en")
    end

    it "routes to #destroy" do
      expect(delete("/en/1/companies/1")).to route_to("supergroups#destroy", id: "1", type: "Company", division_id: "1", locale: "en")
    end

    it "routes to #index" do
      expect(get("/en/1/unions")).to route_to("supergroups#index", type: "Union", division_id: "1", locale: "en")
    end

    it "routes to #new" do
      expect(get("/en/1/unions/new")).to route_to("supergroups#new", type: "Union", division_id: "1", locale: "en")
    end

    it "routes to #show" do
      expect(get("/en/1/unions/1")).to route_to("supergroups#show", id: "1", type: "Union", division_id: "1", locale: "en")
    end

    it "routes to #edit" do
      expect(get("/en/1/unions/1/edit")).to route_to("supergroups#edit", id: "1", type: "Union", division_id: "1", locale: "en")
    end

    it "routes to #create" do
      expect(post("/en/1/unions")).to route_to("supergroups#create", type: "Union", division_id: "1", locale: "en")
    end

    it "routes to #update" do
      expect(put("/en/1/unions/1")).to route_to("supergroups#update", id: "1", type: "Union", division_id: "1", locale: "en")
    end

    it "routes to #destroy" do
      expect(delete("/en/1/unions/1")).to route_to("supergroups#destroy", id: "1", type: "Union", division_id: "1", locale: "en")
    end
  end
end
