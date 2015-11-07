class ChallengeController < ApplicationController
  def index
    @challenge = Challenge.first.items
  end
end
