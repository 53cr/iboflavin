
User.delete_observers
a = User.create!(:username              => 'admin', 
                 :email                 => 'test@53cr.com',
                 :password              => 'tester',
                 :password_confirmation => 'tester',
                 :admin                 => true)  

a.update_attribute :state,'confirmed'

