class Account < ActiveRecord::Base
  has_many :urls

  validates :email, presence: true
  validates :password, presence: true

  before_create :generate_api_key

  def generate_api_key
    self.api_key = rand(36**16).to_s(36)
  end

  def self.authenticate(email, password)
    account = find_by(email: email)
    return nil unless account
    return nil unless account.password == password
    account
  end

  def to_json
    {
      id: id,
      email: email,
      api_key: api_key,
      admin: admin,
      created_at: created_at
    }
  end
end
