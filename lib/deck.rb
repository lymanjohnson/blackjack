require_relative "card"

class Deck

  attr_accessor :cards

  def initialize(size)
    @cards = []
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

  def draw
    @cards.shift
  end

  def put_back(arg)
    if arg.class == Card
      @cards.push(arg)
    elsif arg.class == Array
      @cards.push(arg).flatten
    end
  end

  def shuffle
    @cards.shuffle!
  end
end
