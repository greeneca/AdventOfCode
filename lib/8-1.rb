module D8P1
  class D8P1
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
      steps = 0
      current_node = :AAA
      while current_node != :ZZZ
        current_node = nodes[current_node][commands[idx].to_sym]
        idx += 1
        idx = idx%commands.length
        steps +=1
      end
      puts "Steps: #{steps}"
    end
  end
end
