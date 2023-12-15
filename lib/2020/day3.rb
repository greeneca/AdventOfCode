module D3P1
  class D3P1
    def run(input)
      input.map!{|line| line.split("")}
      x = 0
      count = 0
      input.each_index do |idx|
        if input[idx][x % (input[idx].count-1)] == "#"
          count += 1
        end
        x += 3
      end
      puts "Trees Hit: #{count}"
    end
  end
end

module D3P2
  class D3P2
    def run(input)
      input.map!{|line| line.split("")}
      slopes = [[1,1], [1,3], [1,5], [1,7], [2, 1]]
      total = 1
      slopes.each do |slope|
        y = 0
        x = 0
        count = 0
        while y < input.count
          if input[y][x % (input[y].count-1)] == "#"
            count += 1
          end
          y += slope[0]
          x += slope[1]
        end
        total *= count
      end
      puts "Total: #{total}"
    end
  end
end
