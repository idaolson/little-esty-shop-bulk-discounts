class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_customers
    joins(:transactions).select("customers.*, count('transactions.result') as trans_count")
                        .where("result = ?", 1)
                        .group(:id)
                        .order(trans_count: :desc)
                        .limit(5)
  end

  def number_of_transactions
    transactions.where("result = ?", 1).count
  end

  def self.top_merchant_customers(merch_id)
    joins(:transactions)
    .select("customers.*, count('transactions.result') as trans_count")
    .where("result = 1")
    .where("transactions.invoice_id IN (?)",
           Item.joins(:invoice_items)
               .select(:id,'invoice_items.invoice_id AS invoice_id')
               .where(merchant_id: merch_id)
               .pluck('invoice_id')
               .uniq)
    .group(:id)
    .order(trans_count: :desc)
    .limit(5)
  end
end
