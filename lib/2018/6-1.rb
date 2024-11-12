module D6P1
  class D6P1
    def run(input)
      coordinates = input.map {|coor| coor.strip.split(", ").map {|idx| idx.to_i}}
      @min = coordinates[0].dup
      @max = coordinates[0].dup
      coordinates.each do |coordinate_set|
        coordinate_set.each_with_index do |coordinate, idx|
          @min[idx] = [@min[idx], coordinate].min
          @max[idx] = [@max[idx], coordinate].max
        end
      end
      @map = Array.new(@max[0]-@min[0]+1) {Array.new(@max[1]-@min[1]+1, 0)}
      label = 1
      coordinates.each do |coordinate_set|
        local = to_local(coordinate_set)
        @map[local[0]][local[1]] = label
        label += 1
      end
      @map.each_index do |x|
        @map[x].each_index do |y|
          if 0 == @map[x][y]
            min_distance = {set: nil, distance: @max[0]+@max[1], duplicate: false}
            coordinates.each do |coordinate_set|
              local = to_local(coordinate_set)
              distance = (x-local[0]).abs + (y-local[1]).abs
              if distance < min_distance[:distance]
                min_distance[:set] = coordinate_set
                min_distance[:distance] = distance
                min_distance[:duplicate] = false
              elsif distance == min_distance[:distance]
                min_distance[:duplicate] = true
              end
            end
            unless min_distance[:duplicate]
              local = to_local(min_distance[:set])
              @map[x][y] = @map[local[0]][local[1]]
            end
          end
        end
      end
      infinates = @map.first.dup.uniq
      infinates += @map.last.dup.uniq
      @map.each do |col|
        infinates.push col.first
        infinates.push col.last
      end
      infinates.push 0
      infinates.uniq!
      counts = {}
      @map.each do |col|
        col.each do |label|
          unless infinates.include? label
            counts[label] ||= 0
            counts[label] += 1
          end
        end
      end
      counts = counts.to_a.map {|count| count[1]}
      puts "Count: #{counts.max}"
    end
    def to_local(coordinates)
      [coordinates[0]-@min[0], coordinates[1]-@min[1]]
    end
  end
end
