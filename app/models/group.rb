class Group < ActiveRecord::Base
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :users_joined, through: :members, source: :user

  validates :name, presence: true, length: { :in => 5..50 }
  validates :desc, presence: true, length: { :in => 10..250 }
end
