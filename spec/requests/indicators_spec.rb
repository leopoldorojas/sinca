require 'rails_helper'

RSpec.describe "Indicators", :type => :request do
  describe "GET /indicators" do
    it "works! (now write some real specs)" do
      get indicators_path
      expect(response.status).to be(200)
    end
  end
end
