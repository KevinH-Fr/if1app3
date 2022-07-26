# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_11_190204) do
  create_table "active_analytics_views_per_days", force: :cascade do |t|
    t.string "site", null: false
    t.string "page", null: false
    t.date "date", null: false
    t.bigint "total", default: 1, null: false
    t.string "referrer_host"
    t.string "referrer_path"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["date"], name: "index_active_analytics_views_per_days_on_date"
    t.index ["referrer_host", "referrer_path", "date"], name: "index_active_analytics_views_per_days_on_referrer_and_date"
    t.index ["site", "page", "date"], name: "index_active_analytics_views_per_days_on_site_and_date"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "circuits", force: :cascade do |t|
    t.string "nom"
    t.string "pays"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "adresse"
    t.decimal "latitude"
    t.decimal "longitude"
  end

  create_table "classecuries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.decimal "cote_victoire"
    t.integer "pilote_id", null: false
    t.integer "event_id", null: false
    t.decimal "score"
    t.decimal "cote_podium"
    t.decimal "cote_top10"
    t.integer "nb_p1"
    t.integer "nb_p2"
    t.integer "nb_p3"
    t.integer "nb_p4"
    t.integer "nb_p5"
    t.integer "nb_p6"
    t.integer "nb_p7"
    t.integer "nb_p8"
    t.integer "nb_p9"
    t.integer "nb_p10"
    t.integer "nb_p11"
    t.integer "nb_p12"
    t.integer "nb_p13"
    t.integer "nb_p14"
    t.integer "nb_p15"
    t.integer "nb_p16"
    t.integer "nb_p17"
    t.integer "nb_p18"
    t.integer "nb_p19"
    t.integer "nb_p20"
    t.index ["event_id"], name: "index_classements_on_event_id"
    t.index ["pilote_id"], name: "index_classements_on_pilote_id"
  end

  create_table "cotes", force: :cascade do |t|
    t.decimal "coteVictoire"
    t.decimal "cotePodium"
    t.decimal "coteTop10"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pilote_id", null: false
    t.integer "event_id", null: false
    t.integer "position"
    t.decimal "cotePole"
    t.index ["event_id"], name: "index_cotes_on_event_id"
    t.index ["pilote_id"], name: "index_cotes_on_pilote_id"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "nom"
    t.integer "numero"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipes", force: :cascade do |t|
    t.string "nom"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "couleurRgb"
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.string "circuit"
    t.string "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "saison_id"
    t.integer "division_id"
    t.integer "numero"
    t.integer "circuit_id", null: false
    t.datetime "horaire"
    t.index ["circuit_id"], name: "index_events_on_circuit_id"
    t.index ["division_id"], name: "index_events_on_division_id"
    t.index ["saison_id"], name: "index_events_on_saison_id"
  end

  create_table "friends", force: :cascade do |t|
    t.string "nom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licences", force: :cascade do |t|
    t.integer "penalite"
    t.integer "recupere"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id"
    t.integer "pilote_id"
    t.index ["event_id"], name: "index_licences_on_event_id"
    t.index ["pilote_id"], name: "index_licences_on_pilote_id"
  end

  create_table "parieurs", force: :cascade do |t|
    t.integer "pilote_id", null: false
    t.integer "event_id", null: false
    t.bigint "cumul"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_parieurs_on_event_id"
    t.index ["pilote_id"], name: "index_parieurs_on_pilote_id"
  end

  create_table "paris", force: :cascade do |t|
    t.integer "typePari"
    t.integer "parieur_id"
    t.integer "coureur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id", null: false
    t.bigint "montant"
    t.decimal "cote"
    t.boolean "resultat"
    t.decimal "solde"
    t.integer "paritype"
    t.boolean "manuel"
    t.index ["coureur_id"], name: "index_paris_on_coureur_id"
    t.index ["event_id"], name: "index_paris_on_event_id"
    t.index ["parieur_id"], name: "index_paris_on_parieur_id"
  end

  create_table "pilotes", force: :cascade do |t|
    t.string "nom"
    t.string "statut"
    t.integer "ecurie"
    t.string "division"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "division_id"
    t.integer "user_id"
    t.string "rang_n0"
    t.string "rang_n1"
    t.integer "nb_p1"
    t.integer "nb_p2"
    t.integer "nb_p3"
    t.integer "nb_p4"
    t.integer "nb_p5"
    t.integer "points"
    t.boolean "Gainrivaliteprec"
    t.boolean "rivaliteprec"
    t.index ["division_id"], name: "index_pilotes_on_division_id"
    t.index ["user_id"], name: "index_pilotes_on_user_id"
  end

  create_table "rapportdois", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "pilote_id"
    t.string "pilote2"
    t.string "responsable"
    t.integer "reglement_id"
    t.integer "penalitelicence"
    t.integer "penalitetemps"
    t.text "commentaire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "demandeur"
    t.string "decision"
    t.index ["event_id"], name: "index_rapportdois_on_event_id"
    t.index ["pilote_id"], name: "index_rapportdois_on_pilote_id"
    t.index ["reglement_id"], name: "index_rapportdois_on_reglement_id"
  end

  create_table "rapports", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "pilote1_id", null: false
    t.integer "pilote2_id", null: false
    t.integer "responsable_id", null: false
    t.integer "article_id", null: false
    t.integer "penalitelicence"
    t.integer "penalitetemps"
    t.text "commentaire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_rapports_on_article_id"
    t.index ["event_id"], name: "index_rapports_on_event_id"
    t.index ["pilote1_id"], name: "index_rapports_on_pilote1_id"
    t.index ["pilote2_id"], name: "index_rapports_on_pilote2_id"
    t.index ["responsable_id"], name: "index_rapports_on_responsable_id"
  end

  create_table "reglements", force: :cascade do |t|
    t.string "version"
    t.string "titre"
    t.string "numero"
    t.text "description"
    t.integer "penalite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "commentaire"
    t.string "penalitetemps"
  end

  create_table "resultats", force: :cascade do |t|
    t.integer "qualification"
    t.integer "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pilote_id"
    t.integer "event_id"
    t.boolean "dotd"
    t.boolean "mt"
    t.decimal "score"
    t.integer "ecurie"
    t.boolean "dnf"
    t.boolean "dns"
    t.index ["event_id"], name: "index_resultats_on_event_id"
    t.index ["pilote_id"], name: "index_resultats_on_pilote_id"
  end

  create_table "saisons", force: :cascade do |t|
    t.string "nom"
    t.integer "numeroSaison"
    t.date "periode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "synthlicences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nom"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "classements", "events"
  add_foreign_key "classements", "pilotes"
  add_foreign_key "cotes", "events"
  add_foreign_key "cotes", "pilotes"
  add_foreign_key "events", "circuits"
  add_foreign_key "events", "divisions"
  add_foreign_key "events", "saisons"
  add_foreign_key "licences", "events"
  add_foreign_key "licences", "pilotes"
  add_foreign_key "parieurs", "events"
  add_foreign_key "parieurs", "pilotes"
  add_foreign_key "paris", "events"
  add_foreign_key "paris", "pilotes", column: "coureur_id"
  add_foreign_key "paris", "pilotes", column: "parieur_id"
  add_foreign_key "pilotes", "divisions"
  add_foreign_key "pilotes", "users"
  add_foreign_key "rapportdois", "events"
  add_foreign_key "rapportdois", "pilotes"
  add_foreign_key "rapportdois", "reglements"
  add_foreign_key "rapports", "articles"
  add_foreign_key "rapports", "events"
  add_foreign_key "rapports", "pilote1s"
  add_foreign_key "rapports", "pilote2s"
  add_foreign_key "rapports", "responsables"
  add_foreign_key "resultats", "events"
  add_foreign_key "resultats", "pilotes"
end
