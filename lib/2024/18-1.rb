module D18P1
  class D18P1
    def run(input)
      max_x, max_y = 70, 70
      bytes = 1024
      map = {}
      bytes.times do |i|
        x, y = input[i].split(',').map{|s| s.to_i}
        map[Vector[x, y]] = true
      end
      queue = [{pos: Vector[0, 0], steps: 0}]
      while queue.length > 0
        current = queue.shift
        if current[:pos] == Vector[max_x, max_y]
          puts "Steps: #{current[:steps]}"
          break
        end
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
          next_pos = current[:pos] + Vector[*dir]
          if next_pos[0] >= 0 and next_pos[0] <= max_x and next_pos[1] >= 0 and next_pos[1] <= max_y and not map[next_pos]
            map[next_pos] = true
            queue.push({pos: next_pos, steps: current[:steps]+1})
          end
        end
      end
    end
  end
end
