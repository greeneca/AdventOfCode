module D15P1
  class D15P1
    def run(input)
      input.each do |line|
        list = line.chomp.split(",").map{|i| i.to_i}.reverse
        while list.count < 2020
          idx = list[1..-1].index(list.first)
          if idx
            list.unshift(idx+1)
          else
            list.unshift(0)
          end
        end
        puts "2020th Value for #{line.chomp}: #{list.first}"
      end
    end
  end
end

module D15P2
  class D15P2
    def run(input)
      input.each do |line|
        list = line.chomp.split(",").map{|i| i.to_i}
        hash = {}
        list[0..-2].each_with_index {|val, idx| hash[val] = idx}
        prev_value = list[-1]
        ((list.count)..(30000000-1)).each do |idx|
          next_value = 0
          if hash[prev_value]
            next_value = (idx-1)-hash[prev_value]
          end
          hash[prev_value] = idx-1
          prev_value = next_value
        end
        puts "30000000th Value for #{line.chomp}: #{prev_value}"
      end
    end
  end
end
