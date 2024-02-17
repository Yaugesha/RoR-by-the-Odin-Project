class User < ApplicationRecord
  validates :username, length: { in: 6..16,
                                message: "must have length between 4 and 20 characters" },
                      format: { with: /\A[a-zA-Z]+\z/,
                                message: "must contain only characters" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP,
                             message: "must be valid" }
  validates :password, presence: true,
                       confirmation: true,
                       length: { in: 6..20, message: "must have length between 4 and 20 characters" },
                       format: { with: /\A(?=.*\d)(?=.*[[:punct:]])[\w\d[:punct:]]+\z/,
                                 message: "must contain at least one digit and one special character" }
  validates :password_confirmation, presence: true
end
