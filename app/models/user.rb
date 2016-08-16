class User < ActiveRecord::Base
  attr_accessor :first_name, :last_name
  has_many :playlists, foreign_key: :admin_id
  has_many :votes

  has_secure_password
  before_validation :set_full_name

  validates :full_name, :email, presence: true
  validates :email, uniqueness: true

  def set_full_name
    if !self.full_name
      self.full_name = first_name + ' ' + last_name
    end
  end

  def spotify_user_hash
    eval(self.spotify_credentials)
  end
end
