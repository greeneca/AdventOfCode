module D11P1
  class D11P1
    def run(input)
      map = {}
      y = 0
      input.each do |line|
        if line.count("#") == 0
          y += 1
        else
          line.split("").each_with_index do |char, x|
            if char == "#"
              map[Vector[x, y]] = true
            end
          end
        end
        y += 1
      end
      #Expand in X dir
      x_values = map.keys.map{|k| k[0]}.uniq.sort
      missing = (0..(input[0].length-1)).to_a - x_values
      new_map = {}
      map.keys.each do |key|
        new_x = key[0]
        missing.each {|v| new_x += 1 if key[0] > v}
        new_map[Vector[new_x, key[1]]] = true
      end
      map = new_map
      sum = 0
      map.keys.combination(2) do |c|
        sum += ((c[0][0]-c[1][0]).abs + (c[0][1]-c[1][1]).abs)
      end
      puts "Sum: #{sum}"
    end
  end
end
