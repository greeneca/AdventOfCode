module D12P1
  class D12P1
    def run(input)
      @map = {}
      input.each_with_index do |line, y|
        line.split('').each_with_index do |char, x|
          @map[Vector[x, y]] = char
        end
      end
      @to_check = @map.clone
      regions = []
      while @to_check.length > 0
        vector = @to_check.keys.first
        regions << check(vector, {area: 1, perimeter: 0, char: @map[vector]})
      end
      sum = 0
      regions.each do |region|
        sum += region[:area] * region[:perimeter]
      end
      puts "Sum: #{sum}"
    end
    def check(vector, region)
      @to_check.delete(vector)
      char = @map[vector]
      dirs = [Vector[0, 1], Vector[1, 0], Vector[0, -1], Vector[-1, 0]]
      dirs.each do |dir|
        next_pos = vector + dir
        if @map[next_pos] == char
          if @to_check[next_pos]
            region[:area] += 1
            region = check(next_pos, region)
          end
        else
          region[:perimeter] += 1
        end
      end
      return region
    end
  end
end
