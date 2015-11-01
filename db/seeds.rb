puts 'Purging old data...'

Item.destroy_all
List.destroy_all
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


puts 'Done.'