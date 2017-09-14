puts "Hello and welcome to the game of blackjack! Let's begin."

def hit_again?
  # loop until you get a good answer and return
  while true
    print "Do you want to (h)it or (s)tand? "
    answer = gets.chomp.downcase
    if answer[0] == "h" || "H"
      return true
    elsif answer[0] == "s" || "S"
      return false
    end
    puts "That is not a valid answer!"
  end
end
