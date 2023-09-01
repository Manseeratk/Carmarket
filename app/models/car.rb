class Car < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  belongs_to :car_category
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :make, presence: true, length: { minimum: 2, maximum: 50 }
  validates :model, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :on_sale, inclusion: { in: [true, false] }

  def self.ransackable_attributes(_auth_object = nil)
    ["created_at", "description", "id", "make", "model", "name", "updated_at", "variant",
     "on_sale"]
  end
end
