# # Group 1
# my_proc = proc { |thing| puts "This is a #{thing}." }
# puts my_proc
# puts my_proc.class
# my_proc.call
# my_proc.call('cat')

# First it puts the proc object, then the class of the proc with is a Proc.
# Then we call the proc (chunk of code) with no argument. Arity is lenient so no error
# is thrown, but there is no string passed so it outputs 'This is a .'
# Finally we call the proc with a string which outputs "This is a cat."

# # Group 2
# my_lambda = lambda { |thing| puts "This is a #{thing}." }
# my_second_lambda = -> (thing) { puts "This is a #{thing}." }
# puts my_lambda
# puts my_second_lambda
# puts my_lambda.class
# my_lambda.call('dog')
# # my_lambda.call
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }

# Prediction
# Is -> an alias for lambda? So maybe first two lines are identical?
# First line is #{Lambda:0902938203948234 exploring_proc_lam_bl.rb: 14}
# Second line is #{Lambda:0902938203948234 exploring_proc_lam_bl.rb: 15}
# Then we have 'Lambda'
# Next is "This is a dog."
# "This is a ." OKAY. Arity is stricter for Lambda
# third lambda? Or is this not a class at all? HMM. Is it a pseudoclass?

# # Group 3
# def block_method_1(animal)
#   yield
# end

# block_method_1('seal') { |seal| puts "This is a #{seal}."}
# block_method_1('seal')

# I don't think the animal was passed to the yield. Arity is lenient so we get
# "This is a ."
# Second call has no block so we'll get LocalJumpError

# # Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}

# Blocks are passed for all so no LocalJumpError. First call outputs
# "This is a turtle." Second call outputs "This is a turtle and a ." because
# arity is lenient but no seal is provided. Third call ... HMM. No parameter definition.
# Magically will it output "This is a turtle." ???? NOPE. Local variable undefined.

summary = <<~HEREDOC
Okay, so... procs have lenient arity. Blocks have lenient arity. Lambdas are strict. Also I guess a Lambda is some kind
of weird pseudoclass or something that isn't a constant. We haven't explored why you would use a lambda instead.
OH

A Lambda is a different variety of Proc.

the object is #<Proc:09238029384203948 filename.rb:1 (lambda)>
HEREDOC
