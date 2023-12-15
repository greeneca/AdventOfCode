module D12P2
  class D12P2
    def run(input)
      input.map! do |row|
        [row[0], row.chomp[1..-1].to_i]
      end
      position = Matrix[[0],[0]]
      waypoint = Matrix[[10],[-1]]
      input.each do |command|
        #puts "Command: #{command}"
        case command[0]
        when "N"
          waypoint += Matrix[[0],[-1]]*command[1]
        when "S"
          waypoint += Matrix[[0],[1]]*command[1]
        when "E"
          waypoint += Matrix[[1],[0]]*command[1]
        when "W"
          waypoint += Matrix[[-1],[0]]*command[1]
        when "L"
          (command[1]/90).times{waypoint = turn_left(waypoint)}
        when "R"
          (command[1]/90).times{waypoint = turn_right(waypoint)}
        when "F"
          position += waypoint*command[1]
        end
        #puts "Position: #{position}, Waypoint:#{waypoint}"
      end
      puts "Distance: #{position.to_a.flatten.map{|x| x.abs}.reduce(:+)}"
    end

    def turn_left(direction)
      new_array = direction.to_a.flatten.reverse
      new_array[1] *= -1
      Matrix.column_vector(new_array)
    end

    def turn_right(direction)
      new_array = direction.to_a.flatten.reverse
      new_array[0] *= -1
      Matrix.column_vector(new_array)
    end
  end
end
