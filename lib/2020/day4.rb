module D4P1
  class D4P1
    def run(input)
      required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
      valid_count = 0
      parsed_data = {}
      input.each do |line|
        if line.chomp.empty?
          if (required_fields - parsed_data.keys).count == 0
            valid_count += 1
          end
          parsed_data = {}
        else
          line.split.each do |data|
            key, value = data.split(":")
            parsed_data[key] = value
          end
        end
      end
      if (required_fields - parsed_data.keys).count == 0
        valid_count += 1
      end
      puts "Valid Passports: #{valid_count}"
    end
  end
end

module D4P2
  class D4P2
    def run(input)
      valid_count = 0
      parsed_data = {}
      input.each do |line|
        if line.chomp.empty?
          if is_valid?(parsed_data)
            valid_count += 1
          end
          parsed_data = {}
        else
          line.split.each do |data|
            key, value = data.split(":")
            parsed_data[key] = value
          end
        end
      end
      if is_valid?(parsed_data)
        valid_count += 1
      end
      puts "Valid Passports: #{valid_count}"
    end

    def is_valid?(data)
      required_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
      return false if (required_fields - data.keys).count > 0
      byr = data["byr"].to_i
      return false if byr > 2002 or byr < 1920
      iyr = data["iyr"].to_i
      return false if iyr > 2020 or iyr < 2010
      eyr = data["eyr"].to_i
      return false if eyr > 2030 or eyr < 2020
      if data["hgt"].end_with?("cm")
        hgt = data["hgt"].to_i
        return false if hgt > 193 or hgt < 150
      elsif data["hgt"].end_with?("in")
        hgt = data["hgt"].to_i
        return false if hgt > 76 or hgt < 59
      else
        return false
      end
      return false unless data["hcl"].match(/#[0-9a-f]{6}/)
      return false unless ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include?(data["ecl"])
      return false unless data["pid"].match(/\d{9}/) and data["pid"].length == 9
      return true
    end
  end
end
