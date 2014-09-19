require 'rails_helper'

RSpec.describe "credit_companies/new", :type => :view do
  before(:each) do
    assign(:credit_company, CreditCompany.new(
      :name => "MyString",
      :identifier => "MyString",
      :contact => "MyString",
      :phone => "MyString",
      :email => "MyString",
      :website => "MyString",
      :location => nil
    ))
  end

  it "renders new credit_company form" do
    render

    assert_select "form[action=?][method=?]", credit_companies_path, "post" do

      assert_select "input#credit_company_name[name=?]", "credit_company[name]"

      assert_select "input#credit_company_identifier[name=?]", "credit_company[identifier]"

      assert_select "input#credit_company_contact[name=?]", "credit_company[contact]"

      assert_select "input#credit_company_phone[name=?]", "credit_company[phone]"

      assert_select "input#credit_company_email[name=?]", "credit_company[email]"

      assert_select "input#credit_company_website[name=?]", "credit_company[website]"

      assert_select "input#credit_company_location_id[name=?]", "credit_company[location_id]"
    end
  end
end
