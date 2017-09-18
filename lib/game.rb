# Dir["./*.rb"].each {|file| require file}
#
class Game

  attr_accessor :on

  def initialize
    @on = true
    $deck = Deck.new(1)
    $resplit_aces = true
    $double_after_split = true
    $offer_insurance = true
    $max_split_hands = 4
    $number_of_humans = q_number_of_humans
    $ante_size = q_ante_size

    if q_custom_rules
      custom_rules
    end

    $players = []

    #binding.pry
    $number_of_humans.times do
      #binding.pry
      add_player(:human)
      #binding.pry
      $players[-1].human_properties
    end
    # $dealer = Dealer.new
  end

  def add_player(character)
    #binding.pry
    newplayer = Player.new(character)
    #binding.pry
    newplayer_id = ":player#{($players.length)+1}"
    #binding.pry
    newplayer.player_id = newplayer_id.to_sym
    #binding.pry
    $players.push(newplayer)
    #binding.pry
  end

  def custom_rules
    $resplit_aces = q_resplit_aces
    $double_after_split = q_double_after_split
    $offer_insurance = q_offer_insurance
    $max_split_hands = q_max_split_hands
  end

  def end
    @on = false
  end

end
