module D18P2
  class D18P2
    def run(input)
      @max_x, @max_y = 70, 70
      last_success, last_fail = 0, input.length-1
      current = (input.length-1)/2
      while last_fail > last_success+1
        map = gen_map(input, current+1)
        if test_map(map)
          next_last_success = current
          current += (last_fail-current)/2
          last_success = next_last_success
        else
          next_last_fail = current
          current -= (current-last_success)/2
          last_fail = next_last_fail
        end
      end
      puts "First Fail: #{input[last_fail]}"
    end
    def gen_map(input, bytes)
      map = {}
      bytes.times do |i|
        x, y = input[i].split(',').map{|s| s.to_i}
        map[Vector[x, y]] = true
      end
      return map
    end
    def test_map(map)
      queue = [{pos: Vector[0, 0], steps: 0}]
      while queue.length > 0
        current = queue.shift
        if current[:pos] == Vector[@max_x, @max_y]
          return true
        end
        [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dir|
          next_pos = current[:pos] + Vector[*dir]
          if next_pos[0] >= 0 and next_pos[0] <= @max_x and next_pos[1] >= 0 and next_pos[1] <= @max_y and not map[next_pos]
            map[next_pos] = true
            queue.push({pos: next_pos, steps: current[:steps]+1})
          end
        end
      end
      return false
    end
  end
end
