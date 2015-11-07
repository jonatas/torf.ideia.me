task 'load_game' => :environment do
  easy = Challenge.find_or_initialize_by title: "Ruby easy"
  easy.challenges = Parser.load Rails.root.join('app/challenges/first_take.rb')
  easy.save
  p easy
  easy.reload
  p easy.challenges
end