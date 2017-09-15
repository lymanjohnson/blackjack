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
  Initialization
