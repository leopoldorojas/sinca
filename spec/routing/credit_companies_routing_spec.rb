require "rails_helper"

RSpec.describe CreditCompaniesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/credit_companies").to route_to("credit_companies#index")
    end

    it "routes to #new" do
      expect(:get => "/credit_companies/new").to route_to("credit_companies#new")
    end

    it "routes to #show" do
      expect(:get => "/credit_companies/1").to route_to("credit_companies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/credit_companies/1/edit").to route_to("credit_companies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/credit_companies").to route_to("credit_companies#create")
    end

    it "routes to #update" do
      expect(:put => "/credit_companies/1").to route_to("credit_companies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/credit_companies/1").to route_to("credit_companies#destroy", :id => "1")
    end

  end
end
