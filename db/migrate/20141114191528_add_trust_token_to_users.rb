class AddTrustTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trust_token, :string
  end
end
