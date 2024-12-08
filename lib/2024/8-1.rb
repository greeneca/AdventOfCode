module D8P1
  class D8P1
    def run(input)
      map = {}
      max_x, max_y = 0, 0
      input.each_with_index do |line, y|
        max_y = y if y > max_y
        line.split('').each_with_index do |char, x|
          max_x = x if x > max_x
          if char != '.'
            map[char] ||= []
            map[char] << Vector[x, y]
          end
        end
      end
      antinodes = []
      map.each do |key, nodes|
        nodes.combination(2).each do |node1, node2|
          antinode = node1+ (node1-node2)
          if antinode[0] <= max_x and antinode[0] >= 0 and antinode[1] <= max_y and antinode[1] >= 0
            antinodes << antinode
          end
          antinode = node2+ (node2-node1)
          if antinode[0] <= max_x and antinode[0] >= 0 and antinode[1] <= max_y and antinode[1] >= 0
            antinodes << antinode
          end
        end
      end
      puts "Antinodes: #{antinodes.uniq.length}"
    end
  end
end
