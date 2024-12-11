module D11P1
  class D11P1
    def run(input)
      stones = input[0].split(' ').map{|s| s.to_i}
      count = 0
      cache = {}
      stones.each do |stone|
        line = [stone]
        if cache[stone]
          count += cache[stone]
          next
        end
        25.times do
          new_line = []
          line.each do |l|
            if l == 0
              new_line.push(1)
            elsif l.to_s.length % 2 == 0
              new_line.push(l.to_s[0..l.to_s.length/2-1].to_i)
              new_line.push(l.to_s[l.to_s.length/2..-1].to_i)
            else
              new_line.push(l*2024)
            end
          end
          line = new_line
        end
        cache[stone] = line.length
        count += line.length
      end
      puts "Count: #{count}"
    end
  end
end
