module D2P1
  class D2P1
    def run(input)
      count = 0
      input.each do |line|
        charCount, char, password = line.split()
        min, max = charCount.split("-").map{|x| x.to_i}
        char.gsub!(":", "")
        charCount = password.count(char)
        if charCount >= min and charCount <= max
          count += 1
        end
      end
      puts "Valid Passwords: #{count}"
    end
  end
end

module D2P2
  class D2P2
    def run(input)
      count = 0
      input.each do |line|
        charPos, char, password = line.split()
        a, b = charPos.split("-").map{|x| x.to_i}
        char.gsub!(":", "")
        if (password[a-1] == char) ^ (password[b-1] == char)
          count += 1
        end
      end
      puts "Valid Passwords: #{count}"
    end
  end
end
