module D1P2
  class D1P2
    def run(input)
      freq = 0
      dic = {}
      while true
        input.each do |adj|
          freq += adj.to_i
          if dic[freq]
            puts "Frequency: #{freq}"
            exit
          end
          dic[freq] = true
        end
      end
    end
  end
end
