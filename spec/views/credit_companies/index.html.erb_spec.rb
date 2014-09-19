require 'rails_helper'

RSpec.describe "credit_companies/index", :type => :view do
  before(:each) do
    assign(:credit_companies, [
      CreditCompany.create!(
        :name => "Name",
        :identifier => "Identifier",
        :contact => "Contact",
        :phone => "Phone",
        :email => "Email",
        :website => "Website",
        :location => nil
      ),
      CreditCompany.create!(
        :name => "Name",
        :identifier => "Identifier",
        :contact => "Contact",
        :phone => "Phone",
        :email => "Email",
        :website => "Website",
        :location => nil
      )
    ])
  end

  it "renders a list of credit_companies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
