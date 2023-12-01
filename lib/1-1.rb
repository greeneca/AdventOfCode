module D1P1
  class D1P1
    def run(input)
      sum = 0
      input.each do |line|
        line = line.split("").select{|char| char.to_i.to_s == char}
        sum += (line[0]+line[-1]).to_i
      end
      puts "Sum: #{sum}"
    end
  end
end
