module D6P2
  class D6P2
    def run(input)
      days = 256
      new_idx = 8
      reset_idx = 6
      list = Array.new(new_idx+1, 0)
      input = input.first.split(",").map{|x| x.to_i}
      input.each {|i| list[i]+=1}
      days.times do
        next_list = Array.new(new_idx+1, 0)
        next_list[reset_idx] = list[0]
        next_list[new_idx] = list[0]
        (0..list.count-2).each do |idx|
          next_list[idx] += list[idx+1]
        end
        list = next_list
      end
      puts "Fish Count: #{list.sum}"
    end
  end
end
