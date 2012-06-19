class AddAccessTokenAndAccessTokenTokenSecretToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :access_token, :string, :limit => 150
    add_column :authentications, :access_token_secret, :string, :limit => 150
  end
end
