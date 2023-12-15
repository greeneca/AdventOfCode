module D10P1
  class D10P1
    def run(input)
      input.map!{|x| x.to_i}
      input.sort!
      input.unshift(0)
      input.push(input.last+3)
      diffs = []
      input.each_index do |i|
        if i > 0
          diff = input[i] - input[i-1]
          diffs[diff] ||= 0
          diffs[diff] += 1
        end
      end
      puts "Diffs: #{diffs.to_s}"
      puts "Result: #{diffs[1] * diffs[3]}"
    end
  end
end

module D10P2
  class D10P2
    def run(input)
      input.map!{|x| x.to_i}
      input.sort!
      input.unshift(0)
      input.push(input.last+3)
      items_to_remove = []
      group = []
      input.each_index do |i|
        if i > 0 and i < input.count-1
          diff = input[i] - input[i-1]
          next_diff = input[i+1] - input[i]
          if diff == 1 and next_diff == 1
            group.push(input[i])
          elsif group.count > 0
            items_to_remove.push(group)
            group = []
          end
        end
      end
      items_to_remove.map! do |group|
        count = 0
        (0..2).each do |i|
          count += group.combination(i).count
        end
        count
      end
      puts "Total Options: #{items_to_remove.reduce(1, :*)}"
    end
  end
end
