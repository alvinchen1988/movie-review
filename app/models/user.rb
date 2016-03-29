class User < ActiveRecord::Base
  has_many :reviews

  validates :email, presence: true
  validates :firstname, presence: true
  validates :password, length: {in: 6..20}, on: :create
  has_secure_password

  def full_name
    "#{firstname} #{lastname}"
  end
end

