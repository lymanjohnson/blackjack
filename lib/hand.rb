class Hand

  @cards
  @@dealer_score

  attr_accessor :cards

  def initialize(deck)
    @cards = []
    2.times do
      @cards.push(deck.cards.shift)
    end
  end

end
