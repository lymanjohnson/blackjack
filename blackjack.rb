puts "Thick cigarette smoke fills the room. It chokes your lungs and yet fails to hide the sharp odor of freon coming from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. You see some old familiars."



game_on = true

while game_on

end




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

def new_player?
  # loop until you get a good answer and return
  while true
    print "Do you want to (h)it or (s)tand? "
    answer = gets.chomp.downcase
    if answer[0] == "h" || "H"
      return :smo
    elsif answer[0] == "s" || "S"
      return false
    end
    puts "That is not a valid answer!"
  end
end
