def q_hit_again?
  # loop until you get a good answer and return
  while true
    print "Do you want to (h)it or (s)tand?  "
    answer = gets.chomp.downcase
    if answer[0] == "h" || answer == "hit"
      return true
    elsif answer[0] == "s" || answer == "stand"
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
      puts "That's too many decks"
    elsif answer == 0
      puts "You need at least one deck."
    else
      return answer
    end
    # puts "That is not a valid answer!"
  end
end


def q_money
  # loop until you get a good answer and return
  while true
    print "How much money are you bringing to the table?  "
    answer = Integer(gets.chomp)
    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer < 100
      puts "You need at least $100 if you're going to have any fun"
      return 100
    elsif answer > 1000000000
      puts "Any more than $1 billion is irresponsible..."
      return 1000000000
    else
      return answer
    end
  end
end

def q_name
  # loop until you get a good answer and return
  while true
    print "What's your name?  "
    answer = gets.chomp
    # unless answer.is_a?(Numeric)
    #   raise ArgumentError.new("Only numbers are allowed")
    # end
    if answer == nil
      puts "Nice to meet you, Player1"
      return "Player1"
    elsif answer.length > 20
      puts "Sorry, your name must be shorter than 20 characters."
    else
      puts "Nice to meet you, #{answer}"
      return answer
    end
  end
end
