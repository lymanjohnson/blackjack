def q_quick_start
  # loop until you get a good answer and return
  loop do
    print "\n\nQuick start? [y/n]  "
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "y" || answer == ""
      #clean
      return true
    elsif answer[0] == "n"
      #clean
      return false
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_wager(total_money)
  loop do
    print "\n\nWhat will you wager this round? Minimum bet is $#{$ante_size}.  "
    answer = gets.chomp
    #binding.pry
    if answer == ""
      puts "\n\nYou bet $#{$ante_size}"
      return $ante_size
    end
    answer = Integer(answer)
    # unless answer.is_a?(Number)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer <= $ante_size
      puts "You must bet at least #{$ante_size}"
      return $ante_size
    elsif answer > total_money
      puts "You can't bet more than you have."
    else
      return answer
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_make_decision(options)
  # loop until you get a good answer and return
  message = ""
  message += options.include?(:hit) ? "  [H] Hit\n" : ""
  message += options.include?(:double) ? "  [D] Double\n" : ""
  message += options.include?(:split) ? "  [P] Split\n" : ""
  message += options.include?(:stand) ? "  [T] Stand\n" : ""

  loop do
    print message
    print "What will you do?  "
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "h" && options.include?(:hit)
      return :hit
    elsif answer[0] == "d" && options.include?(:double)
      return :double
    elsif answer[0] == "p" && options.include?(:split)
      return :split
    elsif answer[0] == "t" && options.include?(:stand)
      return :stand
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_shoe_size
  # loop until you get a good answer and return
  loop do
    print "How many decks do you want to play with? [1-5]  "
    answer = Integer(gets.chomp)
    #binding.pry
    if answer.nil?
      return 1
    elsif answer < 0
      return -answer
    elsif answer > 5
      puts "\n\nThat's too many decks."
    elsif answer == 0
      puts "\n\nYou need at least one deck."
    else
      return answer
    end
    # puts "\n\nThat is not a valid answer!"
  end
end

def q_number_of_humans
  # loop until you get a good answer and return
  loop do
    print "How many human players are there? [1-7]  "
    answer = gets.chomp
    #binding.pry
    return 1 if answer == ""
    answer = answer.to_i
    if answer > 7
      puts "\n\nThe maximum is seven."
      return 7
    elsif answer < 1
      puts "\n\nThe minimum is one."
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
    #binding.pry
    return 10 * $ante_size if answer == ""
    # answer = Integer(gets.chomp)
    answer = answer.to_i
    if answer < $ante_size * 10
      puts "\n\nYou need at least $#{$ante_size * 10} if you're going to have any fun"
      return $ante_size * 10
    elsif answer > 1_000_000_000
      puts "\n\nAny more than $1 billion is irresponsible..."
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
    #binding.pry
    if answer == ""
      puts "\n\nNice to meet you, #{player_id}."
      return player_id.to_s
    elsif answer.length > 20
      puts "\n\nSorry, your name must be shorter than 20 characters."
    else
      puts "\n\nNice to meet you, #{answer}."
      return answer
    end
  end
end

def q_custom_rules
  # loop until you get a good answer and return
  loop do
    print "Do you want to change the house rules? [y/n] "
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "y"
      return true
    elsif answer[0] == "n" || answer == ""
      return false
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_keep_playing
  # loop until you get a good answer and return
  loop do
    print "Do you want to play another hand? [y/n] "
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_resplit_aces
  # loop until you get a good answer and return
  loop do
    print "Do you want to allow re-splitting aces? [y/n] "
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_hit_on_soft_seventeen
  # loop until you get a good answer and return
  loop do
    print "Will the dealer hit on a soft seventeen? [y/n] "
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_double_after_split
  # loop until you get a good answer and return
  loop do
    print "Do you want to allow doubling on a split hand? [y/n] "
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_insurance
  # loop until you get a good answer and return
  loop do
    answer = gets.chomp.downcase
    #binding.pry
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "\n\nThat is not a valid answer!"
  end
end

def q_max_split_hands
  # loop until you get a good answer and return
  loop do
    print "What's the maximum number of hands a player can hold? [1-4] "
    answer = gets.chomp
    #binding.pry
    return 4 if answer == ""
    # answer = Integer(gets.chomp)
    answer = answer.to_i
    if answer > 4
      puts "\n\nThe maximum is 4."
      return 4
    elsif answer < 1
      puts "\n\nThe minimum is 1."
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
    #binding.pry
    return 10 if answer == ""
    answer = answer.to_i
    if answer > 1000
      puts "\n\nThe maximum is 1000."
      return 4
    elsif answer < 1
      puts "\n\nThe minimum is 1."
      return 1
    else
      return answer
    end
  end
end
