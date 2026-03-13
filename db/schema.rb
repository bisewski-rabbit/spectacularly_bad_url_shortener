ActiveRecord::Schema[7.1].define(version: 2024_01_01_000002) do
  create_table "urls", force: :cascade do |t|
    t.string "original_url"
    t.string "short_code"
    t.integer "click_count"
    t.string "created_by_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clicks", force: :cascade do |t|
    t.integer "url_id"
    t.string "ip_address"
    t.string "user_agent"
    t.string "referrer"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end

