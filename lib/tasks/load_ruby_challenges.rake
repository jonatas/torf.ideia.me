task 'load_game' => :environment  do
  {
    "Ruby easy" => "first_take",
    "Ruby medium" => "second_take",
    "Math basic" => "math_basic"
  }.each do |title,file|
    game= Challenge.find_or_initialize_by title: title, language: "ruby"
    game.items = Parser.load Rails.root.join("app/challenges/#{file}.rb")
    game.save
    puts "#{title} - #{game.items.size} loaded!"
  end

  require_relative '../../app/models/js_parser'

  {
    "Javascript jokes" => "js_jokes",
    "Hacking basics" => "js_hacks"
  }.each do |title,file|
    game = Challenge.find_or_initialize_by title: title, language: "javascript"
    game.items = JsParser.load Rails.root.join("app/challenges/#{file}.js")
    game.save
    puts "#{title} - #{game.items.size} loaded!"
  end

  { "Logical Operators" => "basic", "Arithmetics" => "arithmetics", "Date & Time" => "time" }.each do |title,file|
    items = File.readlines(Rails.root.join("app/challenges/#{file}.sql")).map(&:chomp)
    result =  -> (query) { ActiveRecord::Base.connection.execute(query).to_a.first.first.last}
    items = items.each_with_object({}) do |item, summary|
      summary[item] = result[item]
    end
    game = Challenge.find_or_initialize_by title: title, language: "sql"
    game.items = items
    game.save
    puts "#{title} - #{game.items.size} loaded!"
  end
end
