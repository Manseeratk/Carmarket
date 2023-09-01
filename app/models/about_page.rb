class AboutPage < ApplicationRecord
  validates :content, presence: true
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }

  def self.ransackable_attributes(_auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at"]
  end
end
