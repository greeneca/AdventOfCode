module D2P1
  class D2P1
    def run(input)
      position = [0,0]
      input.each do |command|
        dir, value = command.split(" ")
        value = value.to_i
        case dir
        when "forward"
          position[0] += value
        when "down"
          position[1] += value
        when "up"
          position[1] -= value
        end
      end
      puts "Final Position #{position.inject(:*)}"
    end
  end
end

module D2P2
  class D2P2
    def run(input)
      position = [0,0]
      aim = 0
      input.each do |command|
        dir, value = command.split(" ")
        value = value.to_i
        case dir
        when "forward"
          position[0] += value
          position[1] += value * aim
        when "down"
          aim += value
        when "up"
          aim -= value
        end
      end
      puts "Final Position #{position.inject(:*)}"
    end
  end
end
