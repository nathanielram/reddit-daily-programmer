# Challenge #199: Bank Number Banners Pt 1 (2015-01-26)
# from reddit.com/r/dailyprogrammer

# Run instructions for windows: ruby 199pt1.rb

def draw_banner(number)
  digits = {
            0 => [" _ ", "| |", "|_|"],  
            1 => ["   ", "  |", "  |"],  
            2 => [" _ ", " _|", "|_ "],  
            3 => [" _ ", " _|", " _|"], 
            4 => ["   ", "|_|", "  |"], 
            5 => [" _ ", "|_ ", " _|"],  
            6 => [" _ ", "|_ ", "|_|"], 
            7 => [" _ ", "  |", "  |"], 
            8 => [" _ ", "|_|", "|_|"], 
            9 => [" _ ", "|_|", " _|"]  
          }

  (0...3).each do |i|
    number.chars.map(&:to_i).each { |digit| print digits[digit][i] }
    puts "\n"
  end
end

def draw_banner2(number)
  numbers = [ 
              "    _  _     _  _  _  _  _  _ ",
              "  | _| _||_||_ |_   ||_||_|| |",
              "  ||_  _|  | _||_|  ||_| _||_|"
            ]
  numbers.size.times do |i|
    line = ""
    number.chars.map(&:to_i).each do |digit|
      line += digit != 0 ? numbers[i][(digit * 3 - 3)...(digit * 3)] : numbers[i][(10 * 3 - 3)...(10 * 3)]
    end
    puts line
  end
  puts "\n"
end

def draw(number)
  draw_banner number
  draw_banner2 number
end

puts "Input your a nine digit number: "
number = gets.chomp
(number.size == 9) ? (draw number) : (puts "number must be NINE digits exactly!!!")