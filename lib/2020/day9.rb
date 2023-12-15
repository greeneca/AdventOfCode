module D9P1
  class D9P1
    def run(input)
      input.map!{|x| x.to_i}
      range = 25
      idx = range
      while idx < input.count
        sums = input[(idx-range)...idx].combination(2).map {|x| x.reduce(:+)}
        unless sums.include?(input[idx])
          puts "Missing sums for #{input[idx]}"
          return
        end
        idx += 1
      end
    end
  end
end

module D9P2
  class D9P2
    def run(input)
      input.map!{|x| x.to_i}
      range = 25
      idx = range
      while idx < input.count
        sums = input[(idx-range)...idx].combination(2).map {|x| x.reduce(:+)}
        unless sums.include?(input[idx])
          break
        end
        idx += 1
      end
      value = input[idx]
      i = 0
      j = 1
      while j < input.count
        sum = input[i..j].reduce(:+)
        if sum < value
          j += 1
        elsif sum > value
          i += 1
        elsif sum == value
          break
        end
      end
      set = input[i..j].sort
      puts "Weakness: #{set.first + set.last}"
    end
  end
end
