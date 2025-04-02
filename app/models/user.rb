class User < ApplicationRecord
  has_many :articles
  has_many :comments
  has_many :file_uploads
  has_many :audit_logs

  # A02:2021 - Cryptographic Failures
  # Passwords are stored in plain text. Correct approach: using has_secure_password
end
