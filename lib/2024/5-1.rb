module D5P1
  class D5P1
    def run(input)
      rules = {}
      line = input.shift
      while not line.empty?
        line = line.split('|')
        rules[line[0]] ||= []
        rules[line[0]].push(line[1])
        line = input.shift
      end
      sum = 0
      input.each do |pages|
        pages = pages.split(',')
        sorted = pages.sort{|a,b|
          if rules[a] and rules[a].include?(b)
            -1
          elsif rules[b] and rules[b].include?(a)
            1
          else
            0
          end
        }
        if sorted == pages
          sum += pages[pages.length/2].to_i
        end
      end
      puts "Sum: #{sum}"
    end
  end
end
