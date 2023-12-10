module D10P1
  class D10P1
    def run(input)
      map = {}
      start = nil
      input.each_with_index do |line, y|
        line.split("").each_with_index do |char, x|
          pos = Vector[x,y]
          map[pos] = char
          if char == "S"
            start = pos
          end
        end
      end
      current = []
      dir_checks = {
        Vector[1, 0] => ["-", "J", "7"],
        Vector[-1, 0] => ["-", "F", "L"],
        Vector[0, -1] => ["|", "F", "7"],
        Vector[0, 1] =>  ["|", "J", "L"]
      }
      pos_checks = {
        "|" => [Vector[0, 1], Vector[0, -1]],
        "-" => [Vector[1, 0], Vector[-1, 0]],
        "J" => [Vector[0, -1], Vector[-1, 0]],
        "7" => [Vector[0, 1], Vector[-1, 0]],
        "F" => [Vector[0, 1], Vector[1, 0]],
        "L" => [Vector[0, -1], Vector[1, 0]]
      }
      dir_checks.each_pair do |dir, valid_char|
        test_pos = start+dir
        if valid_char.include?(map[test_pos])
          current.push test_pos
        end
      end
      steps = 1
      prev_current = [start]
      while current.count == 2 and current[0] != current[1]
        new_current = []
        current.each do |pos|
          check_dirs = pos_checks[map[pos]]
          check_dirs.each do |test_dir|
            check = pos+test_dir
            if dir_checks[test_dir].include?(map[check]) and !prev_current.include?(check)
              new_current.push check
            end
          end
        end
        prev_current = current
        current = new_current
        steps += 1
      end
      puts "Steps: #{steps}"
    end
  end
end
