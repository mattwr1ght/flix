class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependant: :destroy

  validates :name, presence: true
  validates :email, presence: true,
                   format: { with: /\S+@\S+/ },
                   uniqueness: { case_sensitive: false }

end
