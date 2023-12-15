module D15P2
  class D15P2
    def run(input)
      seq = input.first.split(",")
      boxes = Array.new(256){{order: [], length: {}}}
      seq.each do |step|
        op = step[-1]
        op = step[-2] if op != "-"
        key = step.chop
        key = key.chop if key[-1] == "="
        box_key = hash(key)
        box = boxes[box_key]
        label = key.to_sym
        case op
        when "-"
          box[:order].delete(label)
          box[:length].delete(label)
        when "="
          box[:order].push(label) unless box[:order].include?(label)
          box[:length][label] = step[-1].to_i
        end
        #puts "After \"#{step}\" #{box_key}:#{label}:#{op}:#{step[-1]}"
        #print(boxes)
        #puts ""
      end
      power = 0
      boxes.each_with_index do |box, idx|
        box[:order].each_with_index do |lense, slot|
          lense_power = (idx+1)*(slot+1)*box[:length][lense]
          #puts "#{lense} - box: #{idx}, slot #{slot}, focal length #{box[:length][lense]} = #{lense_power}"
          power += lense_power
        end
      end
      puts "Power: #{power}"
    end
    def hash(step)
      hash = 0
      step.each_byte do |byte|
        hash += byte
        hash *= 17
        hash = hash % 256
      end
      return hash
    end
    def print(boxes)
      boxes.each_with_index do |box, idx|
        if box[:order].count > 0
          str = "Box #{idx}: "
          box[:order].each_with_index do |lense, slot|
            str += "[#{lense} #{box[:length][lense]}]"
          end
          puts str
        end
      end
    end
  end
end
