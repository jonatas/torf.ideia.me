class JsParser
  def self.load file
    results = {}
    challenge = {}
    lines = []
    File.readlines(file).each_with_index do |line, i|
      next if line =~ %r{^\s*//}
      if line !~ /^\s*$/
        lines.push line.chomp
        next
      elsif lines.empty?
        next
        
      else
        ctx = V8::Context.new
        code = lines.join("\n")
        result = ctx.eval code
        challenge[code] = result
        lines = []
        results[result] ||= 0
        results[result] += 1
      end
    end
    challenge
  end
end
