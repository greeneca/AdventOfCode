module D14P1
  class D14P1
    def run(input)
      robots = []
      x_max = 101
      y_max = 103
      iterations = 100
      input.each do |line|
        match = /p=(\d+),(\d+) v=(-?\d+),(-?\d+)/.match(line)
        robots.push({
          :position => [match[1].to_i, match[2].to_i],
          :velocity => [match[3].to_i, match[4].to_i]
        })
      end
      saftey_factor = 0
      map = {}
      robots.each do |robot|
        robot[:position][0] += robot[:velocity][0]*iterations
        robot[:position][1] += robot[:velocity][1]*iterations
        robot[:position][0] = robot[:position][0] % x_max
        robot[:position][1] = robot[:position][1] % y_max
        map[Vector.elements(robot[:position])] ||= 0
        map[Vector.elements(robot[:position])] += 1
      end
      saftey_factor = get_saftey_factor(map, x_max, y_max)
      puts "Saftey Factor: #{saftey_factor}"
    end
    def get_saftey_factor(map, x_max, y_max)
      quardents = [0, 0, 0, 0]
      map.each do |key, value|
        if key[0] > x_max/2
          if key[1] > y_max/2
            quardents[0] += value
          elsif key[1] < y_max/2
            quardents[1] += value
          end
        elsif key[0] < x_max/2
          if key[1] > y_max/2
            quardents[2] += value
          elsif key[1] < y_max/2
            quardents[3] += value
          end
        end
      end
      return quardents.reduce(1, :*)
    end
    def print_map(map, x_max, y_max)
      (0..y_max-1).each do |y|
        (0..x_max-1).each do |x|
          if map[Vector[x, y]]
            print "#{map[Vector[x, y]]}"
          else
            print "."
          end
        end
        puts ""
      end
    end
  end
end
