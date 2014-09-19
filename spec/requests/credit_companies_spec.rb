require 'rails_helper'

RSpec.describe "CreditCompanies", :type => :request do
  describe "GET /credit_companies" do
    it "works! (now write some real specs)" do
      get credit_companies_path
      expect(response.status).to be(200)
    end
  end
end
