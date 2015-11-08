class User < ActiveRecord::Base
  validates :provider, :uid, :presence => true, :allow_blank => false

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
