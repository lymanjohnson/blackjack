Dir['./lib/*.rb'].each { |file| require file }
require 'pry'
#
# # puts "Thick cigarette smoke fills the casino hall, and yet still fails to hide the sharp odor of freon emanating from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."
#
puts 'Welcome'

game = Game.new

while game.on
  $deck.shuffle
  game.play_round
end
