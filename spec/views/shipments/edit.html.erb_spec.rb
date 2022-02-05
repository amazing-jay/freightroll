require 'rails_helper'

RSpec.describe "shipments/edit", type: :view do
  before(:each) do
    @shipment = assign(:shipment, Shipment.create!(
      user: nil,
      name: "MyString",
      company_name: "MyString",
      reference_number: "MyString"
    ))
  end

  it "renders the edit shipment form" do
    render

    assert_select "form[action=?][method=?]", shipment_path(@shipment), "post" do

      assert_select "input[name=?]", "shipment[user_id]"

      assert_select "input[name=?]", "shipment[name]"

      assert_select "input[name=?]", "shipment[company_name]"

      assert_select "input[name=?]", "shipment[reference_number]"
    end
  end
end
