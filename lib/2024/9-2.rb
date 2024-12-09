module D9P2
  class D9P2
    def run(input)
      filemap = input[0].split('').map{|v| v.to_i}
      files = []
      free = []
      while filemap.length > 0
        files << {size: filemap.shift, id: files.length, free: false}
        free << {size: filemap.shift, id: free.length, files: []} if filemap.length > 0
      end
      right_idx = files.length - 1
      while right_idx > 0
        (0...right_idx).each do |idx|
          if free[idx][:size] >= files[right_idx][:size]
            free[idx][:files] << files[right_idx]
            free[idx][:size] -= files[right_idx][:size]
            files[right_idx][:free] = true
            break
          end
        end
        right_idx -= 1
      end
      sum = 0
      mem_idx = 0
      files.each_with_index do |file, idx|
        if file[:free]
          mem_idx += file[:size]
        else
          sum, mem_idx = sum_block(sum, mem_idx, file[:size], file[:id])
        end
        if free[idx]
          free[idx][:files].each do |file|
            sum, mem_idx = sum_block(sum, mem_idx, file[:size], file[:id])
          end
          mem_idx += free[idx][:size]
        end
      end
      puts "Sum: #{sum}"
    end
    def sum_block(sum, mem_idx, space, id)
      (mem_idx...(mem_idx+space)).each do |idx|
        sum += idx*id
      end
      return sum, mem_idx + space
    end
  end
end
