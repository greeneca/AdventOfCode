module D12P2
  class D12P2
    def run(input)
      @map = {}
      @dirs = [Vector[0, -1], Vector[1, 0], Vector[0, 1], Vector[-1, 0]]
      input.each_with_index do |line, y|
        line.split('').each_with_index do |char, x|
          @map[Vector[x, y]] = char
        end
      end
      @to_check = @map.clone
      regions = []
      while @to_check.length > 0
        vector = @to_check.keys.first
        region = check_area(vector, {area: 1, sides: 0, char: @map[vector], edges: []})
        region = check_sides(vector, region)
        regions << region
      end
      sum = 0
      regions.each do |region|
        region.delete(:edges)
        sum += region[:area] * region[:sides]
      end
      puts "Sum: #{sum}"
    end
    def check_area(vector, region)
      @to_check.delete(vector)
      char = @map[vector]
      dirs = [Vector[0, 1], Vector[1, 0], Vector[0, -1], Vector[-1, 0]]
      dirs.each do |dir|
        next_pos = vector + dir
        if @map[next_pos] == char
          if @to_check[next_pos]
            region[:area] += 1
            region = check_area(next_pos, region)
          end
        else
          region[:edges] << [vector, dir]
        end
      end
      return region
    end
    def check_sides(vector, region)
      edges = region[:edges]
      sides = edges.group_by { |edge| edge[1] }
      sides.values.each do |side|
        dir = side[0][1]
        side.map! { |edge| edge[0] }
        side.sort! do |a, b|
          if dir[0] == 0
            if a[1] == b[1]
              a[0] <=> b[0]
            else
              a[1] <=> b[1]
            end
          else
            if a[0] == b[0]
              a[1] <=> b[1]
            else
              a[0] <=> b[0]
            end
          end
        end
        region[:sides] += 1
        prev = side[0]
        (1..side.length-1).each do |i|
          if not @dirs.include?(side[i] - prev)
            region[:sides] += 1
          end
          prev = side[i]
        end
      end
      return region
    end
  end
end

