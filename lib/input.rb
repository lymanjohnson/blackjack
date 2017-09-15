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
