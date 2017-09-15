puts "Thick cigarette smoke fills the room. It chokes your lungs and yet does little to cut the dry scent of freon coming from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."

# Dougie Jones: Can see the next card and plays accordingly.
# Eddie O'Shea: Plays too riskily.
# The Dutchess: Plays like the dealer, has a lot of money and bets big.
# Shy Ronnie: Risk averse. Low tolerance.
# Tam Keebler: Counts cards.

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
