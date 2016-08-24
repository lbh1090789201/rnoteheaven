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

ActiveRecord::Schema.define(version: 20160823064609) do

  create_table "apply_records", force: :cascade do |t|
    t.integer  "resume_id",       limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "job_id",          limit: 4
    t.integer  "hospital_id",     limit: 4
    t.datetime "end_at"
    t.datetime "view_at"
    t.datetime "recieve_at"
    t.string   "from",            limit: 191, default: "common", null: false
    t.string   "resume_status",   limit: 191
    t.boolean  "has_new",                     default: false,    null: false
    t.string   "job_name",        limit: 191
    t.string   "job_type",        limit: 191
    t.string   "job_location",    limit: 191
    t.string   "salary_range",    limit: 191
    t.string   "hospital_region", limit: 191
    t.string   "show_name",       limit: 191
    t.string   "sex",             limit: 191
    t.integer  "age",             limit: 4
    t.string   "highest_degree",  limit: 191
    t.string   "start_work_at",   limit: 191
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "block_hospitals", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "hospital_id",   limit: 4
    t.string   "hospital_name", limit: 191
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "certificates", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "certificates", ["user_id"], name: "index_certificates_on_user_id", using: :btree

  create_table "education_experiences", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "college",          limit: 191
    t.string   "education_degree", limit: 191
    t.datetime "entry_at"
    t.datetime "graduated_at"
    t.string   "major",            limit: 191
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "employers", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "hospital_id",    limit: 4
    t.integer  "plan_id",        limit: 4
    t.integer  "vip_level",      limit: 4, default: 1, null: false
    t.integer  "may_receive",    limit: 4, default: 0, null: false
    t.integer  "may_release",    limit: 4, default: 0, null: false
    t.integer  "may_set_top",    limit: 4, default: 0, null: false
    t.integer  "may_view",       limit: 4, default: 0, null: false
    t.integer  "may_join_fairs", limit: 4, default: 0, null: false
    t.integer  "has_receive",    limit: 4, default: 0, null: false
    t.integer  "has_release",    limit: 4, default: 0, null: false
    t.integer  "has_set_top",    limit: 4, default: 0, null: false
    t.integer  "has_view",       limit: 4, default: 0, null: false
    t.integer  "has_join_fairs", limit: 4, default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
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

  create_table "fair_hospitals", force: :cascade do |t|
    t.integer  "hospital_id",    limit: 4
    t.integer  "fair_id",        limit: 4
    t.integer  "user_id",        limit: 4
    t.string   "contact_person", limit: 191
    t.string   "contact_number", limit: 191
    t.string   "intro",          limit: 191
    t.string   "banner",         limit: 191
    t.string   "status",         limit: 191
    t.string   "operator",       limit: 191
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "fairs", force: :cascade do |t|
    t.string   "name",            limit: 191
    t.string   "creator",         limit: 191
    t.string   "banner",          limit: 191
    t.text     "intro",           limit: 65535
    t.string   "status",          limit: 191
    t.datetime "begain_at"
    t.datetime "end_at"
    t.integer  "hospitals_count", limit: 4
    t.integer  "jobs_count",      limit: 4
    t.integer  "resumes_count",   limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "favorite_jobs", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "job_id",       limit: 4
    t.boolean  "has_new",                  default: false, null: false
    t.string   "name",         limit: 191
    t.string   "job_type",     limit: 191
    t.string   "salary_range", limit: 191
    t.string   "region",       limit: 191
    t.datetime "collected_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
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
    t.integer  "job_fair_id",    limit: 4
    t.string   "name",           limit: 191
    t.string   "property",       limit: 191
    t.string   "scale",          limit: 191
    t.string   "industry",       limit: 191
    t.string   "region",         limit: 191
    t.string   "location",       limit: 191
    t.text     "introduction",   limit: 65535
    t.string   "image",          limit: 191
    t.float    "lat",            limit: 24,    default: 30.5984
    t.float    "lng",            limit: 24,    default: 114.312
    t.string   "contact_person", limit: 191
    t.string   "contact_number", limit: 191
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "hospital_id",   limit: 4
    t.string   "name",          limit: 191
    t.string   "job_type",      limit: 191
    t.string   "salary_range",  limit: 191
    t.string   "experience",    limit: 191
    t.integer  "needed_number", limit: 4
    t.string   "region",        limit: 191
    t.string   "location",      limit: 191
    t.text     "job_desc",      limit: 65535
    t.text     "job_demand",    limit: 65535
    t.integer  "duration",      limit: 4
    t.string   "status",        limit: 191
    t.boolean  "is_update",                   default: false, null: false
    t.boolean  "is_top",                      default: false, null: false
    t.datetime "submit_at"
    t.datetime "operate_at"
    t.datetime "refresh_at"
    t.datetime "end_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "recruit_type",  limit: 191
    t.string   "degree_demand", limit: 191
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",           limit: 191
    t.integer  "may_receive",    limit: 4,   default: 0,    null: false
    t.integer  "may_release",    limit: 4,   default: 0,    null: false
    t.integer  "may_set_top",    limit: 4,   default: 0,    null: false
    t.integer  "may_view",       limit: 4,   default: 0,    null: false
    t.integer  "may_join_fairs", limit: 4,   default: 0,    null: false
    t.boolean  "status",                     default: true, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "resume_viewers", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "hospital_id", limit: 4
    t.datetime "view_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "resumes", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.datetime "refresh_at"
    t.string   "expected_job",          limit: 191
    t.string   "expected_job_type",     limit: 191
    t.string   "expected_base",         limit: 191
    t.string   "expected_salary_range", limit: 191
    t.integer  "maturity",              limit: 4,   default: 0,     null: false
    t.boolean  "public",                            default: true,  null: false
    t.boolean  "resume_freeze",                     default: false, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
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
    t.string   "location",               limit: 191
    t.string   "seeking_job",            limit: 191
    t.string   "highest_degree",         limit: 191
    t.datetime "birthday"
    t.string   "position",               limit: 191
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
    t.string   "search_city",            limit: 191
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

  create_table "work_experiences", force: :cascade do |t|
    t.integer  "resume_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "company",    limit: 191
    t.string   "position",   limit: 191
    t.datetime "started_at"
    t.datetime "left_time"
    t.text     "job_desc",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "certificates", "users"
end
