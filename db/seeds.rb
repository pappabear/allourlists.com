puts 'Purging old data...'

Item.destroy_all
List.destroy_all

puts 'Creating lists and items...'

l0 = List.create( :name => 'Some todo list' )
l1 = List.create( :name => 'A grocery list' )
l0.items.create( :name => 'walk the dog', :is_complete => nil, :position => 1 )
l0.items.create( :name => 'start a grocery list', :is_complete => true, :position => 1 )


puts 'Done.'