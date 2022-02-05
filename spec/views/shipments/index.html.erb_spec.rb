require 'rails_helper'

RSpec.describe "shipments/index", type: :view do
  before(:each) do
    assign(:shipments, [
      Shipment.create!(
        user: nil,
        name: "Name",
        company_name: "Company Name",
        reference_number: "Reference Number"
      ),
      Shipment.create!(
        user: nil,
        name: "Name",
        company_name: "Company Name",
        reference_number: "Reference Number"
      )
    ])
  end

  it "renders a list of shipments" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Company Name".to_s, count: 2
    assert_select "tr>td", text: "Reference Number".to_s, count: 2
  end
end
