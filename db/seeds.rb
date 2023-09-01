# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'httparty'

# Method to fetch car images from Unsplash
def get_random_car_image
  images_directory = Rails.root.join('public', 'car_images')
  car_images = Dir.entries(images_directory).reject { |f| File.directory?(f) }
  car_images.sample
end


puts "Seeding data to the database ...."
AdminUser.destroy_all
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Car.destroy_all

categories = ['Sedan', 'SUV', 'Truck', 'Sports Car']

categories.each do |category_name|
  CarCategory.create!(name: category_name)
end

# Seed at least 100 cars with random data
num_cars = 100
num_cars.times do
  make = Faker::Vehicle.make
  model = Faker::Vehicle.model(make_of_model: make)
  variant = Faker::Vehicle.style
  description = Faker::Vehicle.standard_specs.join("\n")
  price = rand(10_000..100_000)

  # Randomly choose a car category for each car
  car_category = CarCategory.all.sample

  car = Car.create!(
    name: "#{make} #{model} #{variant}",
    description: description,
    make: make,
    model: model,
    variant: variant,
    car_category: car_category,
    price: price
  )

  image_filename = get_random_car_image
  if image_filename
    # Using Active Storage to attach the image
    file_path = Rails.root.join('public', 'car_images', image_filename)
    car.image.attach(io: File.open(file_path), filename: image_filename)
  end
  car
end

puts "#{num_cars} cars have been seeded!"

# Seed province data
Province.destroy_all

# Seed data for 30 provinces and territories with their tax rates
provinces_with_tax_rates = [
  { name: 'Alberta', gst_rate: 0.05, pst_rate: 0, hst_rate: 0 },
  { name: 'British Columbia', gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0 },
  { name: 'Manitoba', gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0 },
  { name: 'New Brunswick', gst_rate: 0.05, pst_rate: 0, hst_rate: 0.13 },
  # Add other provinces and territories with their tax rates
]

# Usage example: You can loop through this array to populate the database
provinces_with_tax_rates.each do |province_data|
Province.create!(province_data)
end
  
  
  
  
  
  