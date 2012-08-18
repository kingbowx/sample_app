# By using symbol ':user', we get Factory Girl to simulate the User model
Factory.define :user do |user|
  user.name                  "factory user"
  user.email                 "factory.user@factory.com"
  #user.name                  "kenneth feng"
  #user.email                 "kenneth.feng@sirca.org.au"
  user.password              "passwd"
  user.password_confirmation "passwd"
end
