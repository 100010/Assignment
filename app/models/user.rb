class User < ApplicationRecord

  scope :except_current_user, -> { except(id: session[:user_id]) }

  attr_accessor :remember_token, :reset_token

  acts_as_taggable_on :skills

  has_secure_password

  mount_uploader :image, ImageUploader

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def update_password_digest!
    self.update password_digest: BCrypt::Password.create(params[:session][:password], cost: cost)
  end

  def used_email?(email)
    User.find_by email: email
  end

  def is_black_list?(email)
    BlackList.find_by email: email
  end

  def sales_proceed
    self.items.where(transaction_status: 1).pluck(:price).inject(:+)
  end

end
