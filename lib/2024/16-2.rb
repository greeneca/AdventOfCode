module D16P2
  class D16P2
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
      queue = [{pos: start, dir: dir, score: 0, path: {start => true}}]
      cache = {}
      shortest_cache = {}
      shortest = nil
      all_paths = []
      while queue.length > 0 and (shortest.nil? or queue[0][:score] <= shortest)
        current = queue.shift
        if current[:pos] == finish
          if (shortest == current[:score] or shortest.nil?)
            shortest = current[:score]
            all_paths += current[:path].keys
          end
          next
        end
        dirs.each do |next_dir|
          next_pos = current[:pos] + next_dir
          if maze[next_pos] and not current[:path][next_pos]
            next_score = current[:score] + 1
            if next_dir != current[:dir]
              next_score += 1000
            end
            if shortest_cache["#{next_pos}-#{next_dir}"].nil? or shortest_cache["#{next_pos}-#{next_dir}"] >= next_score
              shortest_cache["#{next_pos}-#{next_dir}"] = next_score
            else
              next
            end

            cached = cache["#{next_pos}-#{next_dir}-#{next_score}"]
            if cached
              cached[:path].merge!(current[:path])
              next
            end

            next_path = current[:path].clone
            next_path[next_pos] = true
            enqueue = {pos: next_pos, dir: next_dir, score: next_score, path: next_path}
            queue << enqueue
            cache["#{next_pos}-#{next_dir}-#{next_score}"] = enqueue
          end
        end
        queue.sort! { |a, b| a[:score] <=> b[:score] }
      end
      puts "Score: #{all_paths.uniq.length}"
    end
  end
end
