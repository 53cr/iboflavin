User.delete_observers
a = User.create!(:username              => 'School Of Rock', 
                 :email                 => 'test@example.org',
                 :password              => 'test',
                 :password_confirmation => 'test')  

a.update_attribute :state,'confirmed'

