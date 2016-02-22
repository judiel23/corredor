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

ActiveRecord::Schema.define(version: 20151119222652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "corredors", force: :cascade do |t|
    t.text     "marca"
    t.text     "modelo"
    t.text     "year"
    t.text     "version"
    t.text     "zona"
    t.text     "poliza"
    t.text     "cedula"
    t.text     "nombre"
    t.text     "apellido"
    t.text     "sexo"
    t.text     "estado"
    t.text     "fnacimiento"
    t.text     "tfijo"
    t.text     "tcelular"
    t.text     "informacion"
    t.text     "email"
    t.text     "nacion"
    t.text     "dia"
    t.text     "mes"
    t.text     "anio"
    t.text     "cod1"
    t.text     "cod2"
    t.text     "ced"
    t.text     "telefono"
    t.text     "celular"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "placa"
    t.string   "vehicle_use"
    t.string   "vehicle_type"
    t.string   "cerokm"
    t.string   "sumaAsegurada"
  end

  create_table "cotiz_apps", force: :cascade do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "dni_type"
    t.string   "dni_number"
    t.string   "local_code_area"
    t.string   "local_phone"
    t.string   "movil_code_area"
    t.string   "movil_phone"
    t.datetime "birthday"
    t.string   "marital_status",    limit: 1
    t.string   "sex",               limit: 1
    t.string   "email"
    t.string   "vehicle_year",      limit: 4
    t.string   "vehicle_brand"
    t.string   "vehicle_model"
    t.string   "vehicle_version"
    t.string   "plaque"
    t.string   "intermediate_code", limit: 6
    t.string   "state"
    t.string   "plan_code"
    t.string   "plan_review"
    t.string   "discount_rate"
    t.string   "vehicle_use"
    t.string   "kilometer_zero",    limit: 1
    t.string   "vehicle_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "sumaAsegurada"
  end

  create_table "form_uni_seguros", force: :cascade do |t|
    t.string   "desnombre",        limit: 100
    t.string   "desapellido",      limit: 100
    t.string   "rif",              limit: 9
    t.string   "codarealocal",     limit: 4
    t.string   "numtelefonolocal", limit: 7
    t.string   "codareacel",       limit: 4
    t.string   "numtelefcel",      limit: 7
    t.datetime "fecnac"
    t.string   "codedocivil",      limit: 1
    t.string   "codsexo",          limit: 1
    t.string   "email",            limit: 100
    t.string   "codmarca",         limit: 3
    t.string   "codmodelo",        limit: 4
    t.string   "codversion",       limit: 5
    t.integer  "anoveh"
    t.string   "codinter",         limit: 6
    t.string   "codestado",        limit: 3
    t.string   "codplan",          limit: 3
    t.string   "revplan",          limit: 3
    t.integer  "porcdcto"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "insurance_brokers", force: :cascade do |t|
    t.integer  "users_id"
    t.string   "insurance"
    t.string   "intermediary_code"
    t.string   "plan_code",         limit: 5
    t.string   "plan_review",       limit: 5
    t.string   "discount_rate"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "insurance_brokers", ["users_id"], name: "index_insurance_brokers_on_users_id", using: :btree

  create_table "insurance_responses", force: :cascade do |t|
    t.string   "insurance"
    t.integer  "cotiz_app_id"
    t.integer  "corredor_id"
    t.text     "response"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "insurance_responses", ["corredor_id"], name: "index_insurance_responses_on_corredor_id", using: :btree
  add_index "insurance_responses", ["cotiz_app_id"], name: "index_insurance_responses_on_cotiz_app_id", using: :btree

  create_table "makes", force: :cascade do |t|
    t.string   "code"
    t.string   "make"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "insurance"
    t.string   "status"
    t.integer  "corredor_id"
    t.decimal  "cobertura",       precision: 20, scale: 2
    t.decimal  "eventos",         precision: 20, scale: 2
    t.decimal  "aire",            precision: 20, scale: 2
    t.decimal  "radio",           precision: 20, scale: 2
    t.decimal  "responsabilidad", precision: 20, scale: 2
    t.decimal  "muerte",          precision: 20, scale: 2
    t.decimal  "invalidez",       precision: 20, scale: 2
    t.decimal  "curacion",        precision: 20, scale: 2
    t.decimal  "entierro",        precision: 20, scale: 2
    t.decimal  "cosa_dan",        precision: 20, scale: 2
    t.decimal  "personas_dan",    precision: 20, scale: 2
    t.decimal  "exceso_cosa",     precision: 20, scale: 2
    t.decimal  "exceso_persona",  precision: 20, scale: 2
    t.decimal  "asistencia",      precision: 20, scale: 2
    t.decimal  "prima",           precision: 20, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "num_cotiza"
    t.string   "versionList"
    t.string   "actualCoti"
    t.string   "cotizacion"
  end

  add_index "reports", ["corredor_id"], name: "index_reports_on_corredor_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "password_changed_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "make"
    t.string   "code"
    t.string   "model"
    t.string   "clasiveh"
    t.string   "vehicle_size"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "make"
    t.string   "model"
    t.string   "code"
    t.string   "version"
    t.string   "descmotor"
    t.string   "desctransmision", limit: 5
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
