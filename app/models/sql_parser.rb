require 'pg_query'
class SqlParser

  def self.parse(file)
    parse_result = PgQuery.parse(content=IO.read(file))
    stmts = parse_result.tree.stmts.map{|e|content[e.stmt_location, e.stmt_len]}
    result =  -> (query) { ActiveRecord::Base.connection.execute(query).to_a.first.first.last}
    items = []
    stmts.each do |stmt|
      code = stmt.lines
      hint = code.delete_if{|e|e =~ /^\s*--/}.join
      sql = code.join
      items << {code: sql, hint: hint, answer: result[sql]}
    end
    items
  end
end
