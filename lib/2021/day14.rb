module D14P1
  class D14P1
    def run(inputs)
      poly = inputs.shift.strip
      inputs.shift
      mapping = {}
      inputs.each do |line|
        key, value = line.strip.split(" -> ")
        mapping[key] = value
      end
      10.times do
        new_poly = ""
        (0..(poly.length-2)).each do |idx|
          key = poly[idx..(idx+1)]
          new_poly += key[0]
          if mapping[key]
            new_poly += mapping[key]
          end
        end
        new_poly += poly[-1]
        poly = new_poly
      end
      chars = poly.split("").uniq
      counts = chars.map do |char|
        poly.count(char)
      end
      counts.sort!
      puts "Poly Score: #{counts[-1]-counts[0]}"
    end
  end
end

module D14P2
  class D14P2
    def run(inputs)
      poly = inputs.shift.strip
      inputs.shift
      mapping = {}
      inputs.each do |line|
        key, value = line.strip.split(" -> ")
        mapping[key] = value
      end
      counts = {}
      (0..(poly.length-2)).each do |idx|
        key = poly[idx..(idx+1)]
        counts[key] ||= 0
        counts[key] += 1
      end
      40.times do
        counts.dup.each_pair do |key,value|
          if mapping[key]
            a,b = key.split("")
            a += mapping[key]
            b = mapping[key]+b
            [a,b].each do |new_key|
              counts[new_key] ||= 0
              counts[new_key] += value
            end
            counts[key] -= value
          end
        end
      end
      final_counts = {}
      counts.each_pair do |key,value|
        a,b = key.split("")
        final_counts[a] ||= 0
        final_counts[a] += value
      end
      final_counts[poly[-1]] +=1
      sorted = final_counts.values.sort
      puts "Poly Score: #{sorted[-1]-sorted[0]}"
    end
  end
end
