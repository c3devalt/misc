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
    only_nums = tally.map(&:first)
    f_six = first_six(only_nums)
    l_six = last_six(only_nums)
    m_six = mid_six(only_nums)
    mix = mix_six(f_six, l_six, m_six)
    print_ticket(f_six, m_six, l_six, mix)
  end

  def first_six(nums)
    nums.first(6).sort
  end

  def last_six(nums)
    nums.last(6).sort
  end

  def mid_six(nums)
    nums[(@type / 2 - 3)..(@type / 2 + 2)].sort
  end

  def mix_six(f_six, l_six, m_six)
    (f_six + l_six + m_six).sample(6).sort
  end

  private

  def print_ticket(first, mid, last, mix)
    print_single(first, 'first')
    print_single(mid, 'mid')
    print_single(last, 'last')
    print_single(mix, 'mix')
    prefix = type == MEGA ? '645 K1' : '655 K1'
    puts '*' * type
    ticket_strings = [first, mid, last, mix].map { |t| t.join(' ') }
    puts "#{prefix} S #{ticket_strings.join(' S ')}"
  end

  def print_single(nums, name)
    puts "#{name.capitalize} 6: #{nums.join(' ')}"
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
