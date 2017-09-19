def q_quick_start
  # loop until you get a good answer and return
  loop do
    print 'Quick start? [y/n]  '
    answer = gets.chomp.downcase
    if answer[0] == 'y' || answer == ''
      return true
    elsif answer[0] == 'n'
      return false
    end
    puts 'That is not a valid answer!'
  end
end

def q_wager(total_money)
  loop do
    print "What will you wager this round? Minimum bet is $#{$ante_size}.  "
    answer = Integer(gets.chomp)
    # unless answer.is_a?(Number)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer.nil? || answer <= $ante_size
      return $ante_size
    elsif answer > total_money
      puts "You can't bet more than you have."
    else
      return answer
    end
    puts 'That is not a valid answer!'
  end
end

def q_make_decision(options)
  # loop until you get a good answer and return
  i = 1
  message = ''
  # "x#{i}".to_sym => :hit
  # (message += "[#{i}] Hit\n"; i+=1; "x#{i}".to_sym = :hit) if options.include?(:hit)
  # (message += "[#{i}] Double\n"; i+=1; "x#{i}".to_sym = :double) if options.include?(:double)
  # (message += "[#{i}] Split\n"; i+=1; "x#{i}".to_sym = :split) if options.include?(:split)
  # (message += "[#{i}] Stand\n"; i+=1; "x#{i}".to_sym = :stand) if options.include?(:stand)
  message += options.include?(:hit) ? "  [H] Hit\n" : ''
  message += options.include?(:double) ? "  [D] Double\n" : ''
  message += options.include?(:split) ? "  [P] Split\n" : ''
  message += options.include?(:stand) ? "  [T] Stand\n" : ''

  loop do
    print message
    print 'What will you do?  '
    answer = gets.chomp.downcase
    if answer[0] == 'h' && options.include?(:hit)
      return :hit
    elsif answer[0] == 'd' && options.include?(:double)
      return :double
    elsif answer[0] == 'p' && options.include?(:split)
      return :split
    elsif answer[0] == 't' && options.include?(:stand)
      return :stand
    end
    puts 'That is not a valid answer!'
  end
end

def q_shoe_size
  # loop until you get a good answer and return
  loop do
    print 'How many decks do you want to play with? [1-5]  '
    answer = Integer(gets.chomp)
    # unless answer.is_a?(Number)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer.nil?
      return 1
    elsif answer < 0
      return -answer
    elsif answer > 5
      puts "That's too many decks."
    elsif answer == 0
      puts 'You need at least one deck.'
    else
      return answer
    end
    # puts "That is not a valid answer!"
  end
end

def q_number_of_humans
  # loop until you get a good answer and return
  loop do
    print 'How many human players are there? [1-7]  '
    answer = gets.chomp
    return 1 if answer == ''
    # answer = Integer(gets.chomp)
    answer = answer.to_i
    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer > 7
      puts 'The maximum is seven.'
      return 7
    elsif answer < 1
      puts 'The minimum is one.'
      return 1
    else
      return answer
    end
  end
end

def q_money(name)
  # loop until you get a good answer and return
  loop do
    print "How much money are you bringing to the table, #{name}?  "
    answer = gets.chomp
    return 10 * $ante_size if answer == ''
    # answer = Integer(gets.chomp)
    answer = answer.to_i

    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer < $ante_size * 10
      puts "You need at least $#{$ante_size * 10} if you're going to have any fun"
      return $ante_size * 10
    elsif answer > 1_000_000_000
      puts 'Any more than $1 billion is irresponsible...'
      return 1_000_000_000
    else
      return answer
    end
  end
end

def q_name(player_id)
  # loop until you get a good answer and return
  loop do
    print "What's your name, #{player_id}?  "
    answer = gets.chomp
    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer == ''
      puts "Nice to meet you, #{player_id}."
      return player_id.to_s
    elsif answer.length > 20
      puts 'Sorry, your name must be shorter than 20 characters.'
    else
      puts "Nice to meet you, #{answer}."
      return answer
    end
  end
end

def q_custom_rules
  # loop until you get a good answer and return
  loop do
    print 'Do you want to change the house rules? [y/n] '
    answer = gets.chomp.downcase
    if answer[0] == 'y'
      return true
    elsif answer[0] == 'n' || answer == ''
      return false
    end
    puts 'That is not a valid answer!'
  end
end

def q_resplit_aces
  # loop until you get a good answer and return
  loop do
    print 'Do you want to allow re-splitting aces? [y/n] '
    answer = gets.chomp.downcase
    if answer[0] == 'y' || answer == ''
      return true
    elsif answer[0] == 'n'
      return false
    end
    puts 'That is not a valid answer!'
  end
end

def q_double_after_split
  # loop until you get a good answer and return
  loop do
    print 'Do you want to allow doubling on a split hand? [y/n] '
    answer = gets.chomp.downcase
    if answer[0] == 'y' || answer == ''
      return true
    elsif answer[0] == 'n'
      return false
    end
    puts 'That is not a valid answer!'
  end
end

def q_insurance
  # loop until you get a good answer and return
  loop do
    answer = gets.chomp.downcase
    if answer[0] == 'y' || answer == ''
      return true
    elsif answer[0] == 'n'
      return false
    end
    puts 'That is not a valid answer!'
  end
end

def q_max_split_hands
  # loop until you get a good answer and return
  loop do
    print "What's the maximum number of hands a player can hold? [1-4] "
    answer = gets.chomp
    return 4 if answer == ''
    # answer = Integer(gets.chomp)
    answer = answer.to_i

    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer > 4
      puts 'The maximum is 4.'
      return 4
    elsif answer < 1
      puts 'The minimum is 1.'
      return 1
    else
      return answer
    end
  end
end

def q_ante_size
  # loop until you get a good answer and return
  loop do
    print "What's the ante size? "
    answer = gets.chomp
    return 10 if answer == ''
    # answer = Integer(gets.chomp)
    answer = answer.to_i

    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer > 1000
      puts 'The maximum is 1000.'
      return 4
    elsif answer < 1
      puts 'The minimum is 1.'
      return 1
    else
      return answer
    end
  end
end
