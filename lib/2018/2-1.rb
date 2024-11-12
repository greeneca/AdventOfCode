module D2P1
  class D2P1
    def run(input)
      lines_with_double = 0
      lines_with_triple = 0

      input.each do |line|
        has_2, has_3 = false
        all_chars = line.chars
        all_chars.uniq.each do |char|
          count = all_chars.count(char)
          has_2 ||= count == 2
          has_3 ||= count == 3
          break if has_2 and has_3
        end
        lines_with_double += 1 if has_2
        lines_with_triple += 1 if has_3
      end

      puts "Checksum: #{lines_with_double * lines_with_triple}"
    end
  end
end
