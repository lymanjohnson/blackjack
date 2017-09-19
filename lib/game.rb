# Dir["./*.rb"].each {|file| require file}
#
class Game
  attr_accessor :on, :play_round

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
      $players[0].name = 'Player'
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
    $resplit_aces = q_resplit_aces
    $double_after_split = q_double_after_split
    $offer_insurance = q_offer_insurance
    $max_split_hands = q_max_split_hands
  end

  def play_round
    # First ask if each player wants to play this round
    $players.each_with_index do |player, _i|
      player.get_dealt if player.money >= $ante_size
    end

    # Then deal the dealer
    $dealer.new_hand
    binding.pry

    # If the dealer shows an ace, ask everyone if they want insurance
    if $dealer.insurance?
      puts 'Dealer showing an ace. Do you want insurance?'
      $players.each_with_index do |player, _i|
        player.insurance?
      end
    end

    # Dealer checks for blackjack, revealing if so and paying out insurance as necessary
    if $dealer.score == :blackjack
      puts "Dealer hits blackjack! Insurance paid out and round ends."
      $players.each_with_index do |player, _i|
        player.money += player.insurance*2
        puts "#{player.name} gets #{player.insurance*2} back in insurance."
        player.hands.each do |hand|
          hand.im_done = true # => There should be only one hand at this point, but just in case...
          hand.wager = 0  # => To prevent accidental payout later. Might be unnecessary.
        end
      end
    else
      puts "Dealer does not have blackjack. Play continues..."
    end

    binding.pry

    # Then we go around and give each player their turn
    $players.each_with_index do |player, _i|
      player.my_turn
    end

    # Then the dealer plays his turn
    $dealer.my_turn

    # Then each player sees how they did and collects winnings if applicable
    $players.each_with_index do |player, _i|
      player.did_i_win
    end

    # Players and dealer discard their hands
    $dealer.discard_all_hands
    $players.each_with_index do |player, _i|
      player.discard_all_hands
    end

    # If it's time to shuffle the deck, do so.
    deck.shuffle if deck.shuffle?

    # Ask the player if they'd like to continue
    stop_game unless q_keep_playing
  end

  def stop_game
    puts "You leave the table with $#{money}."
    puts 'Goodbye'
    @on = false
  end
end
