module D16P1
  class D16P1
    def run(input)
      maze = {}
      start, finish = nil, nil
      dir = Vector[1, 0]
      dirs = [Vector[0, -1], Vector[1, 0], Vector[0, 1], Vector[-1, 0]]
      input.each_with_index do |line, y|
        line.split('').each_with_index do |char, x|
          if char == 'S'
            start = Vector[x, y]
            maze[Vector[x, y]] = true
          elsif char == 'E'
            finish = Vector[x, y]
            maze[Vector[x, y]] = true
          elsif char == '.'
            maze[Vector[x, y]] = true
          end
        end
      end
      queue = [{pos: start, dir: dir, score: 0}]
      while queue.length > 0 and queue[0][:pos] != finish
        current = queue.shift
        dirs.each do |next_dir|
          next_pos = current[:pos] + next_dir
          if maze[next_pos]
            next_score = current[:score] + 1
            if next_dir != current[:dir]
              next_score += 1000
            end
            queue << {pos: next_pos, dir: next_dir, score: next_score}
            maze[next_pos] = false
          end
        end
        queue.sort! { |a, b| a[:score] <=> b[:score] }
      end
      puts "Score: #{queue[0][:score]}"
    end
  end
end
