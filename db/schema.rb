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

ActiveRecord::Schema.define(version: 20161015112953) do

  create_table "alignments", force: :cascade do |t|
    t.integer  "alignable_id",   limit: 4
    t.string   "meta",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alignable_type", limit: 50
  end

  add_index "alignments", ["alignable_id", "alignable_type"], name: "index_alignments_on_alignable_id_and_alignable_type", using: :btree

  create_table "batches", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "groups_count", limit: 4
    t.integer  "user_id",      limit: 4
  end

  add_index "batches", ["user_id"], name: "index_batches_on_user_id", using: :btree

  create_table "codeml_results", force: :cascade do |t|
    t.float   "k",                 limit: 24
    t.float   "w0",                limit: 24
    t.float   "w1",                limit: 24
    t.float   "p0",                limit: 24
    t.float   "p1",                limit: 24
    t.integer "profile_report_id", limit: 4
  end

  add_index "codeml_results", ["profile_report_id"], name: "index_codeml_results_on_profile_report_id", using: :btree

  create_table "fast_result_branches", force: :cascade do |t|
    t.integer "fast_result_id", limit: 4,                           null: false
    t.integer "number",         limit: 4,                           null: false
    t.decimal "l0",                       precision: 16, scale: 11
    t.decimal "l1",                       precision: 16, scale: 11
    t.boolean "positive"
    t.decimal "q",                        precision: 16, scale: 11
  end

  add_index "fast_result_branches", ["fast_result_id", "positive"], name: "index_fast_result_branches_on_fast_result_id_and_positive", using: :btree

  create_table "fast_result_sites", force: :cascade do |t|
    t.integer "fast_result_id", limit: 4,                         null: false
    t.integer "branch",         limit: 4,                         null: false
    t.integer "position",       limit: 4,                         null: false
    t.decimal "probability",              precision: 7, scale: 6, null: false
  end

  add_index "fast_result_sites", ["fast_result_id"], name: "index_fast_result_sites_on_fast_result_id", using: :btree

  create_table "fast_results", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "has_positive"
    t.integer  "profile_report_id", limit: 4
  end

  add_index "fast_results", ["profile_report_id"], name: "index_fast_results_on_profile_report_id", using: :btree

  create_table "fasta_files", force: :cascade do |t|
    t.string   "representable_as_fasta_type", limit: 255
    t.integer  "representable_as_fasta_id",   limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "file_file_name",              limit: 255
    t.string   "file_content_type",           limit: 255
    t.integer  "file_file_size",              limit: 4
    t.datetime "file_updated_at"
  end

  add_index "fasta_files", ["representable_as_fasta_id", "representable_as_fasta_type"], name: "fasta_filex_polymorphic", using: :btree

  create_table "group_identifier_links", force: :cascade do |t|
    t.integer "group_id",      limit: 4, null: false
    t.integer "identifier_id", limit: 4, null: false
  end

  add_index "group_identifier_links", ["group_id", "identifier_id"], name: "index_group_identifier_links_on_group_id_and_identifier_id", unique: true, using: :btree
  add_index "group_identifier_links", ["identifier_id"], name: "index_group_identifier_links_on_identifier_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer "avg_sequence_length", limit: 4
    t.integer "batch_id",            limit: 4
    t.integer "user_id",             limit: 4
    t.boolean "preprocessing_done",            default: false, null: false
  end

  add_index "groups", ["batch_id"], name: "index_groups_on_batch_id", using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "identifiers", force: :cascade do |t|
    t.string "name",     limit: 255, null: false
    t.string "codename", limit: 10
  end

  add_index "identifiers", ["codename"], name: "index_identifiers_on_codename", unique: true, using: :btree
  add_index "identifiers", ["name"], name: "index_identifiers_on_name", unique: true, using: :btree

  create_table "profile_group_links", force: :cascade do |t|
    t.integer "group_id",   limit: 4, null: false
    t.integer "profile_id", limit: 4, null: false
  end

  add_index "profile_group_links", ["group_id"], name: "index_profile_group_links_on_group_id", using: :btree
  add_index "profile_group_links", ["profile_id", "group_id"], name: "index_profile_group_links_on_profile_id_and_group_id", unique: true, using: :btree

  create_table "profile_reports", force: :cascade do |t|
    t.integer  "group_id",   limit: 4, null: false
    t.integer  "profile_id", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name",                  limit: 255,   null: false
    t.text     "description",           limit: 65535
    t.integer  "user_id",               limit: 4,     null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "tool_for_alignment_id", limit: 4
    t.integer  "tool_for_filtering_id", limit: 4
    t.integer  "tool_for_tree_id",      limit: 4
    t.integer  "tool_for_selection_id", limit: 4
  end

  add_index "profiles", ["user_id", "name"], name: "index_profiles_on_user_id_and_name", using: :btree

  create_table "text_files", force: :cascade do |t|
    t.string   "textifilable_type", limit: 20,  null: false
    t.integer  "textifilable_id",   limit: 4,   null: false
    t.string   "meta",              limit: 255
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "text_files", ["textifilable_id", "textifilable_type"], name: "index_text_files_on_textifilable_id_and_textifilable_type", using: :btree

  create_table "tool_profile_params", force: :cascade do |t|
    t.string   "key",             limit: 255, null: false
    t.string   "value",           limit: 255, null: false
    t.integer  "tool_profile_id", limit: 4,   null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "tool_profile_params", ["tool_profile_id"], name: "index_tool_profile_params_on_tool_profile_id", using: :btree

  create_table "tool_profiles", force: :cascade do |t|
    t.string   "name",        limit: 255,   null: false
    t.text     "description", limit: 65535
    t.integer  "tool_id",     limit: 4,     null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "tool_profiles", ["tool_id"], name: "index_tool_profiles_on_tool_id", using: :btree

  create_table "tool_reports", force: :cascade do |t|
    t.string   "program",            limit: 20
    t.string   "version",            limit: 255
    t.string   "params",             limit: 255
    t.date     "start"
    t.date     "finish"
    t.integer  "runtime",            limit: 4
    t.text     "directory_snapshot", limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "successful"
    t.integer  "profile_report_id",  limit: 4
    t.string   "exec",               limit: 255
    t.integer  "tool_id",            limit: 4
  end

  add_index "tool_reports", ["profile_report_id"], name: "index_tool_reports_on_profile_report_id", using: :btree
  add_index "tool_reports", ["tool_id"], name: "index_tool_reports_on_tool_id", using: :btree

  create_table "tools", force: :cascade do |t|
    t.string   "name",        limit: 150,   null: false
    t.text     "description", limit: 65535
    t.string   "class_name",  limit: 80,    null: false
    t.string   "job",         limit: 50,    null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "tools", ["job"], name: "index_tools_on_job", using: :btree

  create_table "trees", force: :cascade do |t|
    t.binary  "newick",        limit: 65535
    t.integer "treeable_id",   limit: 4
    t.string  "treeable_type", limit: 20
  end

  add_index "trees", ["treeable_id", "treeable_type"], name: "index_trees_on_treeable_id_and_treeable_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "role",                   limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
