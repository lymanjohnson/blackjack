def q_quick_start
  # loop until you get a good answer and return
  while true
    print "Quick start? [y/n]  "
    answer = gets.chomp.downcase
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "That is not a valid answer!"
  end
end

def q_hit_again
  # loop until you get a good answer and return
  while true
    print "Do you want to (h)it or (s)tand?  "
    answer = gets.chomp.downcase
    if answer[0] == "h"
      return true
    elsif answer[0] == "s"
      return false
    end
    puts "That is not a valid answer!"
  end
end

def q_shoe_size
  # loop until you get a good answer and return
  while true
    print "How many decks do you want to play with? [1-5]  "
    answer = Integer(gets.chomp)
    # unless answer.is_a?(Number)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer == nil
      return 1
    elsif answer < 0
      return -answer
    elsif answer > 5
      puts "That's too many decks."
    elsif answer == 0
      puts "You need at least one deck."
    else
      return answer
    end
    # puts "That is not a valid answer!"
  end
end

def q_number_of_humans
  # loop until you get a good answer and return
  while true
    print "How many human players are there? [1-7]  "
    answer = gets.chomp
    if answer == ""
      return 1
    end
    # answer = Integer(gets.chomp)
    answer = answer.to_i
    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer > 7
      puts "The maximum is seven."
      return 7
    elsif answer < 1
      puts "The minimum is one."
      return 1
    else
      return answer
    end
  end
end

def q_money(name)
  # loop until you get a good answer and return
  while true
    print "How much money are you bringing to the table, #{name}?  "
    answer = gets.chomp
    if answer == ""
      return 10*$ante_size
    end
    # answer = Integer(gets.chomp)
    answer = answer.to_i

    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer < $ante_size*10
      puts "You need at least $#{$ante_size*10} if you're going to have any fun"
      return $ante_size*10
    elsif answer > 1000000000
      puts "Any more than $1 billion is irresponsible..."
      return 1000000000
    else
      return answer
    end
  end
end

def q_name(player_id)
  # loop until you get a good answer and return
  while true
    print "What's your name, #{player_id}?  "
    answer = gets.chomp
    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer == ""
      puts "Nice to meet you, #{player_id}."
      return "#{player_id}"
    elsif answer.length > 20
      puts "Sorry, your name must be shorter than 20 characters."
    else
      puts "Nice to meet you, #{answer}."
      return answer
    end
  end
end

def q_custom_rules
  # loop until you get a good answer and return
  while true
    print "Do you want to change the house rules? [y/n] "
    answer = gets.chomp.downcase
    if answer[0] == "y"
      return true
    elsif answer[0] == "n" || answer == ""
      return false
    end
    puts "That is not a valid answer!"
  end
end

def q_resplit_aces
  # loop until you get a good answer and return
  while true
    print "Do you want to allow re-splitting aces? [y/n] "
    answer = gets.chomp.downcase
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "That is not a valid answer!"
  end
end

def q_double_after_split
  # loop until you get a good answer and return
  while true
    print "Do you want to allow doubling on a split hand? [y/n] "
    answer = gets.chomp.downcase
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "That is not a valid answer!"
  end
end

def q_offer_insurance
  # loop until you get a good answer and return
  while true
    print "Do you want to allow insurance if dealer's top card is an ace? [y/n] "
    answer = gets.chomp.downcase
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    puts "That is not a valid answer!"
  end
end

def q_max_split_hands
  # loop until you get a good answer and return
  while true
    print "What's the maximum number of hands a player can hold? [1-4] "
    answer = gets.chomp
    if answer == ""
      return 4
    end
    # answer = Integer(gets.chomp)
    answer = answer.to_i

    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer > 4
      puts "The maximum is 4."
      return 4
    elsif answer < 1
      puts "The minimum is 1."
      return 1
    else
      return answer
    end
  end
end

def q_ante_size
  # loop until you get a good answer and return
  while true
    print "What's the ante size? "
    answer = gets.chomp
    if answer == ""
      return 10
    end
    # answer = Integer(gets.chomp)
    answer = answer.to_i

    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer > 1000
      puts "The maximum is 1000."
      return 4
    elsif answer < 1
      puts "The minimum is 1."
      return 1
    else
      return answer
    end
  end
end
