require 'rails_helper'

RSpec.describe "shipments/new", type: :view do
  before(:each) do
    assign(:shipment, Shipment.new(
      user: nil,
      name: "MyString",
      company_name: "MyString",
      reference_number: "MyString"
    ))
  end

  it "renders new shipment form" do
    render

    assert_select "form[action=?][method=?]", shipments_path, "post" do

      assert_select "input[name=?]", "shipment[user_id]"

      assert_select "input[name=?]", "shipment[name]"

      assert_select "input[name=?]", "shipment[company_name]"

      assert_select "input[name=?]", "shipment[reference_number]"
    end
  end
end
