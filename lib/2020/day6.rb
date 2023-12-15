module D6P1
  class D6P1
    def run(input)
      sum = 0
      group_answers = ""
      input.each do |ans|
        if ans.chomp.empty?
          sum += group_answers.split("").uniq.count
          group_answers = ""
        else
          group_answers += ans
        end
      end
      sum += group_answers.split("").uniq.count
      puts "Sum Total: #{sum}"
    end
  end
end

module D6P2
  class D6P2
    def run(input)
      sum = 0
      group_answers = nil
      input.each do |ans|
        if ans.chomp.empty?
          sum += group_answers.count if group_answers
          group_answers = nil
        else
          ans = ans.chomp.split("")
          group_answers ||= ans
          group_answers &= ans
        end
      end
      sum += group_answers.count if group_answers
      puts "Sum Total: #{sum}"
    end
  end
end
