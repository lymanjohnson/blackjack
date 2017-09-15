# Player Types:
#  dealer: Behaves
#  human:
#  computer_nice:
#  computer_mean:

class Player

  attribute_accessor : cards

  def initialize(starting_cards)

    if starting_cards.class == Card
      @cards = [arg]
    elsif starting_cards.class == Array
      @cards = arg
    else
      @cards = []
    end
  end

  def clear_hand
    throw_away = @cards
    @cards = []
    return throw_away
  end

end
