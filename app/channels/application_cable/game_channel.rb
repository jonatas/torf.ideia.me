class GameChannel < ApplicationCable::Channel
 def follow(data)
   Rails.logger.info data.inspect
    stop_all_streams
    stream_from "game"
  end

  def unfollow
    stop_all_streams
  end
end
