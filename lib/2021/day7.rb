module D7P1
  class D7P1
    def run(input)
      input = input.first.split(",").map{|x| x.to_i}
      mid = (input.count/2)-1
      target = input.sort[mid]
      spent = 0
      input.each {|x| spent += (target-x).abs}
      puts "Fuel Spent: #{spent}"
    end
  end
end

module D7P2
  class D7P2
    def run(input)
      input = input.first.split(",").map{|x| x.to_i}
      min = nil
      min_target = nil
      (-10..10).each do |i|
        target = (input.sum/(input.count*1.0)).round
        target += i
        spent = 0
        @fuel_per_move = {
          0 => 0,
          1 => 1
        }
        input.sort{|a,b| (target-a).abs <=> (target-b).abs}.each do |x|
          moves = (target-x).abs
          spent += fuel(moves)
        end
        if min.nil? or spent < min
          min = spent
          min_target = target
        end

      end
      puts "Fuel Spent for #{min_target}: #{min}"
    end

    def fuel(moves)
      if @fuel_per_move[moves]
        return @fuel_per_move[moves]
      end
      fuel = moves + fuel(moves-1)
      @fuel_per_move[moves] = fuel
      return fuel
    end
  end
end
