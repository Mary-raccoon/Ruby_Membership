class User < ActiveRecord::Base
  has_secure_password
  
  has_many :members, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :groups_joined, :through => :members, :source => :group 

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: { :maximum => 50 }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }

  before_create do
    self.email = email.downcase
  end
end
