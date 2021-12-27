require_relative 'vietlott'
type = ARGV[0]

generator = VietlottGenerator.new(type.to_i)
puts 'Please wait while generating your vietlott ticket number'

generator.print
puts 'Today will be your lucky day'
