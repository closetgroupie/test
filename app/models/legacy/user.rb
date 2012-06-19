class Legacy::User < Legacy::Base
  set_table_name  'users'
  set_primary_key 'id'

  # has_many :items,
  #          :class_name => "Legacy::Item"

  # has_many :addresses,
  #          :class_name => "Legacy::Address"

  # TODO: rest of the associations...

  def to_model
    ::User.new do |u|
      u.legacy_id       = self.id
      u.legacy_password = self.password
      u.password        = "MaailmanVaikeinSalasanaJotaEtIkinaArvaa!!!11JepJep"
      u.name            = self.name
      u.email           = self.email
      u.created_at      = convert_to_datetime(self.created)
      u.updated_at      = convert_to_datetime(self.updated)
      u.location        = self.location
      u.website         = self.website_url
      u.gender          = self.gender_id
      u.biography       = self.biography
      u.avatar          = self.avatar_filename if self.avatar_filename != 'avatar0.jpg'
      u.paypal_email    = self.paypal_email
    end
  end
end
