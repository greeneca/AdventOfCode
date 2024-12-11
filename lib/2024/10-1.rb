module D10P1
  class D10P1
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
        peaks = get_peaks(trailhead)
        sum += peaks.length
      end
      puts "Sum: #{sum}"
    end
    def get_peaks(position)
      peaks = []
      return @cache[position] if @cache[position]
      return [position] if @map[position] == 9
      [Vector[0, 1], Vector[1, 0], Vector[0, -1], Vector[-1, 0]].each do |dir|
        next_pos = position + dir
        if @map[next_pos] == (@map[position] + 1)
          peaks += get_peaks(next_pos)
        end
      end
      peaks = peaks.uniq
      @cache[position] = peaks
      return peaks
    end
  end
end
