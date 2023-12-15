module D11P1
  class D11P1
    def run(input)
      octs = {}
      input.each_with_index do |line,y|
        line.strip.split("").each_with_index do |value,x|
          octs[Matrix[[x],[y]]] = value.to_i
        end
      end
      adj = []
      (-1..1).each do |x|
        (-1..1).each do |y|
          adj.push(Matrix[[x],[y]]) unless x == 0 and y == 0
        end
      end
      count = 0
      100.times do
        octs.keys.each {|k| octs[k]+=1}
        all_flashing = octs.select{|k,v| v > 9}.keys
        flashing = all_flashing
        while flashing.count > 0
          flashing.each do |pos|
            adj.each do |offset|
              octs[pos+offset]+=1 if octs[pos+offset]
            end
          end
          new_flashing = octs.select{|k,v| v > 9}.keys-all_flashing
          flashing = new_flashing
          all_flashing += new_flashing
        end
        count += all_flashing.count
        all_flashing.each do |key|
          octs[key] = 0
        end
      end
      puts "Total Count: #{count}"
    end
  end
end

module D11P2
  class D11P2
    def run(input)
      octs = {}
      input.each_with_index do |line,y|
        line.strip.split("").each_with_index do |value,x|
          octs[Matrix[[x],[y]]] = value.to_i
        end
      end
      adj = []
      (-1..1).each do |x|
        (-1..1).each do |y|
          adj.push(Matrix[[x],[y]]) unless x == 0 and y == 0
        end
      end
      count = 1
      loop do
        octs.keys.each {|k| octs[k]+=1}
        all_flashing = octs.select{|k,v| v > 9}.keys
        flashing = all_flashing
        while flashing.count > 0
          flashing.each do |pos|
            adj.each do |offset|
              octs[pos+offset]+=1 if octs[pos+offset]
            end
          end
          new_flashing = octs.select{|k,v| v > 9}.keys-all_flashing
          flashing = new_flashing
          all_flashing += new_flashing
        end
        if all_flashing.count == octs.count
          break
        end
        all_flashing.each do |key|
          octs[key] = 0
        end
        count += 1
      end
      puts "Sync on Round: #{count}"
    end
  end
end
