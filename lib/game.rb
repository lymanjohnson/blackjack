# Dir["./*.rb"].each {|file| require file}
#
class Game
  attr_accessor :on, :play_round , :stop_game

  def initialize
    @on = true
    $deck = Deck.new(1)
    $resplit_aces = true
    $hit_on_soft_seventeen = true
    $double_after_split = true
    $offer_insurance = true
    $max_split_hands = 4
    $ante_size = 10
    $number_of_humans = 1
    $dealer = Dealer.new
    $dealer.name = "The dealer"
    $players = []
    $discards_visible = true
  end

  def add_rules
    $quick_start = q_quick_start

    if $quick_start == false
      $number_of_humans = q_number_of_humans
      $ante_size = q_ante_size

      custom_rules if q_custom_rules

      $number_of_humans.times do
        add_player(:human)
        $players[-1].human_properties
      end

    else
      add_player(:human)
      $players[0].name = 'you'
      $players[0].money = $ante_size * 10
      $players[0].starting_money = $players[-1].money
      # $players[0].new_hand
    end
  end

  def add_player(character)

    newplayer = Player.new(character)
    newplayer_id = ":player#{$players.length + 1}"
    newplayer.player_id = newplayer_id.to_sym
    $players.push(newplayer)
  end

  def custom_rules
    $deck = Deck.new(q_shoe_size)
    $resplit_aces = q_resplit_aces
    $double_after_split = q_double_after_split
    $offer_insurance = q_offer_insurance
    $max_split_hands = q_max_split_hands
    $hit_on_soft_seventeen = q_hit_on_soft_seventeen
    $discards_visible = q_discards_visible
  end

  def play_round
    # First ask if each player wants to play this round
    # status_bar
    $players.each do |player|
      player.get_dealt if player.money >= $ante_size
    end

    # Then deal the dealer
    $dealer.new_hand

    # If the dealer shows an ace, ask everyone if they want insurance
    if $dealer.insurance?
      puts 'Dealer showing an ace. Do you want insurance?'
      $players.each do |player|
        player.insurance?
      end
    end

    # Dealer checks for blackjack, revealing if so and paying out insurance as necessary
    if $dealer_hand.score == :blackjack
      puts "Dealer hits blackjack! Insurance paid out and round ends."
      $players.each do |player|
        player.money += player.insurance*2
        puts "#{player.name} gets #{player.insurance*2} back in insurance."
        player.hands.each do |hand|
          hand.im_done = true # => There should be only one hand at this point, but just in case...
          hand.wager = 0  # => To prevent accidental payout later. Might be unnecessary.
        end
      end
    elsif $dealer_hand.score != :blackjack && $dealer.insurance?
      puts "Dealer does not have blackjack. Play continues..."
    end

    # Then we go around and give each player their turn
    $players.each do |player|
      player.my_turn
    end

    # Then the dealer plays his turn
    $dealer.my_turn

    # Then each player sees how they did and collects winnings if applicable
    $players.each do |player|
      player.did_i_win
    end

    # Players and dealer discard their hands
    $dealer.reset
    $players.each do |player|
      player.reset
    end

    # If it's time to shuffle the deck, do so.
    $deck.shuffle if $deck.shuffle?


  end

  def stop_game
    puts "You leave the table with $#{@money}."
    puts 'Goodbye'
    @on = false
  end
end
