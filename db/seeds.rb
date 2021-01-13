require 'faker'


puts "--- Clearning DB ---"
User.destroy_all
puts "--- Ok ! ---"

puts "--- Creating Admin ---"
admin = User.new(email: "admin@lafineequipe.fr", password: "azerty", password_confirmation: "azerty", admin: true)
admin.skip_confirmation!
admin.save!
puts "--- Ok ! ---"

if Rails.env.development?
  puts "--- Creating 20 users ---"
  20.times do
    if Request.where("position > 0") != []
      requests_positions = Request.where("position > 0").order("position ASC").map { |request| request.position }
      last_position = requests_positions.last
      user = User.new(
          email: Faker::Internet.email,
          password: "123456",
          password_confirmation: "123456"
             )
      user.skip_confirmation!
      user.save!
      user.request.status = "confirmed"
      user.request.last_check = Date.today
      user.request.position = last_position + 1
      user.request.save!
      profile = Profile.new(
        name: Faker::Name.unique.name,
        phone_number: 1234567890,
        bio: "Short Bio",
        user: user)
      profile.save!
    else
      user = User.new(
          email: Faker::Internet.email,
          password: "123456",
          password_confirmation: "123456"
             )
      user.skip_confirmation!
      user.save!
      user.request.status = "confirmed"
      user.request.last_check = Date.today
      user.request.position = 1
      user.request.save!
      profile = Profile.new(
        name: Faker::Name.unique.name,
        phone_number: 1234567890,
        bio: "Short Bio",
        user: user)
      profile.save!
    end
  end
  puts "---All done !---"
end





