# Challenge #196 [Easy]: ISBN Validator (2015-01-12)
# from reddit.com/r/dailyprogrammer

# Run instructions for windows:
# ruby 197Easy.rb 0-7475-3269-9 OR ruby 197Easy.rb 0747532699

def check_isbn (isbn)
  isbn_list = Array.new
  isbn.gsub(/\D/, '').split("").each { |i| isbn_list.push i.to_i } 
  isbn_list.push 10 if isbn[-1] == 'X'
  (1..10).reverse_each { |i| isbn_list[i-1] *= i }
  sum = isbn_list.inject { |sum,x| sum + x }
  sum % 11 == 0
end

p check_isbn ARGV[0]