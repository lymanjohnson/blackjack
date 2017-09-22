# require_relative "card"

class Deck
  attr_accessor :cards, :discards, :visible_cards

  def initialize(size)
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

  def visible_cards
    visible = []
    # ###binding.pry
    $players.each do |player|
      # ###binding.pry
      player.hands.each do |hand|
        # ###binding.pry
        hand.cards.each do |card|
          # ###binding.pry
          visible.push(card)
        end
      end
    end
    $dealer_hand.cards.each do |card|
      visible.push(card)
    end
    visible.delete($hole_card)
    ###binding.pry
    visible
  end

  def cards_left
    @cards.length
  end

  def shuffle?
    @discards.length * 4 > @cards.length
  end

  def shuffle
    @discards.each do |card|
      @cards.push(card)
    end
    @discards = []
    @cards.shuffle!
  end
end
