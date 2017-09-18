Game Class
  * Shoe Object
    - The big deck that is being used in the game. Array of cards, composed of integer multiples of standard decks.
    - Players draw/put cards from/into this deck.
    - It can be shuffled.
    - Visible cards:
      Array of cards that are visible to everyone at the table that haven't been shuffled back in. Clears when shuffled. Individual players will
  * Players:
    - An array of active players, each with their own hands and characteristics. What happens when its their turn, whether you see their cards.
    - Player Attributes:
      - Cards they have
      - Money
      - Cards they remember

  Initialization
    Shoe
      shoe size

    Players
      Dealer [abstract entity, not the player]:
        - How often he shuffles
        - Whether you see some/any of his cards
      Number of Players
        Behavior of each player
          Archetypes or Custom, determining:
            - When to hit/stay
            - When to leave the table
            - How much to bet and when
            - Whether they show cards
            - Starting money
            - Card counting??
        [There can be archetypes that make this quick]

    Minimum Ante at the Table


---- GAME LOOP ------

Game Loop
  - Initialization
  - Everyone gets a hand
  - If dealer's top card is ace, dealer offers insurance
    - loops through players, each decides whether to take insurance
    - if dealer's hand is blackjack:
      - 2*player.insurance goes back to each player.money

  - Loops through each player calling the Player.my_turn method each time
    - When player's turn is over it goes onto the next player
  - Dealer's card and score are announced
  - Loops through players hands and runs .did_i_win method, comparing hand to the dealer's
  - payouts are distributed
  - If player runs out of money the game ends
  - If an AI player runs out of money they leave the table

Stand: Player stands pat with his cards.
Hit: Player draws another card (and more if he wishes). If this card causes the player's total points to exceed 21 (known as "breaking" or "busting") then he loses.
Double: Player doubles his bet and gets one, and only one, more card.
Split: If the player has a pair, or any two 10-point cards, then he may double his bet and separate his cards into two individual hands. The dealer will automatically give each card a second card. Then, the player may hit, stand, or double normally. However, when splitting aces, each ace gets only one card. Sometimes doubling after splitting is not allowed. If the player gets a ten and ace after splitting, then it counts as 21 points, not a blackjack. Usually the player may keep re-splitting up to a total of four hands. Sometimes re-splitting aces is not allowed.

----- CLASSES ------

Hand:

  @cards = [card]  
  @score (0-21, :blackjack, or :bust)
  @im_done
  @turn_number
  @split_hand? = false

  def initialize

  def hand_turn
    i=0
    while !bust && !blackjack && !@im_done?
      Determine which choices are possible this round:
        Stand/Hit (always possible cuz if bust/blackj you won't get to this loop)
        Double (possible only on first loop)
        Split (possible if @cards.length==2 and @cards[0] == @cards[1])
        @cards.length==2 and @cards[0] == @cards[1]

      def turn_choice <special AI behavior or player choice>
        (select choice from previous list)
        - stand:
        - hit: hit_me, i++
        - double:
        - split:
    ends loop (which passes to next player)

  def settle
    compares @score to @@dealer_score


  def stand
    im_done = true

  def hit_me


  def decision
    <this is redefined for each type of player>

  def double
    wager = wager*2
    im_done = true

  def split


  TelepathicHand < Hand
  CardCountingHand < Hand
  DealerHand < Hand
  HumanHand < Hand


Player:


  @name
  @hands [Hand] Note: an array of arrays, splitting allows multiple hands
  @behavior = {}
  @money ($.$$ USD)
  @insurance ($.$$ USD)
  @wager ($.$$ USD)
  @im_done? (boolean)

  def new_hand(hand)
    hands.push(hand)
  end

  def initialize(name, money, type)
    @name = name
    @money = money
    new_hand(Hand.new(parent.deck))
  end

  def insurance
    <special behavior or player input>
      - set @insurance between 0 ... @wager    

  def player_turn
    goes through each hand and calls the hand_turn method on each one
    hand[i].hand_turn() (possibly feed behavior into the method??)

Game(number_of_decks,[Players],):
  @players = [Player]
  @shoe = [Deck].flatten => [cards]
  @visible_cards [cards]=> (current cards visible to everyone)
  @remembered_cards [cards]=> (cards not currently visible but seen since last shuffle)
  def round_ends
    (shuffle behavior goes here)
