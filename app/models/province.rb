class Province < ApplicationRecord
  validates :name, presence: true
  validates :gst_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pst_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :users, dependent: :destroy
  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "gst_rate", "hst_rate", "id", "name", "pst_rate", "tax_rate", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["users"]
  end
end
