# Clear existing data
puts 'Clearing existing data...'
User.destroy_all
Category.destroy_all
Book.destroy_all

# Create admin user
puts 'Creating admin user...'
admin = User.create!(
  email: 'admin@library.com',
  password: 'password123',
  role: :admin
)
puts 'Admin user created!'

# Create categories
puts 'Creating categories...'
categories = ['Fiction', 'Non-Fiction', 'Science', 'History', 'Technology'].map do |name|
  Category.create!(name: name)
end
puts 'Categories created!'

# Create books
puts 'Creating books...'
20.times do |i|
  Book.create!(
    title: Faker::Book.title,
    isbn: "ISBN-#{i+1}-#{rand(100000)}",
    author: Faker::Book.author,
    description: Faker::Lorem.paragraph,
    category: categories.sample,
    available: true
  )
end
puts 'Books created!'

puts 'Seed completed successfully!'