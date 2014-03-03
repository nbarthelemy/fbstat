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

ActiveRecord::Schema.define(version: 20140228181704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batting_stats", force: true do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.integer "year"
    t.integer "games_played"
    t.integer "at_bats"
    t.integer "runs"
    t.integer "hits"
    t.integer "doubles"
    t.integer "triples"
    t.integer "homeruns"
    t.integer "rbis"
    t.integer "stolen_bases"
    t.integer "caught_stealing"
  end

  add_index "batting_stats", ["player_id"], name: "index_batting_stats_on_player_id", using: :btree
  add_index "batting_stats", ["team_id"], name: "index_batting_stats_on_team_id", using: :btree

  create_table "players", force: true do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "birth_year"
    t.string "code"
  end

  create_table "teams", force: true do |t|
    t.string "name"
    t.string "league"
    t.string "code"
  end

end
