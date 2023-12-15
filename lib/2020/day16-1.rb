module D16P1
  class D16P1
    def run(input)
      rules, my_ticket, other_tickets = process_input(input)
      invalid = []
      other_tickets.each do |ticket|
        ticket.each do |value|
          found = false
          rules.each_value do |ranges|
            if ranges.first.include?(value) or ranges.last.include?(value)
              found = true
              break
            end
          end
          invalid.push(value) unless found
        end
      end
      puts invalid.to_s
      puts "Scanning Error Rate: #{invalid.reduce(:+)}"
    end

    def process_input(input)
      mode = :rules
      rules = {}
      my_ticket = nil
      other_tickets = []
      input.each do |line|
        unless line.chomp.empty?
          case mode
          when :rules
            if line.start_with?("your ticket:")
              mode = :my
            else
              rule = line.chomp.split(":")
              ranges = rule.last.split(" ").select{|val| val != "or"}
              ranges.map! do |range|
                range = range.split("-").map {|val| val.to_i}
                (range.first..range.last)
              end
              rules[rule.first] = ranges
            end
          when :my
            if line.start_with?("nearby tickets:")
              mode = :others
            else
              my_ticket = line.chomp.split(",").map{|val| val.to_i}
            end
          when :others
            other_tickets.push(line.chomp.split(",").map{|val| val.to_i})
          end
        end
      end
      [rules, my_ticket, other_tickets]
    end
  end
end
