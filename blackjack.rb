Dir["./lib/*.rb"].each {|file| require file}
require 'pry'

# puts "Thick cigarette smoke fills the casino hall, and yet still fails to hide the sharp odor of freon emanating from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."

puts "Welcome"

game_on = true
@@deck = Deck.new(1)
@@players = []

# deck.shuffle

player1 = Player.new(:human)
@@players.push(player1)

pair2 = [Card.new(4,:hearts),Card.new(4,:spades)]
player1.new_hand(pair2)

binding.pry


while game_on

  game_on = false
  # ace = Card.new(:A,:spades)
  # q_hit_again?

end
