def q_hit_again?
  # loop until you get a good answer and return
  while true
    print "Do you want to (h)it or (s)tand? "
    answer = gets.chomp.downcase
    if answer[0] == "h" || answer == "hit"
      return true
    elsif answer[0] == "s" || answer == "stand"
      return false
    end
    puts "That is not a valid answer!"
  end
end

def q_shoe_size?
  # loop until you get a good answer and return
  while true
    print "How many decks do you want to play with? [1-5]"
    answer = Integer(gets.chomp)
    if answer < 0
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
