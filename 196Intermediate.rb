# Challenge #196 [Intermediate]: Rail Fence Cipher (2015-01-07)
# from reddit.com/r/dailyprogrammer

# Run instructions for windows:
# ruby 196Intermediate.rb enc 3 REDDITCOMRDAILYPROGRAMMER

# Test cases:
# enc 3 REDDITCOMRDAILYPROGRAMMER ## RIMIRAREDTORALPORMEDCDYGM
# enc 2 LOLOLOLOLOLOLOLOLO ## LLLLLLLLLOOOOOOOOO
# enc 4 THEQUICKBROWNFOXJUMPSOVERTHELAZYDOG ## TCNMRZHIKWFUPETAYEUBOOJSVHLDGQRXOEO
# dec 4 TCNMRZHIKWFUPETAYEUBOOJSVHLDGQRXOEO ## THEQUICKBROWNFOXJUMPSOVERTHELAZYDOG
# dec 7 3934546187438171450245968893099481332327954266552620198731963475632908289907 ## 3141592653589793238462643383279502884197169399375105820974944592307816406286 (pi)
# dec 6 AAPLGMESAPAMAITHTATLEAEDLOZBEN ## ALPHABETAGAMMADELTAEPSILONZETA

def build_map (n, text)
  cipher_map = Array.new
  n.times { cipher_map.push Array.new }

  index = (0..(text.size - 1)).to_a
  line = 0
  forward = true

  while not index.empty? do
    cipher_map[line].push(index.delete_at(0))
    line += forward ? 1 : -1
    if line > (n - 1)
      forward = false
      line = n - 2
    elsif line < 0
      forward = true
      line = 1
    end
  end
  return cipher_map
end

def encode (n, text)
  cipher_map = build_map n, text
  final = ""
  n.times do |i| 
    cipher_map[i].each { |x| final += text[x] }
  end
  return final
end

def decode (n, text)
  cipher_map = build_map n, text
  mapping = Hash.new
  text_array = text.chars
  n.times do |i| 
    cipher_map[i].each { |x| mapping[x] = text_array.delete_at(0) }
  end
  final = ""
  text.size.times { |i| final += mapping[i] }
  return final
end

if ARGV[0] == "enc"
  puts encode ARGV[1].to_i, ARGV[2]
elsif ARGV[0] == "dec"
  puts decode ARGV[1].to_i, ARGV[2]
else
  puts "ERROR: method must be enc or dec"
end