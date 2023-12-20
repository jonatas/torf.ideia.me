class RubyParser
  def self.load file
    items = []
    lines = []
    File.readlines(file).each_with_index do |line, i|
      next if line =~ /^\s*#/
      if line !~ /^\s*$/
        lines.push line.chomp
        next
      elsif lines.empty?
        next
      else
        code = lines.join "\n"
        result = eval(code).inspect rescue puts("#{$!}\n -- #{code}") and $!
        # TODO: capture hints from comments
        items << {code: code, answer: result }
        lines = []
      end
    end
    items
  end
end
