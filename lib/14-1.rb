module D14P1
  class D14P1
    def run(input)
      mirror = {}
      rolling = []
      input.each_with_index do |line, y|
        line.split("").each_with_index do |rock, x|
          if rock != "."
            mirror[Vector[x,y]] = (rock == "O")
            rolling.push Vector[x,y] if rock == "O"
          end
        end
      end
      rolling.each do |rock|
        while rock[1] > 0 and mirror[Vector[rock[0],rock[1]-1]].nil?
          mirror.delete rock
          rock = Vector[rock[0],rock[1]-1]
          mirror[rock] = true
        end
      end
      sum = 0
      mirror.each_pair do |vector, rolling|
        if rolling
          sum += input.count - vector[1]
        end
      end
      puts "Sum: #{sum}"
    end
  end
end
