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
    first_six = tally.first(6)
    last_six = tally.last(6)

    puts 'First 6'
    format(first_six.map(&:first).sort.join(', '))
    puts 'Last 6'
    format(last_six.map(&:first).sort.join(', '))
    puts 'Mix 6'
    format((last_six + first_six).sample(6).map(&:first).sort.join(', '))
  end

  private

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
