module D5P1
  class D5P1
    def run(input)
      max_id = 0
      input.each do |seat|
        seat = seat.split("")
        row = (0..127).bsearch {|r| seat.shift == "F" or r == 127}
        col = (0..7).bsearch {|c|  seat.shift == "L" or c == 7}
        id = row * 8 + col
        max_id = id if id > max_id
      end
      puts "Max Id: #{max_id}"
    end
  end
end

module D5P2
  class D5P2
    def run(input)
      seats = (0..928).to_a
      input.each do |seat|
        seat = seat.split("")
        row = (0..127).bsearch {|r| seat.shift == "F" or r == 127}
        col = (0..7).bsearch {|c|  seat.shift == "L" or c == 7}
        id = row * 8 + col
        seats.delete_if {|seat| seat == id}
      end
      puts "Your seat: #{seats.last}"
    end
  end
end
