module D16P1
  class D16P1
    def run(input)
      input.each do |line|
        line = line.strip.split("").map do |char|
          char.to_i(16).to_s(2).rjust(4, '0')
        end
        sum, _remainder = parse_packet(line.join(""))
        puts "Sum: #{sum}"
      end
    end
    def parse_packet(packet)
      version = packet[0..2].to_i(2)
      type = packet[3..5].to_i(2)
      if type == 4
        index = 6
        loop do
          flag = packet[index].to_i(2)
          index += 5
          break if flag == 0
        end
        remainder = packet[index..-1]
        return version, remainder
      end
      length_type_id = packet[6].to_i(2)
      sum = version
      if length_type_id == 0
        length = packet[7..21].to_i(2)
        sub_packets = packet[22..(length+21)]
        while !sub_packets.empty?
          sub_sum, sub_packets = parse_packet(sub_packets)
          sum += sub_sum
        end
        return sum, packet[(22+length)..-1]
      elsif length_type_id == 1
        length = packet[7..17].to_i(2)
        sub_packets = packet[18..-1]
        length.times do
          sub_sum, sub_packets = parse_packet(sub_packets)
          sum += sub_sum
        end
        return sum, sub_packets
      end
    end
  end
end

module D16P2
  class D16P2
    def run(input)
      input.each do |line|
        line = line.strip.split("").map do |char|
          char.to_i(16).to_s(2).rjust(4, '0')
        end
        value, _remainder = parse_packet(line.join(""))
        puts "Value: #{value}"
      end
    end
    def parse_packet(packet)
      version = packet[0..2].to_i(2)
      type = packet[3..5].to_i(2)
      if type == 4
        index = 6
        value = ""
        loop do
          flag = packet[index].to_i(2)
          value =+ "#{packet[index+1..index+4].to_i(2)}"
          index += 5
          break if flag == 0
        end
        remainder = packet[index..-1]
        return value.to_i, remainder
      end
      length_type_id = packet[6].to_i(2)
      values = []
      remainder = ""
      if length_type_id == 0
        length = packet[7..21].to_i(2)
        sub_packets = packet[22..(length+21)]
        while !sub_packets.empty?
          sub_value, sub_packets = parse_packet(sub_packets)
          values.push sub_value
        end
        remainder = packet[(22+length)..-1]
      elsif length_type_id == 1
        length = packet[7..17].to_i(2)
        sub_packets = packet[18..-1]
        length.times do
          sub_value, sub_packets = parse_packet(sub_packets)
          values.push sub_value
        end
        remainder = sub_packets
      end
      case type
      when 0
        return values.sum(), remainder
      when 1
        return values.reduce(1,:*), remainder
      when 2
        return values.min(), remainder
      when 3
        return values.max(), remainder
      when 5
        return (values.reduce(:-) > 0 ? 1 : 0), remainder
      when 6
        return (values.reduce(:-) < 0 ? 1 : 0), remainder
      when 7
        return (values.reduce(:-) == 0 ? 1 : 0), remainder
      end
    end
  end
end
