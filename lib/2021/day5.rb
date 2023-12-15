module D5P1
  class D5P1
    def run(input)
      input = input.map{|x| x.split(" -> ").map{|y| y.split(",").map{|z| z.to_i}}}
      lines = []
      max = [Integer::MIN, Integer::MIN]
      min = [Integer::MAX, Integer::MAX]
      input.each do |line|
        if line[0][0] == line[1][0] or line[0][1] == line[1][1]
          lines.push line
          line.each do |point|
            point.each_index do |i|
              if point[i] > max[i]
                max[i] = point[i]
              elsif point[i] < min[i]
                min[i] = point[i]
              end
            end
          end
        end
      end
      size = [max[0]-min[0]+1, max[1]-min[1]+1]
      area = Array.new(size[1]){Array.new(size[0]){0}}
      lines.each do |line|
        inc_idx = 0
        inc_idx = 1 if line[0][0] == line[1][0]
        range = [line[0][inc_idx], line[1][inc_idx]].sort
        (range[0]..range[1]).each do |idx|
          point = line[0].dup
          point[inc_idx] = idx
          point[0] -= min[0]
          point[1] -= min[1]
          area[point[1]][point[0]] += 1
        end
      end
      count = 0
      area.each do |row|
        count += row.count {|x| x > 1}
      end
      puts "Crossing Points: #{count}"
    end
  end
end

module D5P2
  class D5P2
    def run(input)
      lines = input.map{|x| x.split(" -> ").map{|y| y.split(",").map{|z| z.to_i}}}
      max = [Integer::MIN, Integer::MIN]
      min = [Integer::MAX, Integer::MAX]
      lines.each do |line|
        line.each do |point|
          point.each_index do |i|
            if point[i] > max[i]
              max[i] = point[i]
            elsif point[i] < min[i]
              min[i] = point[i]
            end
          end
        end
      end
      size = [max[0]-min[0]+1, max[1]-min[1]+1]
      area = Array.new(size[1]){Array.new(size[0]){0}}
      lines.each do |line|
        range = PointRange.new(line)
        loop do
          begin
            point = range.next
            area[point[1]-min[1]][point[0]-min[0]] += 1
          rescue
            break
          end
        end
      end
      count = 0
      area.each do |row|
        count += row.count {|x| x > 1}
      end
      puts "Crossing Points: #{count}"
    end
  end
  class PointRange
    def initialize(points)
      @point = points[0].dup
      @end = points[1].dup
      x = [points[0][0], points[1][0]].sort
      @xrange = x[0]..x[1]
      y = [points[0][1], points[1][1]].sort
      @yrange = y[0]..y[1]
      begin
        @x_inc = (@end[0]-@point[0])/((@end[0]-@point[0]).abs)
      rescue ZeroDivisionError
        @x_inc = 0
      end
      begin
        @y_inc = (@end[1]-@point[1])/((@end[1]-@point[1]).abs)
      rescue ZeroDivisionError
        @y_inc = 0
      end
    end
    def next
      if @xrange.include?(@point[0]) and @yrange.include?(@point[1])
        point_copy = @point.dup
        @point[0] += @x_inc
        @point[1] += @y_inc
        return point_copy
      else
        trown StopIteration
      end
    end
  end
end

class Integer
  N_BYTES = [42].pack('i').size
  N_BITS = N_BYTES * 16
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1
end
