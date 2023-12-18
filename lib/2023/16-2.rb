module D16P2
  class D16P2
    def run(input)
      @grid = {}
      @max_y = input.count-1
      @max_x = input[0].length-1
      input.each_with_index do |row, y|
        row.split("").each_with_index do |point, x|
          if point != "."
            @grid[Vector[x,y]] = point
          end
        end
      end
      max = 0
      (0..@max_x).each do |x|
        max = [max, get_energized_count({pos: Vector[x, 0], dir: Vector[0, 1]})].max
        max = [max, get_energized_count({pos: Vector[x, @max_y], dir: Vector[0, -1]})].max
      end
      (0..@max_y).each do |y|
        max = [max, get_energized_count({pos: Vector[0, y], dir: Vector[1, 0]})].max
        max = [max, get_energized_count({pos: Vector[@max_x, y], dir: Vector[-1, 0]})].max
      end
      puts "Max: #{max}"
    end
    def get_energized_count(start)
      beams = get_beams(start)
      energized = {}
      cache = {}
      while beams.count > 0
        new_beams = []
        #puts beams.to_s
        beams.each do |beam|
          key = "#{beam[:pos].to_s}#{beam[:dir].to_s}"
          next if cache[key]
          cache[key] = true
          energized[beam[:pos]] = true
          new_pos = beam[:pos]+beam[:dir]
          next unless 0 <= new_pos[0] and 0 <= new_pos[1] and @max_x >= new_pos[0] and @max_y >= new_pos[1]
          new_beams += get_beams({pos: new_pos, dir: beam[:dir]})
        end
        beams = new_beams
      end
      energized.count
    end
    def get_beams(beam)
      new_beams = []
      case @grid[beam[:pos]]
      when "|"
        if beam[:dir][0] != 0
          new_beams.push({pos: beam[:pos], dir: Vector[0, -1]})
          new_beams.push({pos: beam[:pos], dir: Vector[0, 1]})
        else
          new_beams.push({pos: beam[:pos], dir: beam[:dir]})
        end
      when "-"
        if beam[:dir][1] != 0
          new_beams.push({pos: beam[:pos], dir: Vector[-1, 0]})
          new_beams.push({pos: beam[:pos], dir: Vector[1, 0]})
        else
          new_beams.push({pos: beam[:pos], dir: beam[:dir]})
        end
      when "\\"
        d = beam[:dir]
        new_dir = Vector[(d[1]),(d[0])]
        new_beams.push({pos: beam[:pos], dir: new_dir})
      when "/"
        d = beam[:dir]
        new_dir = Vector[(d[1]*-1),(d[0]*-1)]
        new_beams.push({pos: beam[:pos], dir: new_dir})
      else
        new_beams.push({pos: beam[:pos], dir: beam[:dir]})
      end
      return new_beams
    end
  end
end
