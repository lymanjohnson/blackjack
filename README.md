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


----------

Game Loop
  - Initialization
  - Everyone gets a hand
  - If dealer's top card is ace, dealer offers insurance
    - loops through players, each decides whether to take insurance
    - if dealer's hand is blackjack:
      - 2*player.insurance goes back to each player.money
      -
  - Loops through each player calling the Player.my_turn method each time
  - When Players @turn-over?,





-----

Player:
  @hand [cards]
  @score (0-21, :blackjack, or :bust)
  @money ($.$$ USD)
  @insurance ($.$$ USD)
  @wager ($.$$ USD)
  @im_done? (boolean)

  def my_turn
    while !bust && !blackjack && !@im_done?
      <special behavior>
        - hit_me OR set im_done? = true
    passes to next player

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
