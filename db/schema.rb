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

ActiveRecord::Schema.define(version: 20160312192638) do

  create_table "alignments", force: :cascade do |t|
    t.binary   "fasta",      limit: 4294967295
    t.integer  "group_id",   limit: 4
    t.string   "meta",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "batches", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "groups_count", limit: 4
    t.integer  "user_id",      limit: 4
  end

  create_table "codeml_results", force: :cascade do |t|
    t.float   "k",        limit: 24
    t.float   "w0",       limit: 24
    t.float   "w1",       limit: 24
    t.float   "p0",       limit: 24
    t.float   "p1",       limit: 24
    t.text    "tree",     limit: 65535
    t.integer "group_id", limit: 4
    t.binary  "stdout",   limit: 4294967295
    t.binary  "stderr",   limit: 4294967295
    t.binary  "output",   limit: 4294967295
  end

  create_table "fast_results", force: :cascade do |t|
    t.integer  "group_id",     limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.binary   "stdout",       limit: 4294967295
    t.binary   "stderr",       limit: 4294967295
    t.binary   "output",       limit: 4294967295
    t.boolean  "has_positive"
  end

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

  create_table "groups", force: :cascade do |t|
    t.integer "sequences_count",     limit: 4
    t.boolean "has_paralogs"
    t.integer "avg_sequence_length", limit: 4
    t.integer "batch_id",            limit: 4
    t.integer "user_id",             limit: 4
  end

  create_table "identifiers", force: :cascade do |t|
    t.string  "name",            limit: 255
    t.integer "sequences_count", limit: 4
    t.string  "short_name",      limit: 255
    t.string  "codename",        limit: 255
  end

  create_table "run_reports", force: :cascade do |t|
    t.string   "program",            limit: 255
    t.string   "version",            limit: 255
    t.string   "params",             limit: 255
    t.binary   "stdout",             limit: 4294967295
    t.binary   "stderr",             limit: 4294967295
    t.binary   "result",             limit: 4294967295
    t.date     "start"
    t.date     "finish"
    t.integer  "runtime",            limit: 4
    t.text     "directory_snapshot", limit: 65535
    t.integer  "jobid",              limit: 4
    t.integer  "runnable_id",        limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "successful"
  end

  create_table "runnable_run_report_associations", force: :cascade do |t|
    t.string   "runnable_type", limit: 255
    t.integer  "runnable_id",   limit: 4
    t.integer  "run_report_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "sequences", force: :cascade do |t|
    t.binary  "sequence",      limit: 4294967295
    t.integer "identifier_id", limit: 4
    t.integer "group_id",      limit: 4
  end

  add_index "sequences", ["group_id"], name: "index_sequences_on_group_id", using: :btree
  add_index "sequences", ["identifier_id", "group_id"], name: "index_sequences_on_identifier_id_and_group_id", using: :btree

  create_table "text_files", force: :cascade do |t|
    t.string   "textifilable_type", limit: 255
    t.integer  "textifilable_id",   limit: 4
    t.string   "meta",              limit: 255
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size",    limit: 4
    t.datetime "file_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "text_files", ["textifilable_type", "meta", "textifilable_id"], name: "index_text_files_on_has_files_type_and_type_and_has_files_id", using: :btree
  add_index "text_files", ["textifilable_type", "textifilable_id"], name: "index_text_files_on_textifilable_type_and_textifilable_id", using: :btree

  create_table "trees", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.binary   "newick",     limit: 4294967295
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id",   limit: 4
  end

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
