require 'lazy_priority_queue'

module D15P1
  class D15P1
    def run(input)
      nodes = {}
      nodes = {}
      distance = {}
      remaining = MinPriorityQueue.new
      start_node = Matrix[[0],[0]]
      end_node = Matrix[[input[0].strip.length-1],[input.count-1]]
      input.each_with_index do |line,y|
        line.strip.split("").each_with_index do |val,x|
          key = Matrix[[x],[y]]
          nodes[key] = val.to_i
          dist = Integer::MAX
          dist = 0 if key == start_node
          distance[key] = dist
          remaining.push(key, dist)
        end
      end
      while !remaining.empty?
        cur = remaining.pop
        [Matrix[[1],[0]], Matrix[[0],[1]], Matrix[[-1],[0]], Matrix[[0],[-1]]].each do |inc|
          pos = cur+inc
          if nodes[pos]
            new_cost = distance[cur]+nodes[pos]
            old_cost = distance[pos]
            if new_cost < old_cost
              distance[pos] = new_cost
              remaining.decrease_key(pos, new_cost)
            end
          end
        end
      end
      puts "Shortest Path: #{distance[end_node]}"
    end
  end
end

module D15P2
  class D15P2
    def run(input)
      input = expand_input(input)
      nodes = {}
      distance = {}
      remaining = MinPriorityQueue.new
      start_node = Matrix[[0],[0]]
      end_node = Matrix[[input[0].strip.length-1],[input.count-1]]
      input.each_with_index do |line,y|
        line.strip.split("").each_with_index do |val,x|
          key = Matrix[[x],[y]]
          nodes[key] = val.to_i
          dist = Integer::MAX
          dist = 0 if key == start_node
          distance[key] = dist
          remaining.push(key, dist)
        end
      end
      while !remaining.empty?
        cur = remaining.pop
        [Matrix[[1],[0]], Matrix[[0],[1]], Matrix[[-1],[0]], Matrix[[0],[-1]]].each do |inc|
          pos = cur+inc
          if nodes[pos]
            new_cost = distance[cur]+nodes[pos]
            old_cost = distance[pos]
            if new_cost < old_cost
              distance[pos] = new_cost
              remaining.decrease_key(pos, new_cost)
            end
          end
        end
      end
      puts "Shortest Path: #{distance[end_node]}"
    end
    def expand_input(input)
      new_input = []
      (0..4).each do |y_inc|
        input.each do |line|
          new_line = []
          (0..4).each do |x_inc|
            line.strip.split("").each do |val|
              new_val = val.to_i+x_inc+y_inc
              new_val -= 9 if new_val > 9
              new_line.push(new_val)
            end
          end
          new_input.push(new_line.join(""))
        end
      end
      new_input
    end
  end
end
