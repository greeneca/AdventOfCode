module D6P2
  class D6P2
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
      start = guard.clone
      positions = {}
      check_map(map, guard, dir, history, max_x, max_y, positions)
      puts "Positions: #{positions.length}"
    end

    def check_map(map, guard, dir, history, max_x, max_y, positions, added=nil)
      map = map.clone
      history = history.clone
      while is_in_grid(guard, max_x, max_y)
        turn = Vector[-dir[1], dir[0]]
        next_pos = guard + dir
        if map[next_pos]
          dir = turn
        else
          if history[[guard,dir]] and added
            positions[added] = true
            return
          elsif added.nil? and not passed_point(next_pos, history) and is_in_grid(next_pos, max_x, max_y)
            map[next_pos] = true
            check_map(map, guard, dir, history, max_x, max_y, positions, next_pos)
            map.delete(next_pos)
          end
          history[[guard,dir]] = true
          guard = next_pos
        end
      end
    end
    def passed_point(point, history)
      dirs = [Vector[0,1], Vector[0,-1], Vector[1,0], Vector[-1,0]]
      dirs.each do |dir|
        if history[[point,dir]]
          return true
        end
      end
      return false
    end
    def is_in_grid(point, max_x, max_y)
      return (point[0]<=max_x and point[0]>=0 and point[1]<=max_y and point[1]>=0)
    end
  end
end
