# Challenge #201 [Easy]: Counting The Days Until (2015-02-09)
# from reddit.com/r/dailyprogrammer

# Run instructions for windows: ruby 201Easy.rb

require 'date'

year, month, day = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i
today = Date.today
date_until = Date.new year,month,day
num_days = (date_until - today).to_i
if num_days < 0
  puts "The date is in the past!"
else
  puts "#{num_days} days from #{today} to #{date_until}"
end
