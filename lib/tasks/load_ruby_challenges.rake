task 'load_game' => :environment  do
  {
    "Ruby easy" => "first_take",
    "Ruby medium" => "second_take",
    "Math basic" => "math_basic"
  }.each do |title,file|
    game= Challenge.find_or_initialize_by title: title
    game.items = Parser.load Rails.root.join("app/challenges/#{file}.rb")
    game.language = "ruby"
    game.save
    puts "#{title} - #{game.items.size} loaded!"
  end

  {
    "Javascript jokes" => "js_jokes",
    "Hacking basics" => "js_hacks"
  }.each do |title,file|
    game = Challenge.find_or_initialize_by title: title
    game.items = JSParser.load Rails.root.join("app/challenges/#{file}.js")
    game.language = "javascript"
    game.save
    puts "#{title} - #{game.items.size} loaded!"
  end
end