module D8P1
  class D8P1
    def run(input)
      input = input.map{|line| line.split(" | ").last.split(" ")}
      count = 0
      input.each do |line|
        count += line.count {|value| [2, 3, 4, 7].include?(value.length)}
      end
      puts "Simple Digits: #{count}"
    end
  end
end

module D8P2
  class D8P2
    def run(input)
      sum = 0
      input.each do |line|
        digits = line.split(" | ").last.split(" ").map{|value| value.split("").sort.join}
        values = line.split(" | ").first.split(" ").map{|x| x.split("").sort}
        values = values.sort{|a,b| a.count <=> b.count}

        mapping_idxs = Array.new(values.count)
        mapping_idxs[1] = 0
        mapping_idxs[4] = 2
        mapping_idxs[7] = 1
        mapping_idxs[8] = 9
        top = (values[1]-values[0]).first
        mid = nil
        bottom = nil
        values.each_with_index do |value,idx|
          diff = value-(values[2]+[top])
          join = (value+(values[2]+[top])).uniq
          if diff.count == 1 and join.count == value.count
            bottom = diff.first
            mapping_idxs[9] = idx
            break
          end
        end
        values.each_with_index do |value, idx|
          diff = value-(values[1]+[bottom])
          join =(value+(values[1]+[bottom])).uniq
          if diff.count == 1 and join.count == value.count
            mid = diff.first
            mapping_idxs[3] = idx
            break
          end
        end
        values.each_with_index do |value,idx|
          if (value-values[1]).count == 3 and value.count == 6 and not mapping_idxs.include?(idx)
            mapping_idxs[0] = idx
            break
          end
        end
        values.each_with_index do |value,idx|
          if value.count == 6 and not mapping_idxs.include?(idx)
            mapping_idxs[6] = idx
            break
          end
        end
        test_value = values[mapping_idxs[4]]+[top,bottom]
        values.each_with_index do |value,idx|
          if (value-test_value).count == 1 and not mapping_idxs.include?(idx)
            mapping_idxs[2] = idx
          elsif (value-test_value).count == 0 and not mapping_idxs.include?(idx)
            mapping_idxs[5] = idx
          end
        end
        mapping = {}
        (0..9).each do |idx|
          if mapping_idxs[idx]
            mapping[values[mapping_idxs[idx]].join] = idx
          end
        end
        number = ""
        digits.each{|digit| number += "#{mapping[digit]}"}
        sum += number.to_i
      end
      puts "Sum: #{sum}"
    end
  end
end
