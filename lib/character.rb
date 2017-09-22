class Character
  attr_accessor :name, :behavior, :ante_modifier, :money, :flavor_text, :description
  def initialize(name="Jack",behavior=:default,ante_modifier=1,money=10,flavor_text="Some guy.",description="A generic player")
    @name = name
    @behavior = behavior
    @ante_modifier = ante_modifier
    @money = money
    @flavor_text = flavor_text
    @description = description
  end
end

eddie = Character.new("Eddie O'Shea",:risky ,2,20,"Always quick with a joke and a laugh. The jokes are often repeated and his laugh seems forced, though. He keeps looking over his shoulder.","A normal player with a high tolerance for risk")
dougie = Character.new("Dougie Jones",:psychic,2,20,"A handsome man with dark hair and a sharp looking black suit. Moves slow and doesn't talk much. Loves coffee.", "A magical player who always knows what the next card is")
duchess = Character.new("The Duchess",:default,50,1000,"Her name is Bonnie or Bunny or Barbie or something, but everybody calls her Duchess.\nAn aging beauty, she seems to be here for the company and doesn't care too much when she leaves empty-handed.\nThey say she made her fortune as a wild gunslinging smuggler in her youth. There's a couple of drinks named after her.","A normal player with deep pockets and a loose hand")
kevin = Character.new("Kevin Keebler",:countscards,1,10,"MIT dropout.\nHe seems extremely focused on everyone else's cards.","A player whose strategy changes depending on what cards are out of play.")
tommy_robby_jason = Character.new("Tommy, Robbie, and Jason",:random ,1,10,"He has the face of a twelve-year old boy, but his mustache, comedically large nose, and thick glasses mean there's no way he could actually be a kid, even if his voice does sound like that of a small boy doing a Vin Diesel impression.Strangely proportioned, his feet and body seem to stir with extra limbs under his long trench coat.Pays in coins. Doesn't seem to know the rules.Often gets in heated arguments with his legs and torso.\nHe's a pretty cool guy.", "A player who plays randomly and bets wildly")

$characters = [eddie,duchess,tommy_robby_jason,dougie]
