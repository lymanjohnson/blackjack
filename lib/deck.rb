# require_relative "card"

class Deck

  attr_accessor :cards , :discards

  def initialize(size)
    $visible_cards = [] # => Cards that are currently face up on the table
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

  # def deal_card
  #   @cards.shift
  # end

  # NOTE: only cards or arrays of cards should go in here
  # def put_back(arg)
  #   if arg.class == Array
  #     @cards.push(arg).flatten
  #   else
  #     @cards.push(arg)
  #   end
  # end

  def shuffle
    @cards.shuffle!
  end


end
