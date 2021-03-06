require 'rails_helper'

RSpec.describe "indicators/edit", :type => :view do
  before(:each) do
    @indicator = assign(:indicator, Indicator.create!(
      :credit_company => 1,
      :file_name => "MyString",
      :indicator_1 => "9.99",
      :indicator_2 => "9.99",
      :indicator_3 => "9.99",
      :status => 1
    ))
  end

  it "renders the edit indicator form" do
    render

    assert_select "form[action=?][method=?]", indicator_path(@indicator), "post" do

      assert_select "input#indicator_credit_company[name=?]", "indicator[credit_company]"

      assert_select "input#indicator_file_name[name=?]", "indicator[file_name]"

      assert_select "input#indicator_indicator_1[name=?]", "indicator[indicator_1]"

      assert_select "input#indicator_indicator_2[name=?]", "indicator[indicator_2]"

      assert_select "input#indicator_indicator_3[name=?]", "indicator[indicator_3]"

      assert_select "input#indicator_status[name=?]", "indicator[status]"
    end
  end
end
