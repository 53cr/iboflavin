Factory.define :user do |u|
  u.login "user"
  u.email "user@iboflav.in"
  u.password "iboflavin"
  u.password_confirmation "iboflavin"
end

Factory.define :ryan, :class => User do |u|
  u.login "ryan"
  u.email "ryan@iboflav.in"
  u.password "iboflavin"
  u.password_confirmation "iboflavin"
  u.birthday Date.parse("February 18, 1987")
  u.sex :male
end