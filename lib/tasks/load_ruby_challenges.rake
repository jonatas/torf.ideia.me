task 'load_game' => :environment  do
  {
    "Ruby easy" => "first_take",
    "Ruby medium" => "second_take",
    "Math basic" => "math_basic"
  }.each do |title,file|
    easy = Challenge.find_or_initialize_by title: title
    easy.items = Parser.load Rails.root.join("app/challenges/#{file}.rb")
    easy.save
    puts "#{title} - #{easy.items.size} loaded!"
  end
end