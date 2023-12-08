module D8P2
  class D8P2
    def run(input)
      commands = input.shift
      input.shift
      nodes = {}
      while input.count > 0
        node = input.shift
        target, dest = node.split(" = ")
        dest = dest.gsub(/[\(\)]/, "").split(",").map{|d| d.strip.to_sym}
        nodes[target.to_sym] = {L: dest[0], R: dest[1]}
      end
      idx = 0
      steps = 1
      current_nodes = nodes.keys.select{|n| n.to_s.end_with?("A")}
      loops = Array.new(current_nodes.count, nil)
      done = false
      while not done
        new_current = []
        current_nodes.each do |n|
          new_current.push(nodes[n][commands[idx].to_sym])
        end
        current_nodes = new_current
        current_nodes.each_with_index do |n, idx|
          loops[idx] = steps if n.to_s.end_with?("Z")
        end
        idx += 1
        idx = idx%commands.length
        steps +=1
        done = loops.count == loops.compact.count
      end
      steps = loops.reduce(1) {|res, s| res.lcm(s)}
      puts "Steps: #{steps}"
    end
  end
end
