require 'rails_helper'

RSpec.describe "shipments/show", type: :view do
  before(:each) do
    @shipment = assign(:shipment, Shipment.create!(
      user: nil,
      name: "Name",
      company_name: "Company Name",
      reference_number: "Reference Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Company Name/)
    expect(rendered).to match(/Reference Number/)
  end
end
