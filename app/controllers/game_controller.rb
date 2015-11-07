class GameController < ApplicationController
  def index
    @challenge = JSON.load(Rails.root.join('app/challenges/challenges-ruby.json'))
  end
end
