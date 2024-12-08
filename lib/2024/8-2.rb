module D8P2
  class D8P2
    def run(input)
      map = {}
      antinodes = []
      max_x, max_y = 0, 0
      input.each_with_index do |line, y|
        max_y = y if y > max_y
        line.split('').each_with_index do |char, x|
          max_x = x if x > max_x
          if char != '.'
            map[char] ||= []
            map[char] << Vector[x, y]
            antinodes << Vector[x, y]
          end
        end
      end
      max = Vector[max_x, max_y]
      map.each do |key, nodes|
        nodes.combination(2).each do |node1, node2|
          antinode = node1+ (node1-node2)
          while inGrid(antinode, max)
            antinodes << antinode
            antinode += (node1-node2)
          end
          antinode = node2+ (node2-node1)
          while inGrid(antinode, max)
            antinodes << antinode
            antinode += (node2-node1)
          end
        end
      end
      puts "Antinodes: #{antinodes.uniq.length}"
    end
    def inGrid(vector, max)
      return (vector[0] <= max[0] and vector[0] >= 0 and vector[1] <= max[1] and vector[1] >= 0)
    end
  end
end
