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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161025134644) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "note_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "event_logs", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "show_name",   limit: 191
    t.string   "table",       limit: 191
    t.integer  "obj_id",      limit: 4
    t.string   "object_name", limit: 191
    t.string   "action",      limit: 191
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "favorite_articles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "note_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 191, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 191
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "galleries", force: :cascade do |t|
    t.string   "image",      limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                 null: false
    t.string   "title",      limit: 191
    t.text     "content",    limit: 65535
    t.string   "author",     limit: 191
    t.integer  "amount",     limit: 4,     default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "recommends", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "note_id",      limit: 4
    t.integer  "recom_amount", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 191
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "start_work_at",          limit: 191
    t.string   "region",                 limit: 191
    t.string   "highest_degree",         limit: 191
    t.datetime "birthday"
    t.string   "position",               limit: 191
    t.string   "company",                limit: 191
    t.text     "introduction",           limit: 65535
    t.string   "achievement",            limit: 191
    t.string   "cellphone",              limit: 191,   default: "",      null: false
    t.string   "avatar",                 limit: 191
    t.string   "show_name",              limit: 191,                     null: false
    t.string   "user_email",             limit: 191
    t.string   "provider",               limit: 191,   default: "email"
    t.string   "uid",                    limit: 191,   default: "",      null: false
    t.text     "tokens",                 limit: 65535
    t.string   "username",               limit: 191,   default: "",      null: false
    t.string   "email",                  limit: 191
    t.string   "encrypted_password",     limit: 191,   default: "",      null: false
    t.boolean  "locked",                               default: false,   null: false
    t.string   "slug",                   limit: 191
    t.string   "reset_password_token",   limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 191
    t.string   "last_sign_in_ip",        limit: 191
    t.string   "confirmation_token",     limit: 191
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 191
    t.string   "sex",                    limit: 191
    t.integer  "user_number",            limit: 4
    t.string   "user_type",              limit: 191
    t.string   "longitude",              limit: 191
    t.string   "latitude",               limit: 191
    t.boolean  "is_top",                               default: false,   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "users", ["cellphone"], name: "index_users_on_cellphone", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
