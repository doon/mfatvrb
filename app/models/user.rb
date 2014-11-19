class User < ActiveRecord::Base
  has_secure_password
  has_one_time_password
  before_create { generate_token(:auth_token) }
  before_create { generate_token(:trust_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
