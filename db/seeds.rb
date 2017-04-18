10.times do
  User.create first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: '1234',
              password_confirmation: '1234'
end
puts Cowsay.say 'Created 10 users', :dragon

10.times do
  user = User.all.sample
  Idea.create title: Faker::Book.title,
              description: Faker::Hipster.paragraph(10),
              user_id: user.id,
              likes: rand(0..10)
end

ideas = Idea.all

ideas.each do |i|
  rand(0..5).times do
    user = User.all.sample
    i.reviews.create({
      body: Faker::Hipster.paragraph(10),
      user_id: user.id
      })
  end
end

reviews_count = Review.count

puts Cowsay.say 'Created 10 products', :elephant
puts Cowsay.say "Created #{reviews_count} reviews", :stegosaurus
