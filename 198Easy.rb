# Challenge #198 [Easy]: Words With Enemies (2015-01-19)
# from reddit.com/r/dailyprogrammer

# Run instructions for windows:
# ruby 198Easy.rb (word1) (word2)
# ex: ruby 198Easy.rb because cause

# Test cases:
# because cause => because
# hello below => tie
# hit miss => miss
# rekt pwn => rekt
# combo jumbo => tied
# critical optical => critical 
# isoenzyme apoenzyme => tied
# tribesman brainstem => tied
# blames nimble => tied
# yakuza wizard => tied
# longbow blowup => longbow

def battle(word1, word2)
  (word1 + word2).chars.each do |letter|
    if word1.include?(letter) && word2.include?(letter)
      word1 = word1.sub letter, ''
      word2 = word2.sub letter, ''
    end
  end
  [word1, word2]
end

def remainder(word1, word2)
  diff = word1.size - word2.size
  case 
  when diff == 0 then "The battle is tied"
  when diff > 0 then "The battle is won by \"#{ARGV[0]}\""
  when diff < 0 then "The battle is won by \"#{ARGV[1]}\""
  end
end

word1, word2 = ARGV[0], ARGV[1]
r1, r2 = battle word1, word2
puts "#{remainder r1, r2} and the remainder is \"#{r1}\" and \"#{r2}\" (won by #{(r1.size - r2.size).abs} point(s))"