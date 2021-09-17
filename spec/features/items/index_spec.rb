require 'rails_helper'

RSpec.describe "Merchant item index" do
  before :each do
    @merch1 = Merchant.create!(name: "Douglas Olson")
    @item1 = @merch1.items.create!(name: "Polly Pocket", description: "So pretty", unit_price: 862, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item2 = @merch1.items.create!(name: "Cabbage Patch Doll", description: "Cute", unit_price: 1239, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item3 = @merch1.items.create!(name: "Teddy Ruxpin", description: "Creepy", unit_price: 1543, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item4 = @merch1.items.create!(name: "Barbie", description: "Gorgeous", unit_price: 2183, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @merch2 = Merchant.create!(name: "Sarah Carter")
    @item5 = @merch2.items.create!(name: "GI Joe", description: "Imperialism", unit_price: 743, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it "lists all of the merchants' items' names" do
    visit merchant_items_path(@merch1)

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).to have_content(@item4.name)
  end

  it "doesn't list any other merchants' items" do
    visit merchant_items_path(@merch1)
    expect(page).to have_no_content(@item5.name)
  end

  it "links each item's name to its show page" do
    visit merchant_items_path(@merch1)
    expect(page).to have_link("#{@item1.name}")
    click_link "#{@item1.name}"
    expect(current_path).to eq(merchant_item_path(@item1))

    # visit merchant_items_path(@merch1.id)
    #
    # expect(page).to have_link("#{@item2.name}")
    # click_link "#{@item2.name}"
    # expect(current_path).to eq(merchant_item_path(@item2))
  end
end
