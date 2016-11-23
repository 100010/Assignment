require 'bcrypt'
cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

User.create(
  [
    {
      name: "aaa",
      email: "xxx@gmail.com",
      password_digest: BCrypt::Password.create("1111111", cost: cost),
    },
    {
      name: "bbb",
      email: "yyy@gmail.com",
      password_digest: BCrypt::Password.create("1111111", cost: cost),
    },
  ]
)
