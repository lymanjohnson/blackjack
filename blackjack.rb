Dir["./lib/*.rb"].each {|file| require file}
require 'pry'

# puts "Thick cigarette smoke fills the casino hall, and yet still fails to hide the sharp odor of freon emanating from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."

puts "Welcome"

game_on = true
deck = Deck.new(1)
deck.shuffle

hand1 = Hand.new(deck)
puts "Hand 1: #{hand1.cards}"
hand2 = Hand.new(hand1)
puts "Hand 1: #{hand1.cards}, Hand 2: #{hand2.cards}"
puts
puts
# puts "Deck: #{deck.cards}"
# puts "Discard pile: #{deck.discards}"
#
# puts
# puts "Discarding hand1..."
# puts
# hand1.discard_hand_into(deck)
# puts "Discard pile: #{deck.discards}"
#
# puts
# puts "Discarding hand2..."
# puts
# hand2.discard_hand_into(deck)
# puts "Discard pile: #{deck.discards}"
#
# puts "#{deck.discards[0]}"


# 5.times do
#   hand = Hand.new(deck)
#   puts hand.cards
#   puts hand.score
#   puts
# end

binding.pry


while game_on

  game_on = false
  # ace = Card.new(:A,:spades)
  # q_hit_again?

end
