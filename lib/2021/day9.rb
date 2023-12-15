module D9P1
  class D9P1
    def run(input)
      map = {}
      input.each_with_index do |line,y|
        line.strip.split("").each_with_index do |value,x|
          map[Matrix[[x],[y]]] = value.to_i
        end
      end
      low = []
      map.each_pair do |position,value|
        is_lowest = true
        [Matrix[[-1],[0]], Matrix[[1],[0]], Matrix[[0],[-1]], Matrix[[0],[1]]].each do |offset|
          check_position = offset + position
          if map[check_position]
            if map[check_position] <= map[position]
              is_lowest = false
              break
            end
          end
        end
        if is_lowest
          low.push position
        end
      end
      risk = 0
      low.each do |position|
        risk += 1 + map[position]
      end
      puts "Risk Level: #{risk}"
    end
  end
end

module D9P2
  class D9P2
    def run(input)
      map = {}
      input.each_with_index do |line,y|
        line.strip.split("").each_with_index do |value,x|
          map[Matrix[[x],[y]]] = value.to_i
        end
      end
      low = []
      quadrents = [Matrix[[-1],[0]], Matrix[[1],[0]], Matrix[[0],[-1]], Matrix[[0],[1]]]
      map.each_pair do |position,value|
        is_lowest = true
        quadrents.each do |offset|
          check_position = offset + position
          if map[check_position]
            if map[check_position] <= map[position]
              is_lowest = false
              break
            end
          end
        end
        if is_lowest
          low.push position
        end
      end
      basins = []
      low.each do |position|
        basin = []
        to_check = [position]
        loop do
          break if to_check.count == 0
          checking = to_check.shift
          basin.push checking
          quadrents.each do |offset|
             check = checking+offset
             if map[check]
               if map[check] >= map[checking] and map[check] != 9 and not (basin+to_check).include?(check)
                 to_check.push check
               end
             end
          end
        end
        basins.push basin
      end
      basins.sort!{|a,b| b.size <=> a.size}
      size = basins[0..2].reduce(1){|sum,n| sum * n.size}
      puts "Basin Size Product: #{size}"
    end
  end
end
