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

ActiveRecord::Schema.define(version: 20160526083331) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 191
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 191,   null: false
    t.string   "resource_type", limit: 191,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "apply_records", force: :cascade do |t|
    t.integer  "resume_id",     limit: 4
    t.integer  "job_id",        limit: 4
    t.datetime "apply_at"
    t.string   "resume_status", limit: 191
    t.datetime "recieve_at"
    t.datetime "view_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "education_experences", force: :cascade do |t|
    t.integer  "resume_id",        limit: 4
    t.string   "college",          limit: 191
    t.string   "education_degree", limit: 191
    t.datetime "graduated_at"
    t.string   "major",            limit: 191
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "expect_jobs", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.string   "name",                  limit: 191
    t.string   "job_type",              limit: 191
    t.string   "location",              limit: 191
    t.string   "expected_salary_range", limit: 191
    t.string   "job_desc",              limit: 191
    t.boolean  "is_top"
    t.datetime "is_top_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "favorite_jobs", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "job_id",       limit: 4
    t.datetime "collected_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
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

  create_table "hospitals", force: :cascade do |t|
    t.integer  "job_fair_id",  limit: 4
    t.string   "name",         limit: 191
    t.string   "scale",        limit: 191
    t.string   "property",     limit: 191
    t.string   "location",     limit: 191
    t.string   "introduction", limit: 191
    t.string   "region",       limit: 191
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "job_fairs", force: :cascade do |t|
    t.string   "name",       limit: 191
    t.datetime "timeout"
    t.string   "tips",       limit: 191
    t.integer  "entry_num",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "hospital_id",           limit: 4
    t.string   "name",                  limit: 191
    t.string   "expected_salary_range", limit: 191
    t.string   "location",              limit: 191
    t.string   "job_desc",              limit: 191
    t.integer  "needed_number",         limit: 4
    t.string   "job_type",              limit: 191
    t.boolean  "is_top"
    t.datetime "is_top_at"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "refinery_authentication_devise_roles", force: :cascade do |t|
    t.string "title", limit: 191
  end

  create_table "refinery_authentication_devise_roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "refinery_authentication_devise_roles_users", ["role_id", "user_id"], name: "refinery_roles_users_role_id_user_id", using: :btree
  add_index "refinery_authentication_devise_roles_users", ["user_id", "role_id"], name: "refinery_roles_users_user_id_role_id", using: :btree

  create_table "refinery_authentication_devise_user_plugins", force: :cascade do |t|
    t.integer "user_id",  limit: 4
    t.string  "name",     limit: 191
    t.integer "position", limit: 4
  end

  add_index "refinery_authentication_devise_user_plugins", ["name"], name: "index_refinery_authentication_devise_user_plugins_on_name", using: :btree
  add_index "refinery_authentication_devise_user_plugins", ["user_id", "name"], name: "refinery_user_plugins_user_id_name", unique: true, using: :btree

  create_table "refinery_authentication_devise_users", force: :cascade do |t|
    t.string   "username",               limit: 191, null: false
    t.string   "email",                  limit: 191, null: false
    t.string   "encrypted_password",     limit: 191, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 191
    t.string   "last_sign_in_ip",        limit: 191
    t.integer  "sign_in_count",          limit: 4
    t.datetime "remember_created_at"
    t.string   "reset_password_token",   limit: 191
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                   limit: 191
    t.string   "full_name",              limit: 191
  end

  add_index "refinery_authentication_devise_users", ["id"], name: "index_refinery_authentication_devise_users_on_id", using: :btree
  add_index "refinery_authentication_devise_users", ["slug"], name: "index_refinery_authentication_devise_users_on_slug", using: :btree

  create_table "refinery_image_translations", force: :cascade do |t|
    t.integer  "refinery_image_id", limit: 4,   null: false
    t.string   "locale",            limit: 191, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "image_alt",         limit: 191
    t.string   "image_title",       limit: 191
  end

  add_index "refinery_image_translations", ["locale"], name: "index_refinery_image_translations_on_locale", using: :btree
  add_index "refinery_image_translations", ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id", using: :btree

  create_table "refinery_images", force: :cascade do |t|
    t.string   "image_mime_type", limit: 191
    t.string   "image_name",      limit: 191
    t.integer  "image_size",      limit: 4
    t.integer  "image_width",     limit: 4
    t.integer  "image_height",    limit: 4
    t.string   "image_uid",       limit: 191
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "image_title",     limit: 191
    t.string   "image_alt",       limit: 191
  end

  create_table "refinery_page_part_translations", force: :cascade do |t|
    t.integer  "refinery_page_part_id", limit: 4,     null: false
    t.string   "locale",                limit: 191,   null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "body",                  limit: 65535
  end

  add_index "refinery_page_part_translations", ["locale"], name: "index_refinery_page_part_translations_on_locale", using: :btree
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id", using: :btree

  create_table "refinery_page_parts", force: :cascade do |t|
    t.integer  "refinery_page_id", limit: 4
    t.string   "slug",             limit: 191
    t.text     "body",             limit: 65535
    t.integer  "position",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",            limit: 191
  end

  add_index "refinery_page_parts", ["id"], name: "index_refinery_page_parts_on_id", using: :btree
  add_index "refinery_page_parts", ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id", using: :btree

  create_table "refinery_page_translations", force: :cascade do |t|
    t.integer  "refinery_page_id", limit: 4,   null: false
    t.string   "locale",           limit: 191, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "title",            limit: 191
    t.string   "custom_slug",      limit: 191
    t.string   "menu_title",       limit: 191
    t.string   "slug",             limit: 191
  end

  add_index "refinery_page_translations", ["locale"], name: "index_refinery_page_translations_on_locale", using: :btree
  add_index "refinery_page_translations", ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id", using: :btree

  create_table "refinery_pages", force: :cascade do |t|
    t.integer  "parent_id",           limit: 4
    t.string   "path",                limit: 191
    t.string   "slug",                limit: 191
    t.string   "custom_slug",         limit: 191
    t.boolean  "show_in_menu",                    default: true
    t.string   "link_url",            limit: 191
    t.string   "menu_match",          limit: 191
    t.boolean  "deletable",                       default: true
    t.boolean  "draft",                           default: false
    t.boolean  "skip_to_first_child",             default: false
    t.integer  "lft",                 limit: 4
    t.integer  "rgt",                 limit: 4
    t.integer  "depth",               limit: 4
    t.string   "view_template",       limit: 191
    t.string   "layout_template",     limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_pages", ["depth"], name: "index_refinery_pages_on_depth", using: :btree
  add_index "refinery_pages", ["id"], name: "index_refinery_pages_on_id", using: :btree
  add_index "refinery_pages", ["lft"], name: "index_refinery_pages_on_lft", using: :btree
  add_index "refinery_pages", ["parent_id"], name: "index_refinery_pages_on_parent_id", using: :btree
  add_index "refinery_pages", ["rgt"], name: "index_refinery_pages_on_rgt", using: :btree

  create_table "refinery_resource_translations", force: :cascade do |t|
    t.integer  "refinery_resource_id", limit: 4,   null: false
    t.string   "locale",               limit: 191, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "resource_title",       limit: 191
  end

  add_index "refinery_resource_translations", ["locale"], name: "index_refinery_resource_translations_on_locale", using: :btree
  add_index "refinery_resource_translations", ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id", using: :btree

  create_table "refinery_resources", force: :cascade do |t|
    t.string   "file_mime_type", limit: 191
    t.string   "file_name",      limit: 191
    t.integer  "file_size",      limit: 4
    t.string   "file_uid",       limit: 191
    t.string   "file_ext",       limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_views", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "hospital_id", limit: 4
    t.datetime "view_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "resumes", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.datetime "last_refresh_time"
    t.string   "expected_job",          limit: 191
    t.string   "expected_job_type",     limit: 191
    t.string   "expected_base",         limit: 191
    t.string   "expected_salary_range", limit: 191
    t.integer  "maturity",              limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
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

  create_table "seo_meta", force: :cascade do |t|
    t.integer  "seo_meta_id",      limit: 4
    t.string   "seo_meta_type",    limit: 191
    t.string   "browser_title",    limit: 191
    t.text     "meta_description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seo_meta", ["id"], name: "index_seo_meta_on_id", using: :btree
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta", using: :btree

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "work_time",  limit: 191
    t.string   "location",   limit: 191
    t.string   "job_status", limit: 191
    t.datetime "birthday"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "cellphone",              limit: 191,   default: "",      null: false
    t.string   "avatar",                 limit: 191
    t.string   "show_name",              limit: 191,                     null: false
    t.string   "provider",               limit: 191,   default: "email", null: false
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
    t.string   "main_video",             limit: 191
    t.integer  "sex",                    limit: 4
    t.string   "user_number",            limit: 191
    t.string   "wechat_openid",          limit: 191
    t.string   "vcode",                  limit: 191
    t.string   "update_vcode_time",      limit: 191
    t.string   "transaction_password",   limit: 191
    t.string   "longitude",              limit: 191
    t.string   "latitude",               limit: 191
    t.float    "balance",                limit: 24
    t.float    "total_consumption",      limit: 24
    t.string   "user_type",              limit: 191
    t.boolean  "is_top",                               default: false,   null: false
    t.integer  "merchant_id",            limit: 4
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

  create_table "work_experences", force: :cascade do |t|
    t.integer  "resume_id",  limit: 4
    t.string   "company",    limit: 191
    t.string   "position",   limit: 191
    t.datetime "started_at"
    t.datetime "left_time"
    t.string   "job_desc",   limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
