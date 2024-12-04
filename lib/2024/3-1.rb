module D3P1
  class D3P1
    def run(input)
      sum = 0
      input.each do |line|
        match = line.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
        match.each do |pair|
          sum += pair[0].to_i*pair[1].to_i
        end
      end
      puts "Sum: #{sum}"
    end
  end
end
