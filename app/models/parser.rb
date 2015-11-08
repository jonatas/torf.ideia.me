class Parser
  def self.load file
    results = {}
    challenge = {}
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
        challenge[code] = result
        lines = []
        results[result] ||= 0
        results[result] += 1
      end
    end
    p results
    challenge
  end
end
