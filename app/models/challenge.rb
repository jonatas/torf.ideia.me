class Challenge < ActiveRecord::Base
  has_many :scores

  def estimated_time
    items.size * 5
  end
end
