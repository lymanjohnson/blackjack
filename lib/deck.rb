# require_relative "card"

class Deck
  attr_accessor :cards, :discards

  def initialize(size)
    @visible_cards = [] # => Cards that are currently face up on the table
    @cards = []
    @discards = []
    size.times do
      Card::SUITS.each do |suit|
        Card::RANKS.each do |rank|
          @cards.push(Card.new(rank, suit))
        end
      end
    end
  end


  def cards_left
    @cards.length
  end

  def shuffle?
    @discards.length*4 > @cards.length
  end

  def shuffle
    @discards.each do |card|
      @cards.push(card)
    end
    @discards = []
    @cards.shuffle!
  end
end
