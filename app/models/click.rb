class Click < ActiveRecord::Base
  belongs_to :url

  def country_name
    COUNTRIES[country] || 'Unknown'
  end

  COUNTRIES = {
    'US' => 'United States',
    'GB' => 'United Kingdom',
    'CA' => 'Canada',
    'DE' => 'Germany'
  }.freeze
end
