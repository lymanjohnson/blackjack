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
      -
  - Loops through each player calling the Player.my_turn method each time
    - When player's turn is over it goes onto the next player
  -


Stand: Player stands pat with his cards.
Hit: Player draws another card (and more if he wishes). If this card causes the player's total points to exceed 21 (known as "breaking" or "busting") then he loses.
Double: Player doubles his bet and gets one, and only one, more card.
Split: If the player has a pair, or any two 10-point cards, then he may double his bet and separate his cards into two individual hands. The dealer will automatically give each card a second card. Then, the player may hit, stand, or double normally. However, when splitting aces, each ace gets only one card. Sometimes doubling after splitting is not allowed. If the player gets a ten and ace after splitting, then it counts as 21 points, not a blackjack. Usually the player may keep re-splitting up to a total of four hands. Sometimes re-splitting aces is not allowed.

----- CLASSES ------

Player:
  @name
  @hands [Hand] Note: an array of arrays, splitting allows multiple hands
  @score (0-21, :blackjack, or :bust)
  @money ($.$$ USD)
  @insurance ($.$$ USD)
  @wager ($.$$ USD)
  @im_done? (boolean)

  def my_turn
    i=0
    while !bust && !blackjack && !@im_done?
      Determine which choices are possible this round:
        Stand (always possible)
        Hit (always possible cuz if bust/bj you won't get to this loop)
        Double (possible only on first loop)
        Split (possible if @hand[j].length==2 and @hand[j][0] == @hand[j][1])
      <special AI behavior or player choice>
        - select choice from previous list
        - stand: im_done = true
        - hit: hit_me, i++
        - double: wager = wager*2 , im_done = true
    ends turn (which passes to next player)

  def insurance
    <special behavior>
      - set @insurance between 0 ... @wager

  def hit_me
    adds a card
    updates score

Game(number_of_decks,[Players],):
  @players = [Player]
  @shoe = [Deck].flatten => [cards]
  @visible_cards [cards]=> (current cards visible to everyone)
  @remembered_cards [cards]=> (cards not currently visible but seen since last shuffle)
  def round_ends
    (shuffle behavior goes here)
