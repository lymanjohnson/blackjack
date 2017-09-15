# Dir["./lib/*.rb"].each {|file| require file}

require './lib/input.rb'
require './lib/card.rb'
require './lib/deck.rb'
require './lib/hand.rb'
require './lib/player.rb'

puts "Thick cigarette smoke fills the casino hall, and yet fails to hide the sharp odor of freon emanating from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."

game_on = true

three_deck_shoe = Deck.new(2)
puts three_deck_shoe.cards

while game_on

  ace = Card.new(:A,:spades)
  # q_hit_again?

end
