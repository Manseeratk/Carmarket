class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :province

  def self.ransackable_attributes(_auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "id", "province_id",
     "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
