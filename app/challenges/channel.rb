module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def follow(data)
      stop_all_streams
      stream_from "game:#{data['challenge_id'].to_i}"
    end

    def unfollow
      stop_all_streams
    end
  end
end
