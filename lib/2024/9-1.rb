module D9P1
  class D9P1
    def run(input)
      filemap = input[0].split('').map{|v| v.to_i}
      files = []
      free = []
      while filemap.length > 0
        files << filemap.shift
        free << filemap.shift if filemap.length > 0
      end
      sum = 0
      left_idx = 0
      free_idx = 0
      right_idx = files.length - 1
      right_rem = files[right_idx]
      mem_idx = 0
      while true
        if left_idx == right_idx
          space = right_rem
          (mem_idx...(mem_idx+space)).each do |idx|
            sum += idx*left_idx
          end
          break
        else
          space = files[left_idx]
          (mem_idx...(mem_idx+space)).each do |idx|
            sum += idx*left_idx
          end
          mem_idx += space
          left_idx += 1
        end

        space = free[free_idx]
        (mem_idx...(mem_idx+space)).each do |idx|
          sum += idx*right_idx
          right_rem -= 1
          if right_rem == 0
            right_idx -= 1
            right_rem = files[right_idx]
          end
        end
        mem_idx += space
        free_idx += 1
      end
      puts "Sum: #{sum}"
    end
  end
end
