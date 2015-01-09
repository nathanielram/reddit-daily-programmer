# Challenge #196 [Intermediate]: Rail Fence Cipher (2015-01-07)
# from reddit.com/r/dailyprogrammer

# Run instructions:
# ./196Intermediate.rb enc 3 REDDITCOMRDAILYPROGRAMMER
# OR
# ruby 196Intermediate.rb enc 3 REDDITCOMRDAILYPROGRAMMER

# Test cases:
# enc 3 REDDITCOMRDAILYPROGRAMMER ## RIMIRAREDTORALPORMEDCDYGM
# enc 2 LOLOLOLOLOLOLOLOLO ## LLLLLLLLLOOOOOOOOO
# enc 4 THEQUICKBROWNFOXJUMPSOVERTHELAZYDOG ## TCNMRZHIKWFUPETAYEUBOOJSVHLDGQRXOEO
# dec 4 TCNMRZHIKWFUPETAYEUBOOJSVHLDGQRXOEO ## THEQUICKBROWNFOXJUMPSOVERTHELAZYDOG
# dec 7 3934546187438171450245968893099481332327954266552620198731963475632908289907 ## 3141592653589793238462643383279502884197169399375105820974944592307816406286 (pi)
# dec 6 AAPLGMESAPAMAITHTATLEAEDLOZBEN ## ALPHABETAGAMMADELTAEPSILONZETA

def build_map (n, w)
  s = Array.new
  n.times { s.push Array.new }

  index = (0..(w.size - 1)).to_a
  line = 0
  forward = true

  while not index.empty? do
    s[line].push(index.delete_at(0))
    line += forward ? 1 : -1
    if line > (n - 1)
      forward = false
      line = n - 2
    elsif line < 0
      forward = true
      line = 1
    end
  end
end

def encode (n, w)
  puts "encode"
  s = build_map n, w
  final = ""
  n.times { |i| s[i].each { |x| final += w[x] } }
  final
end

def decode (n, w)
  puts "decode"
  s = build_map n, w
  mapping = Hash.new
  wa = w.split("")
  n.times { |i| s[i].each { |x| mapping[x] = wa.delete_at(0) } }
  final = ""
  w.size.times { |i| final += mapping[i] }
  final
end

ARGV[1] = ARGV[1].to_i
if ARGV[0] == "enc"
  puts encode ARGV[1], ARGV[2]
elsif ARGV[0] == "dec"
  puts decode ARGV[1], ARGV[2]
else
  puts "ERROR: method must be enc or dec"
end