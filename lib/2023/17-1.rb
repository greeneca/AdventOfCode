module D17P1
  class D17P1
    MAX = (2**(0.size * 8 -2) -1)
    def run(input)
      grid = {}
      max_x = input[0].length-1
      max_y = input.count-1
      input.each_with_index do |row, y|
        row.split("").each_with_index do |block, x|
          grid[Vector[x,y]] = block.to_i
        end
      end
      current = Vector[0,0]
      end_point = Vector[max_x,max_y]
      cache = {}
      queue = [{pos: current, dir: Vector[0,0], count: 0, loss: 0, path: [current]}]
      while queue.count > 0
        puts queue.count
        path = queue.shift
        key = "#{path[:pos]}#{path[:dir]}#{path[:count]}"
        next if cache[key]
        cache[key] = path
        next if path[:pos] == end_point
        directions = [Vector[0, 1], Vector[0, -1], Vector[1, 0], Vector[-1, 0]]
        directions.each do |dir|
          next_pos = path[:pos]+dir
          if grid[next_pos] and (path[:dir]+dir != Vector[0,0])
            next_dir_count = path[:dir] == dir ? path[:count]+1 : 1
            if next_dir_count < 4
              next_loss = path[:loss]+grid[next_pos]
              next_path = path[:path]+[next_pos]
              queue.push({pos: next_pos, dir: dir, count: next_dir_count, loss: next_loss, path: next_path})
            end
          end
        end
        #queue.sort!{|a,b| a[:loss] <=> b[:loss]}
      end
      loss = MAX
      cache.each_value do |result|
        if result[:pos] == end_point
          loss = [loss, result[:loss]].min
        end
      end
      puts "Loss: #{loss}"
    end
  end
end
