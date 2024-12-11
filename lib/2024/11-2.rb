module D11P2
  class D11P2
    def run(input)
      stones = input[0].split(' ').map{|s| s.to_i}
      count = 0
      @cache = {}
      stones.each do |stone|
        count += compute_count(stone, 75)
      end
      puts "Count: #{count}"
    end
    def compute_count(stone, level)
      if level <= 0
        return 1
      end
      if @cache["#{stone},#{level}"]
        return @cache["#{stone},#{level}"]
      end
      count = 0
      if stone == 0
        count = compute_count(1, level-1)
      elsif stone.to_s.length % 2 == 0
        count += compute_count(stone.to_s[0..stone.to_s.length/2-1].to_i, level-1)
        count += compute_count(stone.to_s[stone.to_s.length/2..-1].to_i, level-1)
      else
        count = compute_count(stone*2024, level-1)
      end
      @cache["#{stone},#{level}"] = count
      return count
    end
  end
end
