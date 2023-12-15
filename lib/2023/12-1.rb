module D12P1
  class D12P1
    def run(input)
      sum = 0
      input.each do |line|
        springs, counts = line.split(" ")
        springs = springs.split("")
        counts = counts.split(",").map{|n|n.to_i}
        sum += get_count(springs, counts, 0, 0, 0)
      end
      puts "Sum: #{sum}"
    end
    #cs - current spring, cc - current count, cg - position in current group
    def get_count(springs, counts, cs, cc, cg)
      if cs == springs.length
        if cc == counts.length and cg == 0
          return 1
        elsif cc == counts.length-1 and counts[cc] == cg
          return 1
        else
          return 0
        end
      end
      sum = 0
      [".", "#"].each do |type|
        if [type, "?"].include?(springs[cs])
          if type == "." and cg == 0
            sum += get_count(springs, counts, cs+1, cc, cg)
          elsif type == "." and cc < counts.length and counts[cc] == cg
            sum += get_count(springs, counts, cs+1, cc+1, 0)
          elsif type == "#"
            sum += get_count(springs, counts, cs+1, cc, cg+1)
          end
        end
      end
      return sum
    end
  end
end
