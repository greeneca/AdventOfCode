module D6P1
  class D6P1
    def run(input)
      map = {}
      history = {}
      guard = nil
      dir = nil
      max_x = 0
      max_y = 0
      input.each_with_index do |line, y|
        line.split('').each_with_index do |char, x|
          max_x = x if x > max_x
          max_y = y if y > max_y
          if char == '#'
            map[Vector[x, y]] = true
          elsif char == '^'
            guard = Vector[x, y]
            dir = Vector[0, -1]
          end
        end
      end
      history[guard] = true
      while guard[0]<=max_x and guard[0]>=0 and guard[1]<=max_y and guard[1]>=0
        next_pos = guard + dir
        if map[next_pos]
          dir = Vector[-dir[1], dir[0]]
        else
          guard = next_pos
          history[guard] = true
        end
      end
      puts "Positions: #{history.length-1}"
    end
  end
end
