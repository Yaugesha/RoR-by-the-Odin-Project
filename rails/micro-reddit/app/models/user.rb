class User < ApplicationRecord
  has_many :posts
  validates :login, length: {in: 4..20}
  validates :password, presence: true,
                       confirmation: true,
                       length: { in: 6..20, message: "must have length between 4 and 20 characters" },
                       format: { with: /\A(?=.*\d)(?=.*[[:punct:]])[\w\d[:punct:]]+\z/,
                                 message: "must contain at least one digit and one special character" }
  validates :password_confirmation, presence: true
end
