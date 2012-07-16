require 'uuidtools'

KELLY = 3
TRES = 2285
JOONAS = 157
EUGENE = 2216

class User < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  paginates_per 50

  authenticates_with_sorcery! do
    config.authentication_class = Authentication
  end

  # TODO: Once we have better criteria for sellers, this needs to be based on that
  # or we need to generate it elsewhere
  before_validation :generate_api_key , :on => :create

  has_one :closet, :dependent => :destroy

  has_many :cart
  has_many :reviews

  has_many :authentications, :dependent => :destroy
  has_one :facebook_authentication, :class_name => Authentication, :conditions => ["provider = 'facebook'", true]

  has_many :conversations
  has_many :favorites
  has_many :items
  has_many :orders, :foreign_key => :buyer_id
  has_many :purchases, :class_name => "Cart"
  has_many :sales,  :class_name => "Order", :foreign_key => :seller_id
  # TODO: Another orders relation from seller side
  has_many :addresses

  has_many :relationships
  has_many :followings, through: :relationships, :source => :target
  has_many :followerships, :class_name => "Relationship", :foreign_key => "target_id"
  has_many :groupies, through: :followerships, :source => :user

  # Validation
  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates_confirmation_of :email, :message => "should match confirmation", :if => :email
  validates :password, :presence => true, :if => :should_update_password?
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password 

  validates :paypal_email, :valid_paypal_email => true, :if => :paypal_email_changed?

  attr_accessible :name,
                  :email,
                  :email_confirmation,
                  :current_password,
                  :password,
                  :password_confirmation,
                  :legacy_password,
                  :gender,
                  :website,
                  :location,
                  :biography,
                  :avatar,
                  :paypal_email,
                  :authentication_attributes

  accepts_nested_attributes_for :authentications

  # Enable CarrierWave
  mount_uploader :avatar, AvatarUploader

  attr_accessor :email_confirmation, :password_confirmation, :current_password

  def generate_api_key
    self.api_key = UUIDTools::UUID.random_create.to_s
  end

  def self.from_omniauth(auth_hash)
    auth = Authentication.where(auth_hash.slice(:provider, :uid)).first
    # Include the facebook_authentication so we can update it with the new access token
    self.includes(:facebook_authentication).find(auth.user_id) if auth.present?
  end

  def admin?
    # TODO: This should call administator?
    [KELLY, JOONAS, TRES].include? id
  end

  # TODO: Add this as :if => :should_update_password? to password
  # TODO: Create one for every field we need to "always" update.
  # XXX: See railscast #61 about this, or http://bit.ly/Kc4Ilo
  def should_update_password?
    # TODO: Have an accessor for marking this as being updated, i.e.:
    # updating_password || new_record?
    new_record?
  end

  def new_messages_count
    @unread ||= Message.unread_count_for(self).size
  end

  def new_messages?
    not new_messages_count.zero?
  end

  def favorite?(item)
    favorites.include?(item)
  end

  def has_facebook?
    @facebook_connection ||= facebook_authentication
    @facebook_connection.present?
  end

  def current_on_facebook?
    @facebook_connection.current? if has_facebook?
  end

  # Twitter login disabled
  #def has_twitter?
    #@twitter_connected ||= authentications.where(provider: 'twitter').any?
  #end

  def number_of_groupies
    groupies.size
  end

  def number_of_followings
    followings.size
  end

  def to_indexed_json
    {
      name: name,
      avatar: avatar_url(:search),
      groupies: groupies.size,
      following: followings.size
    }.to_json
  end
  
  # TODO: Add methods for updating the specific attributes that are validated
  # for the model, for example, password:
  # def update_password(params)
  #   updating_password = true
  #   update_attributes(params) ? or should we do something manual here?
  # end
end
