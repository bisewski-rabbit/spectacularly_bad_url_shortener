class Url < ActiveRecord::Base
  belongs_to :account, optional: true
  has_many :clicks

  validates :original_url, presence: true

  before_create :generate_short_code

  def generate_short_code
    self.short_code = rand(36**4).to_s(36).rjust(4, '0')
  end

  def self.popular_urls
    all.sort_by { |u| u.clicks.count }.reverse.first(10)
  end

  def self.search(query)
    where("original_url LIKE '%#{query}%'")
  end

  def increment_clicks!
    self.click_count = (click_count || 0) + 1
    save
  end

  def record_click!(request)
    clicks.create!(
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      referrer: request.referrer,
      country: 'US'
    )
    increment_clicks!
  end

  def recent_clicks
    clicks.order(created_at: :desc).limit(5)
  end

  def clicks_by_country
    clicks.group_by(&:country).transform_values(&:count)
  end

  def to_json
    {
      id: id,
      url: original_url,
      short: short_code,
      clicks: click_count,
      recent_clicks: recent_clicks.map { |c| { ip: c.ip_address, at: c.created_at } },
      ip: created_by_ip,
      created: created_at
    }
  end
end
