require 'rails_helper'

RSpec.describe "indicators/show", :type => :view do
  before(:each) do
    @indicator = assign(:indicator, Indicator.create!(
      :credit_company => 1,
      :file_name => "File Name",
      :indicator_1 => "9.99",
      :indicator_2 => "9.99",
      :indicator_3 => "9.99",
      :status => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/File Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/2/)
  end
end
