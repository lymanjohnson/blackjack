Dir["./lib/*.rb"].each {|file| require file}

puts "Thick cigarette smoke fills the casino hall, and yet fails to hide the sharp odor of freon emanating from above. The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars."



game_on = true
deck = Deck.new(1)
deck.shuffle
puts
5.times do
  hand = Hand.new(deck)
  puts hand.cards
  puts hand.score
  puts
end




while game_on


  # ace = Card.new(:A,:spades)
  # q_hit_again?

end
