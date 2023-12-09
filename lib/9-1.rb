module D9P1
  class D9P1
    def run(input)
      sum = 0
      input.each do |line|
        seq = line.split(" ").map{|n| n.to_i}
        sum += get_next_value(seq)
      end
      puts "Sum #{sum}"
    end
    def get_next_value(seq)
      if seq.uniq.count == 1
        return seq.last
      else
        prev = seq.shift
        diff = seq.map do |n|
          new = n - prev
          prev = n
          new
        end
        return seq.last + get_next_value(diff)
      end
    end
  end
end
