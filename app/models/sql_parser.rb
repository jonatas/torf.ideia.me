require 'pg_query'
class SqlParser

  def self.parse(file)
    parse_result = PgQuery.parse(content=IO.read(file))
    stmts = parse_result.tree.stmts.map{|e|content[e.stmt_location, e.stmt_len]}
    result =  -> (query) { ActiveRecord::Base.connection.execute(query).to_a.first&.first&.last}
    items = []
    setup = []
    stmts.each do |stmt|
      code = stmt.lines
      hint = code.delete_if{|e|e =~ /^\s*--/}.join
      sql = code.join
      if not (answer=result[sql]).nil?
        items << {code: sql, hint: hint, answer: answer}
      else
        if items.empty?
          setup << sql
        else
          puts msg="setup items being added after #{items.size} items already exists"
          puts "setup: #{setup}"
          puts "items: #{items.inspect}"
          raise msg
        end
      end
    end
    setup.reverse.each do |item|
      items.insert(0, {setup: item})
    end
    items
  end
end
