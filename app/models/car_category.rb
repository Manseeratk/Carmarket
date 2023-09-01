class CarCategory < ApplicationRecord
  has_many :cars

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["cars"]
  end
end
