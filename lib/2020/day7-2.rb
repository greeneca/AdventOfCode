module D7P2
  class D7P2
    def run(input)
      all_bags = build_tree(input)
      bag = all_bags["shiny gold"]
      count = traverse_children(bag)-1
      puts "Child Bags: #{count}"
    end

    def build_tree(input)
      all_bags = {}
      input.each do |rule|
        rule.chomp!
        parent, children = rule.split("bags contain").map{|i| i.strip}
        unless all_bags[parent]
          all_bags[parent] = Bag.new(parent)
        end
        parent = all_bags[parent]
        unless children.chomp == "no other bags."
          children.split(",").each do |child|
            child = child.split
            count  = child[0]
            child = [child[1], child[2]].join(" ")
            unless all_bags[child]
              all_bags[child] = Bag.new(child)
            end
            child = all_bags[child]
            parent.add_child(child, count)
          end
        end
      end
      all_bags
    end

    def traverse_children(bag)
      count = 1
      bag.children.each do |child_rule|
        count += (child_rule[:count] * traverse_children(child_rule[:child]))
      end
      count
    end
  end

  class Bag
    attr_reader :color, :parents, :children

    def initialize(color)
      @color = color
      @parents = []
      @children = []
    end

    def add_child(child, count)
      @children.push({
        child: child,
        count: count.to_i
      })
      child.add_parent(self)
    end

    def add_parent(parent)
      @parents.push(parent)
    end

    def to_s
      child_string = @children.map{|child| "#{child[:count]} #{child[:child].color}"}
      "#{color} -> #{child_string.join(", ")}"
    end
  end
end
