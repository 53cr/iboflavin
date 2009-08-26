Factory.define :user do |u|
  u.sequence(:username) {|n| "person#{n}" }
  u.sequence(:email)    {|n| "person#{n}@example.com"}
  u.password "12345"
  u.password_confirmation "12345"
  u.state "confirmed"
  u.admin false
end
