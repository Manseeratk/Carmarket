class Order < ApplicationRecord
  belongs_to :user
  serialize :line_items, Array

  validates :customer_name, presence: true
  validates :phone_no, presence: true,
                       format:   { with: /\A\d{10}\z/, message: "should be a 10-digit number" }
  validates :shipping_address, presence: true
  validates :status, presence: true
  validates :total, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "customer_name", "id", "line_items", "phone_no", "province", "shipping_address",
     "status", "total", "updated_at", "user_id", "gst_rate", "pst_rate", "hst_rate", "tax_rate"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["user"]
  end
end
