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

ActiveRecord::Schema.define(:version => 20130603053325) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.string   "technology"
    t.text     "app_desc"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "slug"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.string   "slug"
    t.integer  "position"
    t.boolean  "use_privacy",     :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"
  add_index "categories", ["organization_id"], :name => "index_categories_on_organization_id"
  add_index "categories", ["position"], :name => "index_categories_on_position"
  add_index "categories", ["slug"], :name => "index_categories_on_slug"
  add_index "categories", ["use_privacy"], :name => "index_categories_on_use_privacy"

  create_table "categories_users", :force => true do |t|
    t.integer "category_id"
    t.integer "user_id"
  end

  add_index "categories_users", ["category_id"], :name => "index_categories_users_on_category_id"
  add_index "categories_users", ["user_id"], :name => "index_categories_users_on_user_id"

  create_table "databases", :force => true do |t|
    t.string   "db_name"
    t.string   "db_environment"
    t.string   "db_hosting"
    t.string   "db_technology"
    t.text     "db_usage"
    t.string   "db_connection_string"
    t.string   "db_version"
    t.boolean  "db_active"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.date     "last_sync"
    t.string   "db_file"
    t.integer  "oftables"
    t.integer  "ofrecords"
    t.integer  "offields"
    t.string   "short_description",    :limit => 60
    t.string   "image_name"
    t.integer  "app_id"
  end

  create_table "environments", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "db_environment"
    t.string   "db_environment_name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.text     "notes"
  end

  create_table "fields", :force => true do |t|
    t.string   "environment"
    t.string   "database"
    t.text     "description"
    t.string   "field_name"
    t.string   "validation_edit"
    t.string   "field_type"
    t.integer  "field_size"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "organization_id"
    t.integer  "user_id"
    t.integer  "fieldable_id"
    t.string   "fieldable_type"
    t.string   "database_name"
    t.string   "table_name"
    t.string   "short_description", :limit => 60
  end

  create_table "hostings", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.string   "db_hosting"
    t.string   "db_hosting_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "notes"
    t.string   "env_id"
    t.string   "inst_id"
    t.text     "description"
    t.string   "os"
    t.text     "apps"
    t.string   "ip"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.integer  "users_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "message"
    t.string   "companyname"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "patterns", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "organization_id"
    t.string   "status"
    t.string   "attachment"
    t.text     "notes"
    t.string   "fontcolor"
    t.string   "color"
    t.string   "group"
    t.integer  "category_id"
    t.boolean  "use_privacy",                            :default => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.text     "how_used"
    t.text     "when_used"
    t.text     "what_problem"
    t.string   "asset_attachment"
    t.text     "pat_html",         :limit => 2147483647
    t.text     "pat_js",           :limit => 2147483647
    t.text     "pat_css",          :limit => 2147483647
  end

  add_index "patterns", ["category_id"], :name => "index_patterns_on_category_id"
  add_index "patterns", ["color"], :name => "index_patterns_on_color"
  add_index "patterns", ["group"], :name => "index_patterns_on_group"
  add_index "patterns", ["name"], :name => "index_patterns_on_name"
  add_index "patterns", ["organization_id"], :name => "index_patterns_on_organization_id"
  add_index "patterns", ["slug"], :name => "index_patterns_on_slug"
  add_index "patterns", ["use_privacy"], :name => "index_patterns_on_use_privacy"

  create_table "patterns_users", :force => true do |t|
    t.integer  "pattern_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "patterns_users", ["pattern_id"], :name => "index_patterns_users_on_pattern_id"
  add_index "patterns_users", ["user_id"], :name => "index_patterns_users_on_user_id"

  create_table "records", :force => true do |t|
    t.text     "record"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "samples", :force => true do |t|
    t.integer  "table_id"
    t.integer  "record_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tables", :force => true do |t|
    t.string   "environment"
    t.string   "database"
    t.string   "table_type"
    t.text     "description"
    t.integer  "ofrows"
    t.integer  "ofcolumns"
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "database_id"
    t.string   "table_name"
    t.string   "database_name"
    t.boolean  "top_used"
    t.string   "feature_types"
    t.text     "column_type"
    t.string   "short_description", :limit => 60
  end

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean  "admin"
    t.string   "name"
    t.boolean  "active"
    t.integer  "organization_id"
  end

  add_index "users", ["organization_id"], :name => "index_users_on_organization_id"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
