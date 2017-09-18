Dir["./lib/*.rb"].each {|file| require file}
require 'pry'
#
# # puts "Thick cigarette smoke fills the casino hall, and yet still fails to hide the sharp odor of freon emanating from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."
#
puts "Welcome"

# game_on = true
@@deck = Deck.new(1)
@@players = []
#
#
player1 = Player.new(:human)
@@players.push(player1)

player1.new_hand

binding.pry

# deck = Deck.new
# player = Player.new
# dealer = Dealer.new
#
#
#
# while game_on
#
#   player.new_hand(deck)
#   dealer.new_hand(deck)
#
#   player.my_turn
#   dealer.my_turn
#
#   deck.shuffle
#
#   if player.money <= 0 || player.im_done == true
#     game_on = false
#   end
#
# end
