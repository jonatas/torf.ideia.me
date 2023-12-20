class User < ActiveRecord::Base
  has_many :scores

  validates :provider, :uid, :presence => true, :allow_blank => false

  def last_scores
    scores.select('distinct on (challenge_id) *').order('challenge_id, created_at desc')
  end
  #
  # from_omniauth
  #
  def self.from_omniauth(auth_hash)
    user = where(:provider => auth_hash[:provider])
      .where(:uid => auth_hash[:uid])
      .first

    if user.nil?
      user = User.new
      user.provider = auth_hash[:provider]
      user.uid = auth_hash[:uid]
      user.save
    end

    user
  end
end
