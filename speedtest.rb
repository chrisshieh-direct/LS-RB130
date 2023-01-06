def timer(&block)
  before = Time.now
  block.call
  puts (Time.now - before).to_s + " seconds"
end

timer { 300000000.times { |x| x }}
