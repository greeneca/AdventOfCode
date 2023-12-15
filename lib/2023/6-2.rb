module D6P2
  class D6P2
    def run(input)
      time = input.shift.split(":").last.gsub(" ", "").to_i
      distance = input.shift.split(":").last.gsub(" ", "").to_i
      low = 0
      min = 1
      max = time/2
      done = false
      while not done
        low = (max-min)/2 +min
        if low*(time-low) > distance
          max = low
        else
          min = low
        end
        done = (max-min <= 1)
      end
      low = max
      hi = time/2 + (time/2 - low)
      puts "Count #{hi-low+1}"
    end
  end
end
