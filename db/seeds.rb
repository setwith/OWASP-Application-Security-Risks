# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = User.create!(
  username: 'admin',
  password: 'admin123',
  email: 'admin@example.com',
  admin: true
)

user = User.create!(
  username: 'user',
  password: 'user123',
  email: 'user@example.com',
  admin: false
)

article1 = Article.create!(
  title: 'Welcome to the Vulnerable App',
  content: 'This application demonstrates OWASP Top 10 2021 vulnerabilities',
  user: admin
)

article2 = Article.create!(
  title: 'How to Secure Your Application',
  content: 'Follow OWASP guidelines to protect your application',
  user: user
)

Comment.create!(
  content: 'Very interesting article! alert("XSS")',
  user: user,
  article: article1
)

Comment.create!(
  content: 'Thanks for the useful information',
  user: admin,
  article: article2
)