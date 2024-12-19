module D19P1
  class D19P1
    def run(input)
      @towels = input.shift.split(', ')
      input.shift
      sum = 0
      input.each do |pattern|
        sum += 1 if can_make?(pattern)
      end
      puts "Sum: #{sum}"
    end
    def can_make?(pattern)
      return true if pattern == ""
      @towels.each do |towel|
        return true if pattern.start_with?(towel) and can_make?(pattern[towel.length..-1])
      end
      return false
    end
  end
end
