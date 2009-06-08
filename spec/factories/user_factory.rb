Factory.define :user do |u|
  u.login "user-#{rand(5000)}"
  u.email "user#{rand(5000)}@iboflav.in"
  u.password "iboflavin"
  u.password_confirmation "iboflavin"
end

Factory.define :ryan, :class => User do |u|
  u.login "ryan#{rand(5000)}"
  u.email "ryan#{rand(5000)}@iboflav.in"
  u.password "iboflavin"
  u.password_confirmation "iboflavin"
  u.birthday Date.parse("February 18, 1987")
  u.sex :male
end