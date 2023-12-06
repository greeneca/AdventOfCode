module D6P1
  class D6P1
    def run(input)
      times = input.shift.split(":").last.split(" ").map{|n| n.to_i}
      distances = input.shift.split(":").last.split(" ").map{|n| n.to_i}
      product = 1
      times.each_with_index do |time, idx|
        distance = distances[idx]
        count = 0
        (1..(time-1)).each do |hold|
          count += 1 if hold*(time-hold) > distance
        end
        product *= count
      end
      puts "Product #{product}"
    end
  end
end
