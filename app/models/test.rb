puts "hello"

def coffee
    puts self
  end

coffee




class Cat
    def meow
      puts self
    end
  end
  Cat.new.meow


  class Example
    def do_something
      banana = "variable"
      puts banana
      puts self.banana
    end
    def banana
      "method"
    end
  end
  Example.new.do_something


  class Cote
    def do_something
      banana = "variable"
      puts banana
      puts self.score
    end
    def banana
      "method"
    end
  end
  Example.new.do_something



