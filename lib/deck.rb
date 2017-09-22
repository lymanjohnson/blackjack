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
    # ##
    $players.each do |player|
      # ##
      player.hands.each do |hand|
        # ##
        hand.cards.each do |card|
          # ##
          visible.push(card)
        end
      end
    end
    $dealer_hand.cards.each do |card|
      visible.push(card)
    end
    visible.delete($hole_card)
    ##
    visible
  end

  def cards_left
    @cards.length
  end

  def shuffle?
    $shuffle_every_turn || @discards.length * 4 > @cards.length
    # if $shuffle_every_turn
    #   return true
    # else
    #   @discards.length * 4 > @cards.length
    # end
  end

  def shuffle
    @discards.each do |card|
      @cards.push(card)
    end
    @discards = []
    @cards.shuffle!
  end
end
