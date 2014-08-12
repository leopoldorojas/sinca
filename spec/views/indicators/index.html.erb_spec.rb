require 'rails_helper'

RSpec.describe "indicators/index", :type => :view do
  before(:each) do
    assign(:indicators, [
      Indicator.create!(
        :credit_company => 1,
        :file_name => "File Name",
        :indicator_1 => "9.99",
        :indicator_2 => "9.99",
        :indicator_3 => "9.99",
        :status => 2
      ),
      Indicator.create!(
        :credit_company => 1,
        :file_name => "File Name",
        :indicator_1 => "9.99",
        :indicator_2 => "9.99",
        :indicator_3 => "9.99",
        :status => 2
      )
    ])
  end

  it "renders a list of indicators" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "File Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
