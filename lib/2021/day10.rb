module D10P1
  class D10P1
    def run(input)
      points = {
        ")" => 3,
        "]" => 57,
        "}" => 1197,
        ">" => 25137
      }
      map = {
        ")" => "(",
        "]" => "[",
        "}" => "{",
        ">" => "<"
      }
      score = 0
      input.each do |line|
        characters = line.strip.split("")
        stack = []
        loop do
          char = characters.shift
          break unless char
          stack.push(char) if map.values.include?(char)
          if map.keys.include?(char)
            match = stack.pop
            if match != map[char]
              score += points[char]
              break
            end
          end
        end
      end
      puts "Total Score: #{score}"
    end
  end
end

module D10P2
  class D10P2
    def run(input)
      points = {
        "(" => 1,
        "[" => 2,
        "{" => 3,
        "<" => 4
      }
      map = {
        ")" => "(",
        "]" => "[",
        "}" => "{",
        ">" => "<"
      }
      scores = []
      input.each do |line|
        characters = line.strip.split("")
        stack = []
        loop do
          char = characters.shift
          unless char
            score = 0
            loop do
              break if stack.count == 0
              score *= 5
              score += points[stack.pop]
            end
            scores.push score
            break
          end
          stack.push(char) if map.values.include?(char)
          if map.keys.include?(char)
            break if stack.pop != map[char]
          end
        end
      end
      score = scores.sort[scores.count/2]
      puts "Final Score: #{score}"
    end
  end
end
