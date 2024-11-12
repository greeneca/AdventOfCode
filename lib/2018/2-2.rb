module D2P2
  class D2P2
    def run(input)
      input.combination(2) do |a, b|
        diff = 0
        (0..a.length-1).each do |idx|
          diff += 1 if a[idx] != b[idx]
        end
        if diff == 1
          common = ""
          a.chars.each_with_index do |c,i|
            common += c if b.chars[i] == c
          end
          puts "Common: #{common}"
        end
      end
    end
  end
end
