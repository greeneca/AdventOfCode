module D3P1
  class D3P1
    def run(input)
      input.map! do |line|
        match_data = /#(\d+)\s@\s(\d+),(\d+):\s(\d+)x(\d+)/.match(line)
          {
            id: match_data[1],
            x: match_data[2].to_i,
            y: match_data[3].to_i,
            w: match_data[4].to_i,
            h: match_data[5].to_i,
          }
      end
      cloth = Array.new(1000) {Array.new(1000, 0)}
      input.each do |line|
        (line[:x]..line[:x]+line[:w]-1).each do |x|
          (line[:y]..line[:y]+line[:h]-1).each do |y|
            cloth[x][y] += 1
          end
        end
      end
      conflicts = 0
      cloth.each do |col|
        col.each do |cell|
          conflicts += 1 if cell > 1
        end
      end
      puts "Conflicts: #{conflicts}"
    end
  end
end
