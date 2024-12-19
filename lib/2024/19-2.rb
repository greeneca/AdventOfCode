module D19P2
  class D19P2
    def run(input)
      @towels = input.shift.split(', ')
      input.shift
      sum = 0
      @cache = {}
      input.each do |pattern|
        sum += can_make_num(pattern)
      end
      puts "Sum: #{sum}"
    end
    def can_make_num(pattern)
      return 1 if pattern == ""
      return @cache[pattern] if @cache[pattern]
      sum = 0
      @towels.each do |towel|
        if pattern.start_with?(towel)
          sum += can_make_num(pattern[towel.length..-1])
        end
      end
      @cache[pattern] = sum
      return sum
    end
  end
end
