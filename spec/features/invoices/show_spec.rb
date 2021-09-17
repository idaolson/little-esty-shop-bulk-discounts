require 'rails_helper'

RSpec.describe 'the merchant invoices show page' do
  before :each do
    @merch = create(:merchant)
    @merch2 = create(:merchant)
    @item1 = create(:item, merchant_id: @merch.id)
    @item2 = create(:item, merchant_id: @merch.id)
    @item3 = create(:item, merchant_id: @merch2.id)
    @cust = create(:customer)
    @invoice1 = create(:invoice, customer_id: @cust.id)
    @inv_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    @inv_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
    @inv_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id)
  end

  it "shows invoice attribues" do
    visit "/merchant/#{@merch.id}/invoices/#{@invoice1.id}"

    within('#attributes') do
      expect(page).to have_content("Invoice ##{@invoice1.id}")
      expect(page).to have_content("Status: #{@invoice1.status}")
      expect(page).to have_content("Created on: Tuesday, March 27, 2012")
      expect(page).to have_content("Customer: #{@cust.first_name} #{@cust.last_name}")
    end
  end

  it "shows invoice item" do
    visit "/merchant/#{@merch.id}/invoices/#{@invoice1.id}"

    sum1 = @item1.price_dollars(@inv_item1.quantity)
    within('#items') do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@inv_item1.quantity)
      expect(page).to have_content("$#{sum1}")
      expect(page).to have_content(@inv_item1.status)

      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end
  end

end
