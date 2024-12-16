module D15P1
  class D15P1
    def run(input)
      @map = {}
      @robot = nil
      do_move = false
      dirs = {"^" => Vector[0, -1], "v" => Vector[0, 1], "<" => Vector[-1, 0], ">" => Vector[1, 0]}
      input.each_with_index do |line, y|
        if line == ""
          do_move = true
        elsif not do_move
          line.split('').each_with_index do |char, x|
            if char == "@"
              @robot = Vector[x, y]
              @map[Vector[x, y]] = "."
            else
              @map[Vector[x, y]] = char
            end
          end
        else
          line.split('').each do |movement|
            perform_move(dirs[movement])
          end
        end
      end
      sum = 0
      @map.select{|k,v| v == "O"}.each do |k,v|
        sum += k[0] + (k[1]*100)
      end
      puts "Sum: #{sum}"
    end
    def perform_move(dir)
      next_pos = @robot + dir
      until @map[next_pos] == "#" or @map[next_pos] == "."
        next_pos = next_pos + dir
      end
      if @map[next_pos] == "."
        @robot = @robot + dir
        if @map[@robot] == "O"
          @map[@robot] = "."
          @map[next_pos] = "O"
        end
      end
    end
  end
end
