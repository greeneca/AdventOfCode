module D5P1
  class D5P1
    def run(input)
      @seeds = input.shift.split(":").last.split(" ").map{|n| n.to_i}
      new_seeds = []
      while input.length > 0
        map = input.shift.split(" ")
        if map[0].to_i.to_s == map[0]
          map = map.map{|n| n.to_i}
          diff = map[0]-map[1]
          source = (map[1]..(map[1]+map[2]))
          @seeds.each_with_index do |seed, idx|
            if source.include?(seed)
              new_seeds[idx] = seed + diff
            end
          end
        elsif map[1] == "map:"
          finish_map(new_seeds)
          new_seeds = Array.new(@seeds.length)
        end
      end
      finish_map(new_seeds)
      puts "Min: #{@seeds.min}"
    end

    def finish_map(new_seeds)
      @seeds.each_with_index do |seed, idx|
        unless new_seeds[idx]
          new_seeds[idx] = seed
        end
      end
      @seeds = new_seeds
      #puts @seeds.to_s
    end
  end
end
