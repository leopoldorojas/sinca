require 'rails_helper'

RSpec.describe "credit_companies/show", :type => :view do
  before(:each) do
    @credit_company = assign(:credit_company, CreditCompany.create!(
      :name => "Name",
      :identifier => "Identifier",
      :contact => "Contact",
      :phone => "Phone",
      :email => "Email",
      :website => "Website",
      :location => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Contact/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Website/)
    expect(rendered).to match(//)
  end
end
