module D3P2
  class D3P2
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
      potential_candidates = []
      input.each_with_index do |line, idx|
        candidate = true
        traverse_claim(line) do |x, y|
          cloth[x][y] += 1
          candidate = false if cloth[x][x] > 1
        end
        potential_candidates.push idx if candidate
      end
      potential_candidates.each do |idx|
        line = input[idx]
        candidate = true
        traverse_claim(line) do |x, y|
          if cloth[x][y] > 1
            candidate = false
            break
          end
        end
        puts "ID: "+line[:id] if candidate
      end
    end
    def traverse_claim(line)
      (line[:x]..line[:x]+line[:w]-1).each do |x|
        (line[:y]..line[:y]+line[:h]-1).each do |y|
          yield x, y
        end
      end
    end
  end
end
