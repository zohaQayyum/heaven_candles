OrderItem.destroy_all
Order.destroy_all
ProductVariant.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

# Create admin user
admin = User.create!(
  name: "Admin",
  email: "admin@heavencandles.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

# Create test user
user = User.create!(
  name: "Test User",
  email: "user@heavencandles.com",
  password: "password123",
  password_confirmation: "password123",
  role: :customer
)

# Create categories
home = Category.create!(name: "Home Decor")
relaxation = Category.create!(name: "Relaxation")
seasonal = Category.create!(name: "Seasonal")

# Create products
products_data = [
  { name: "Lavender Dreams", description: "A calming lavender scented candle perfect for bedtime relaxation.", category: relaxation },
  { name: "Vanilla Bliss", description: "Warm vanilla fragrance that fills your room with a cozy, sweet aroma.", category: home },
  { name: "Rose Garden", description: "Delicate rose petals infused in a soft pink candle for a romantic atmosphere.", category: home },
  { name: "Ocean Breeze", description: "Fresh aquatic scent that brings the calming feeling of the ocean indoors.", category: relaxation },
  { name: "Pumpkin Spice", description: "Classic autumn scent with cinnamon, nutmeg and pumpkin.", category: seasonal },
  { name: "Christmas Pine", description: "Fresh pine and cedar wood scent to bring the holiday spirit home.", category: seasonal },
  { name: "Eucalyptus Mint", description: "Refreshing eucalyptus and mint blend ideal for home office or yoga space.", category: relaxation },
  { name: "Sandalwood Noir", description: "Deep, woody sandalwood with subtle dark musk for a sophisticated ambiance.", category: home }
]

products_data.each do |data|
  product = Product.create!(data)
  ProductVariant.create!(product: product, size: :small, price: rand(800..1200), stock: rand(10..50), sku: "#{product.name.downcase.gsub(' ', '-')}-sm")
  ProductVariant.create!(product: product, size: :medium, price: rand(1500..2500), stock: rand(10..50), sku: "#{product.name.downcase.gsub(' ', '-')}-md")
  ProductVariant.create!(product: product, size: :large, price: rand(2800..4000), stock: rand(10..50), sku: "#{product.name.downcase.gsub(' ', '-')}-lg")
end

puts "✅ Seed data created successfully!"
puts "Admin: admin@heavencandles.com / password123"
puts "User: user@heavencandles.com / password123"
