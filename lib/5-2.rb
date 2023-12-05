module D5P2
  class D5P2
    def run(input)
      @seeds = []
      seed_ranges = input.shift.split(":").last.split(" ").map{|n| n.to_i}
      while seed_ranges.count > 1
        start = seed_ranges.shift
        @seeds.push(start..(start+seed_ranges.shift))
      end      
      new_seeds = []
      while input.length > 0
        map = input.shift.split(" ")
        if map[0].to_i.to_s == map[0]
          map = map.map{|n| n.to_i}
          diff = map[0]-map[1]
          source = (map[1]..(map[1]+map[2]))
          remaining_seeds = []
          @seeds.each do |range|
            intersect = range & source
            if intersect
              new_seeds.push(intersect + diff)
              remainder = range - source
              remaining_seeds.push(remainder) if remainder
            else
              remaining_seeds.push range
            end
          end
          @seeds = remaining_seeds
        elsif map[1] == "map:"
          @seeds += new_seeds
          new_seeds = [] 
        end
      end
      @seeds += new_seeds
      min = @seeds.sort_by(&:begin).first.begin
      puts "Min: #{min}"
    end
  end
end
class Range
  def intersection(other)
    return nil if (self.max < other.begin or other.max < self.begin) 
    [self.begin, other.begin].max..[self.max, other.max].min
  end
  alias_method :&, :intersection
  def addition(value)
    (self.begin+value)..(self.max+value)
  end
  alias_method :+, :addition
  def subtract(other)
    return self if (self.max < other.begin or other.max < self.begin) 
    return nil if (self.begin >= other.begin and self.max <= other.max)
    if other.begin <= self.begin
      return other.max..self.max
    else
      return self.begin..other.begin
    end
  end
  alias_method :-, :subtract
end
