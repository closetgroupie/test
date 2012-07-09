# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120709024337) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "action_id",                 :null => false
    t.string   "action_type", :limit => 30, :null => false
    t.integer  "entity_id",                 :null => false
    t.string   "entity_type", :limit => 30, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "legacy_id"
  end

  add_index "activities", ["action_id", "action_type"], :name => "index_activities_on_action_id_and_action_type"
  add_index "activities", ["entity_id", "entity_type"], :name => "index_activities_on_entity_id_and_entity_type"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.string   "country",    :limit => 2,   :null => false
    t.string   "recipient",  :limit => 120, :null => false
    t.string   "primary",    :limit => 120, :null => false
    t.string   "secondary",  :limit => 120
    t.string   "city",       :limit => 80,  :null => false
    t.string   "state",      :limit => 80
    t.string   "zip",        :limit => 12
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.string   "provider",                           :null => false
    t.string   "uid",                                :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "access_token",        :limit => 150
    t.string   "access_token_secret", :limit => 150
    t.integer  "legacy_id"
  end

  create_table "brands", :force => true do |t|
    t.integer  "segment_id"
    t.string   "name",       :limit => 50
    t.string   "slug",       :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "legacy_id",  :limit => 2
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "purchase_id"
    t.datetime "purchased_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.string   "unique_id",           :limit => 25
    t.integer  "legacy_id"
    t.integer  "legacy_uid"
  end

  create_table "categories", :force => true do |t|
    t.integer  "segment_id"
    t.string   "name",       :limit => 40
    t.string   "slug",       :limit => 40
    t.integer  "ordering",   :limit => 2
    t.integer  "parent_id",  :limit => 2
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "legacy_id",  :limit => 2
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"

  create_table "categorization_size_groups", :force => true do |t|
    t.integer  "segment_id"
    t.integer  "category_id"
    t.integer  "size_group_id"
    t.integer  "ordering"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "legacy_id"
  end

  create_table "closets", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "legacy_id",  :limit => 2
  end

  create_table "conversations", :force => true do |t|
    t.integer  "conversable_id"
    t.string   "conversable_type"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "legacy_id",        :limit => 2
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "legacy_id"
  end

  create_table "items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "closet_id"
    t.string   "title",                 :limit => 200
    t.integer  "segment_id"
    t.integer  "category_id"
    t.integer  "size_id"
    t.integer  "condition",             :limit => 2
    t.integer  "brand_id"
    t.string   "brand_suggestion",      :limit => 80
    t.text     "description"
    t.decimal  "price",                                :precision => 9, :scale => 2
    t.decimal  "shipping_cost",                        :precision => 6, :scale => 2
    t.decimal  "shipping_cost_bundled",                :precision => 6, :scale => 2
    t.string   "shipping_from",         :limit => 2
    t.boolean  "shipping_abroad",                                                    :default => false
    t.text     "shipping_notes"
    t.datetime "created_at",                                                                            :null => false
    t.datetime "updated_at",                                                                            :null => false
    t.boolean  "sold",                                                               :default => false
    t.integer  "legacy_id"
  end

  add_index "items", ["category_id"], :name => "index_items_on_category_id"
  add_index "items", ["closet_id"], :name => "index_items_on_closet_id"
  add_index "items", ["segment_id"], :name => "index_items_on_segment_id"
  add_index "items", ["user_id"], :name => "index_items_on_user_id"

  create_table "line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "cart_id"
    t.decimal  "price"
    t.integer  "legacy_id"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "conversation_id"
    t.text     "content"
    t.boolean  "unread",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "recipient_id"
  end

  create_table "orders", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.datetime "purchased_at"
    t.integer  "cart_id"
    t.integer  "legacy_id"
    t.integer  "legacy_uid"
  end

  create_table "photos", :force => true do |t|
    t.integer  "item_id"
    t.string   "image"
    t.integer  "ordering"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "legacy_id"
    t.string   "original_name"
    t.string   "filename_seed"
  end

  create_table "purchase_shipping_addresses", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "shipping_address_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "purchases", :force => true do |t|
    t.integer  "user_id"
    t.string   "unique_id",    :limit => 50
    t.datetime "completed_at"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "add_legacy_id_to_photos"
    t.integer  "legacy_id"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "closet_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "segments", :force => true do |t|
    t.string   "name",       :limit => 30
    t.string   "slug",       :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "legacy_id",  :limit => 2
  end

  create_table "size_groups", :force => true do |t|
    t.string   "name",       :limit => 80
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "sizes", :force => true do |t|
    t.integer  "size_group_id"
    t.string   "name",          :limit => 30
    t.integer  "ordering"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "legacy_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "name"
    t.string   "gender"
    t.string   "location"
    t.string   "website"
    t.text     "biography"
    t.string   "avatar"
    t.string   "paypal_email"
    t.string   "legacy_password",                 :limit => 40
    t.integer  "legacy_id",                       :limit => 2
    t.string   "api_key",                         :limit => 40
    t.boolean  "is_curator",                                    :default => false
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
