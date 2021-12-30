class VietlottGenerator
  attr_reader :type

  MEGA = 45
  POWER = 55
  NUMBER = 6

  TIMES = 10e7.to_i
  def initialize(ticket_type)
    case ticket_type
    when MEGA
      @type = MEGA
    when POWER
      @type = POWER
    else
      raise 'Invalid ticket type: Must be MEGA 45 or POWER 55'
    end
  end

  def print
    tally = generate
    f = tally.first(6)
    l = tally.last(6)
    first_six = f.first(6).map(&:first).sort.join(' ')
    last_six = l.last(6).map(&:first).sort.join(' ')
    mix_six = (f + l).map(&:first).sample(6).sort.join(' ')

    puts 'First 6'
    puts first_six
    puts 'Last 6'
    puts last_six
    puts 'Mix 6'
    puts mix_six
    print_ticket(first_six, last_six, mix_six)
  end

  private

  def print_ticket(first, last, mix)
    prefix = type == MEGA ? '645 K1' : '655 K1'
    puts '*' * type
    puts "#{prefix} S #{[first, last, mix].join(' S ')}"
  end

  def format(ticket)
    puts "[#{ticket}]"
  end

  def generate
    numbers = []
    samples = (1..type).to_a
    TIMES.times { numbers << samples.sample }
    tally = numbers.tally
    tally.sort_by { |_, o| o }
  end
end
