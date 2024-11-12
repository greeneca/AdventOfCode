module D1P1
  class D1P1
    def run(input)
      freq = 0
      input.each {|adj| freq += adj.to_i}
      puts "Frequency: #{freq}"
    end
  end
end
