class Hand

  attribute_accessor : cards

  def initialize(arg)
    if arr.class == Card
      @cards = [arg]
    elsif arr.class == Array
      @cards = arg
    else
      @cards = []
    end
  end

  def clearHand
    throwAway = @cards
    @cards = []
    return throwAway
  end

end
