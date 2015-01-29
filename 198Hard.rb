# Challenge #198 [Hard]: Words With Enemies (2015-01-23)
# from reddit.com/r/dailyprogrammer

# Run instructions for windows: ruby 198Hard.rb

class Round 
  attr_accessor :letters, :dictionary, :alphabet, :possible_words, :player_pts, :ai_pts

  def initialize(dictionary)
    @alphabet = ('a'..'z').to_a
    @dictionary = dictionary
  end

  def generate_letters(num_letters)
    @letters = num_letters.times.map{ alphabet[rand(26)] } 
    build_possible_words
    if (@letters.to_s.scan(/[aeiou]/).count > (num_letters / 5)) || (@possible_words.size > 30)
      print_letters @letters
    else
      generate_letters num_letters
    end
  end

  def print_letters(letters)
    print "The available letters are: "
    letters.each { |letter| print (letter + "  ") }
    puts "\n"
  end

  def input_word
    word = ""
    loop do
      print "Input your word: "
      word = gets.chomp
      break if check_word?(word) 
    end
    word
  end

  def build_possible_words
    @possible_words = @dictionary.find_all { |word| check_word? word}
  end

  def make_ai_word(difficulty)
    puts "\n\n", "--The possible words are--", possible_words, "\n\n"
    
    case difficulty
    when 1 then @possible_words.min_by(&:length)
    when 2 then @possible_words.sample
    when 3 then @possible_words.max_by(&:length)
    end
  end

  def check_word?(word)
    (word.split("") - @letters == []) && (check_word_duplicates? word) && (dictionary.include? word)
  end

  def check_word_duplicates?(word)
    temp_letters = @letters.clone
    word.chars.each do |letter|
      r = temp_letters.delete letter
      return false if r.nil?
    end
    true
  end

  def battle(word1, word2)
    (word1 + word2).chars.each do |letter|
      if word1.include?(letter) && word2.include?(letter)
        word1 = word1.sub letter, ''
        word2 = word2.sub letter, ''
      end
    end
    diff = (word1.size - word2.size).abs
    case
    when diff == 0 then [diff.abs, diff.abs] #[0,0]
    when diff > 0 then [diff.abs, 0]
    when diff < 0 then [0, diff.abs]
    end
  end
end

class Game
  attr_accessor :ai_pts, :player_pts, :ai_rounds, :player_rounds, :dictionary, :generated_words, :difficulty, :current_round, :round_num, :num_turns

  def initialize(num_letters, difficulty)
    @num_turns = 5
    @ai_pts = @player_pts = @ai_rounds = @player_rounds = 0
    @round_num = 1
    @num_letters = 10 # Should this change based on difficulty?
    @difficulty = difficulty.to_i
    
    build_words
  end

  def build_words
    @dictionary = Array.new
    File.open("198dict.txt", "r") do |f|
      f.each_line { |word| @dictionary.push word.strip }
    end
  end

  def start_game
    while @round_num <= 5
      puts "====== Round #{@round_num} ======"
      @current_round = Round.new @dictionary
      @current_round.generate_letters @num_letters
      word1 = @current_round.input_word
      word2 = @current_round.make_ai_word @difficulty
      puts "Selected words -- Player: \"#{word1}\" Computer: \"#{word2}\""
      pt1, pt2 = @current_round.battle word1, word2
      @player_pts += pt1
      @ai_pts += pt2
      puts
        case 
        when pt1 > pt2 
          @player_rounds += 1
          "You won the round!"
        when pt1 < pt2 
          @ai_rounds += 1
          "The computer won the round!"
        when pt1 == pt2 then "The round was tied!"   
        end
      puts "Round #{@round_num} Score -- Player: #{pt1} Computer: #{pt2}"
      puts "Total Score -- Player: #{@player_pts} Computer: #{@ai_pts}"
      puts "Rounds Won -- Player: #{@player_rounds} Computer: #{@ai_rounds}"
      @round_num += 1
    end
    
    final_scores  
  end

  def final_scores
    puts "====== Game Over!!! ======"
    puts "Final Score -- Player: #{@player_pts} Computer: #{@ai_pts}"
    puts "Final Round Wins -- Player: #{@player_rounds} Computer: #{@ai_rounds}"
    print "By score: "
    puts
      case 
      when @player_pts > @ai_pts then "You won the game!"
      when @player_pts < @ai_pts then "The Computer won the game!"
      when @player_pts == @ai_pts then "The game is tied"
      end
    print "By rounds won: "
    puts
      case 
      when @player_rounds > @ai_rounds then "You won the game!"
      when @player_rounds < @ai_rounds then "The Computer won the game!"
      when @player_rounds == @ai_rounds then "The game is tied"
      end
  end

end


puts "Welcome to Words with Enemies!"
difficulty = 0
loop do
  print "Enter difficulty (1(Easy) - 3(Hard)): "
  difficulty = gets.chomp.to_i
  break if difficulty.between?(1,3)
end

g = Game.new difficulty
g.start_game
