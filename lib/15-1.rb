module D15P1
  class D15P1
    def run(input)
      seq = input.first.split(",")
      sum = 0
      seq.each do |step|
        hash = 0
        step.each_byte do |byte|
          hash += byte
          hash *= 17
          hash = hash % 256
        end
        #puts "step: #{hash}"
        sum += hash
      end
      puts "Sum: #{sum}"
    end
  end
end
