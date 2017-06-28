admin = User.create(:email => 'admin@gmail.com', :password => 'master')
admin.add_role :admin
admin.save

user = User.create(email: 'user@gmail.com', password: 'hi')

user.save

5.times do
    Post.create(
        title: Faker::Name.first_name,
        content: Faker::Lorem.paragraph,
        user: admin)
    Post.create(
        title: Faker::Name.first_name,
        content: Faker::Lorem.paragraph,
        user: admin)
end