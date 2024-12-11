module D10P2
  class D10P2
    def run(input)
      @map = {}
      @cache = {}
      trailheads = []
      input.each_with_index do |line, y|
        line.split('').each_with_index do |height, x|
          @map[Vector[x, y]] = height.to_i
          trailheads << Vector[x, y] if height.to_i == 0
        end
      end
      sum = 0
      trailheads.each do |trailhead|
        sum += get_paths(trailhead)
      end
      puts "Sum: #{sum}"
    end
    def get_paths(position)
      paths = 0
      return @cache[position] if @cache[position]
      return 1 if @map[position] == 9
      [Vector[0, 1], Vector[1, 0], Vector[0, -1], Vector[-1, 0]].each do |dir|
        next_pos = position + dir
        if @map[next_pos] == (@map[position] + 1)
          paths += get_paths(next_pos)
        end
      end
      @cache[position] = paths
      return paths
    end
  end
end
