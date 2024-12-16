module D14P2
  class D14P2
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
      (1..10000).each do |i|
        map = {}
        robots.each do |robot|
          robot[:position][0] += robot[:velocity][0]
          robot[:position][1] += robot[:velocity][1]
          robot[:position][0] = robot[:position][0] % x_max
          robot[:position][1] = robot[:position][1] % y_max
          map[Vector.elements(robot[:position])] ||= 0
          map[Vector.elements(robot[:position])] += 1
        end
        if map.select{|k, v| v > 1}.length == 0
          print_map(map, x_max, y_max)
          puts "Seconds: #{i}"
          break
        end
      end
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
