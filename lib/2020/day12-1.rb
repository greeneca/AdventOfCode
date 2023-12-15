module D12P1
  class D12P1
    def run(input)
      input.map! do |row|
        [row[0], row.chomp[1..-1].to_i]
      end
      position = Matrix[[0],[0]]
      direction = Matrix[[1],[0]]
      input.each do |command|
        case command[0]
        when "N"
          position += Matrix[[0],[-1]]*command[1]
        when "S"
          position += Matrix[[0],[1]]*command[1]
        when "E"
          position += Matrix[[1],[0]]*command[1]
        when "W"
          position += Matrix[[-1],[0]]*command[1]
        when "L"
          (command[1]/90).times{direction = turn_left(direction)}
        when "R"
          (command[1]/90).times{direction = turn_right(direction)}
        when "F"
          position += direction*command[1]
        end
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
