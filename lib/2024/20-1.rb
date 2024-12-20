module D20P1
  class D20P1
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
      path.keys.each do |pos|
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
          wall = pos + Vector[*dir]
          next_pos = pos + (Vector[*dir]*2)
          if @map[next_pos] and @map[wall].nil?
            if path[next_pos] and path[next_pos] > path[pos]
              save = path[next_pos] - path[pos] - 2
              cheats[save] ||= 0
              cheats[save] += 1
            end
          end
        end
      end
      return cheats.select{|k,v| k >= 100}.values.reduce(:+)
    end
  end
end
