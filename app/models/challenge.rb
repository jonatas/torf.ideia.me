class Challenge < ActiveRecord::Base
  def estimated_time
    items.size * 5
  end
end
