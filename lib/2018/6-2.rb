module D6P2
  class D6P2
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
      @map.each_index do |x|
        @map[x].each_index do |y|
          if 0 == @map[x][y]
            distance = 0
            coordinates.each do |coordinate_set|
              local = to_local(coordinate_set)
              distance += (x-local[0]).abs + (y-local[1]).abs
            end
            if distance < 10000
              @map[x][y] = 1
            end
          end
        end
      end
      size = 0
      @map.each do |col|
        col.each do |label|
          size += 1 if label > 0
        end
      end
      puts "Size: #{size}"
    end
    def to_local(coordinates)
      [coordinates[0]-@min[0], coordinates[1]-@min[1]]
    end
  end
end
