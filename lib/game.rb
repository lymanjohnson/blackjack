# Dir["./*.rb"].each {|file| require file}
#
class Game

  attr_accessor :on , :play_round

  def initialize
    @on = true
    $deck = Deck.new(1)
    $resplit_aces = true
    $double_after_split = true
    $offer_insurance = true
    $max_split_hands = 4
    $ante_size = 10
    $number_of_humans = 1
    $dealer = Dealer.new
    $players = []
    $quick_start = q_quick_start
    $play_round = play_round

    if $quick_start == false
      $number_of_humans = q_number_of_humans
      $ante_size = q_ante_size

      if q_custom_rules
        custom_rules
      end

      $number_of_humans.times do
        add_player(:human)
        $players[-1].human_properties
      end

    else
      add_player(:human)
      $players[0].name = "Player"
      $players[0].money = $ante_size*10
      $players[0].starting_money = $players[-1].money
      $players[0].new_hand
    end

  end

  def add_player(character)
        newplayer = Player.new(character)
        newplayer_id = ":player#{($players.length)+1}"
        newplayer.player_id = newplayer_id.to_sym
        $players.push(newplayer)
      end

  def custom_rules
    $resplit_aces = q_resplit_aces
    $double_after_split = q_double_after_split
    $offer_insurance = q_offer_insurance
    $max_split_hands = q_max_split_hands
  end

  def play_round
    # $dealer.new_hand
    if $dealer.insurance?
      puts "Dealer showing an ace. Do you want insurance?"
      $players.each_with_index do |player,i|
        player.insurance?
      end
    end

    $players.each_with_index do |player,i|
      if player.money >= $ante_size
        player.get_dealt
      end
    end

    $players.each_with_index do |player,i|
      player.my_turn
    end
  end

  def end
    @on = false
  end

end
