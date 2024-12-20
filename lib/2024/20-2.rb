module D20P2
  class D20P2
    def run(input)
      @map = {}
      @start = nil
      @end = nil
      gen_map(input)
      cheats = get_cheat_count(find_fastest)
      puts "Cheats: #{cheats}"
    end
    def gen_map(input)
      input.each_with_index do |line, y|
        line.split('').each_with_index do |char, x|
          if char == '.'
            @map[Vector[x, y]] = true
          elsif char == 'S'
            @start = Vector[x, y]
            @map[Vector[x, y]] = true
          elsif char == 'E'
            @end = Vector[x, y]
            @map[Vector[x, y]] = true
          end
        end
      end
    end
    def find_fastest
      queue = [{pos: @start, steps: 0, path: {@start => 0}}]
      while queue.length > 0
        current = queue.shift
        if current[:pos] == @end
          return current[:path]
        end
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
          next_pos = current[:pos] + Vector[*dir]
          if @map[next_pos] and not current[:path][next_pos]
            next_path = current[:path].clone
            next_path[next_pos] = current[:steps]+1
            queue.push({pos: next_pos, steps: current[:steps]+1, path: next_path})
          end
        end
      end
    end
    def get_cheat_count(path)
      cheats = {}
      path.keys.combination(2).each do |pair|
        pos1, pos2 = pair
        distance  = get_distance(pos1, pos2)
        saved = (path[pos1] - path[pos2]).abs - distance
        if distance <= 20 and saved >= 50
          cheats[saved] ||= 0
          cheats[saved] += 1
        end
      end
      return cheats.select{|k,v| k >= 100}.values.reduce(:+)
    end
    def get_distance(pos1, pos2)
      return (pos1[0] - pos2[0]).abs + (pos1[1] - pos2[1]).abs
    end
  end
end
