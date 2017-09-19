Dir['./lib/*.rb'].each { |file| require file }
require 'pry'
#
# # puts "Thick cigarette smoke fills the casino hall, and yet still fails to hide the sharp odor of freon emanating from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."
#
puts 'Welcome'

game = Game.new
# $dealer.hands[0].cards[1] = $dealer.hands[0].cards[0] #to trigger insurance?

while game.on
  binding.pry
  game.play_round
end
