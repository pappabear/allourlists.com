puts 'Purging old data...'

Invitation.destroy_all
Item.destroy_all
List.destroy_all

puts 'Deleting old test users, and deleting the avatars in the S3 bucket...'
User.destroy_all

puts 'Creating users...'

u0 = User.create( :name => 'Chip Irek', :email => 'chip.irek@gmail.com', :password => 'lollip0p' )
u1 = User.create( :name => 'Renae Surname', :email => 'renaeirek@nc.rr.com', :password => 'lollip0p' )

puts 'Creating lists and items...'

l0 = List.create( :name => 'Some todo list', :user_id => u0.id )
l1 = List.create( :name => 'A grocery list', :user_id => u0.id )
l2 = List.create( :name => 'u0 should not see this list', :user_id => u1.id )
l0.items.create( :name => 'walk the dog', :is_complete => nil, :position => 1 )
l0.items.create( :name => 'start a grocery list', :is_complete => true, :position => 1 )

# --- creating data for load testing

=begin
puts 'Creating data for load testing...'

100.times do
  User.create( :name => Faker::Name.name, :email => Faker::Internet.email, :password => Faker::Address.city )
end

User.all.each do |u|
  u.avatar = File.open(Dir.glob(File.join(Rails.root, 'public/sample_avatars', '*')).sample)
  u.save!
end

User.all.each do |u|
  10.times do
    List.create(:name=> Faker::Lorem.sentence(3, true, 4), :user_id => u.id)
  end
end

List.all.each do |l|
  15.times do
    l.items.create(:name => Faker::Lorem.sentence, :is_complete => nil, :position => 1)
  end
end
=end

puts 'Done.'