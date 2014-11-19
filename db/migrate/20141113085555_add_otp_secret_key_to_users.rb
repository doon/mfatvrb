class AddOtpSecretKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :otp_secret_key, :string
    add_column :users, :use2fa, :boolean
  end
end
