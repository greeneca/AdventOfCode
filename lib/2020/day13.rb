module D13P1
  class D13P1
    def run(input)
      start_time = input[0].to_i
      busses = input[1].split(",")
      earliest = start_time*2
      earliest_buss = nil
      busses.each do |buss|
        if buss != "x"
          buss = buss.to_i
          wait_time = (buss-(start_time%buss))
          depart = start_time + wait_time
          if depart < earliest
            earliest = depart
            earliest_buss = buss * wait_time
          end
        end
      end
      puts "Answer: #{earliest_buss}"
    end
  end
end

module D13P2
  class D13P2
    def run(input)
      buses = input[1].chomp.split(",")
      time = 0
      step = nil
      buses.each_with_index do |bus, idx|
        if bus != "x"
          unless step
            step = bus.to_i
            next
          end
          while true
            if ((time + idx)%bus.to_i == 0)
              step *= bus.to_i
              break
            end

            time += step
          end
        end
      end
      puts "Time: #{time}"
    end
  end
end
