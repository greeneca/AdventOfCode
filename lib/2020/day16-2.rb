module D16P2
  class D16P2
    def run(input)
      rules, my_ticket, other_tickets = process_input(input)
      other_ticket_categories = []
      other_tickets.each do |ticket|
        ticket_categories = []
        ticket.each do |value|
          found = false
          categories = []
          rules.each_pair do |category, ranges|
            if ranges.first.include?(value) or ranges.last.include?(value)
              found = true
              categories.push(category)
            end
          end
          if found
            ticket_categories.push(categories)
          else
            ticket_categories = nil
            break
          end
        end
        if ticket_categories
          other_ticket_categories.push(ticket_categories)
        end
      end
      possible_categories = other_ticket_categories.reduce([]) do |categories, ticket_categories|
        new_categories = []
        ticket_categories.each_with_index do |category, idx|
          if categories[idx]
            new_categories.push(category & categories[idx])
          else
            new_categories.push(category)
          end
        end
        new_categories
      end
      while possible_categories.count != possible_categories.flatten.count
        known_fields = possible_categories.select{|category| category.count == 1}.flatten
        possible_categories.map! do |category|
          if category.count > 1
            category = category - known_fields
          end
          category
        end
      end
      categories = possible_categories.flatten
      answer = 1
      my_ticket.each_with_index do |value, idx|
        if categories[idx].include?("departure")
          answer *= value
        end
      end
      puts "Answer: #{answer}"
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
