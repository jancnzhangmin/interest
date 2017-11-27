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

ActiveRecord::Schema.define(version: 20171126100630) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "login"
    t.string   "password_digest"
    t.string   "auth"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "capitals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.float    "capital",    limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "bankdeposit"
    t.string   "bankaccount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "deposits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "deposittypedef_id"
    t.integer  "user_id"
    t.string   "ordernumber"
    t.float    "amount",            limit: 24
    t.integer  "red"
    t.integer  "redid"
    t.text     "content",           limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "deposittypedefs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "depostitype"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "finterests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.float    "amount",          limit: 24
    t.integer  "incapitalstatus"
    t.integer  "interesttype"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "interestday"
  end

  create_table "flogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "log"
    t.string   "logtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "user"
  end

  create_table "interestlogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.float    "amount",     limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "interestversions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.float    "rate",       limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "regions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "region"
    t.integer  "up_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["up_id"], name: "index_regions_on_up_id", using: :btree
  end

  create_table "relationdefs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "relation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "monthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "srelations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "relationdef_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "tel"
    t.string   "address"
    t.string   "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "takeouts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "ordernumber"
    t.float    "amount",      limit: 24
    t.integer  "red"
    t.integer  "redid"
    t.text     "content",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "card_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "region_id"
    t.integer  "interestversion_id"
    t.string   "username"
    t.integer  "sex"
    t.string   "address"
    t.string   "tel"
    t.text     "content",            limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.float    "capital",            limit: 24
  end

end
