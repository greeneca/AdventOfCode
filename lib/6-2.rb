module D6P2
  class D6P2
    def run(input)
      time = input.shift.split(":").last.gsub(" ", "").to_i
      distance = input.shift.split(":").last.gsub(" ", "").to_i
      min = 0
      max = 0
      1.upto(time-1) do |hold|
        if hold*(time-hold) > distance
          min = hold
          break
        end
      end
      (time-1).downto(1) do |hold|
        if hold*(time-hold) > distance
          max = hold
          break
        end
      end
      puts "Count #{max-min+1}"
    end
  end
end
