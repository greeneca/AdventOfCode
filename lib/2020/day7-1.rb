module D7P1
  class D7P1
    def run(input)
      all_bags = build_tree(input)
      bag = all_bags["shiny gold"]
      ancestors = traverse_parents(bag)
      puts "Different Parent bags: #{ancestors.count}"
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

    def traverse_parents(bag)
      ancestors = []
      bag.parents.each do |parent|
        ancestors.push(parent.color)
        ancestors += traverse_parents(parent)
      end
      ancestors.uniq
    end
  end

  class Bag
    attr_reader :color, :parents

    def initialize(color)
      @color = color
      @parents = []
      @children = []
    end

    def add_child(child, count)
      @children.push({
        child: child,
        count: count
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
