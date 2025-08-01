extends Node
class_name Enums

enum Suits {
	SPADE,
	DIAMD,
	CLUBS,
	HEART,
	NONE,
}

enum Ranks {
	ACE,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING
}

enum Cards {
	SPADE_ACE,
	SPADE_2,
	SPADE_3,
	SPADE_4,
	SPADE_5,
	SPADE_6,
	SPADE_7,
	SPADE_8,
	SPADE_9,
	SPADE_10,
	SPADE_JACK,
	SPADE_QUEEN,
	SPADE_KING,
	DIAMD_ACE,
	DIAMD_2,
	DIAMD_3,
	DIAMD_4,
	DIAMD_5,
	DIAMD_6,
	DIAMD_7,
	DIAMD_8,
	DIAMD_9,
	DIAMD_10,
	DIAMD_JACK,
	DIAMD_QUEEN,
	DIAMD_KING,
	CLUBS_ACE,
	CLUBS_2,
	CLUBS_3,
	CLUBS_4,
	CLUBS_5,
	CLUBS_6,
	CLUBS_7,
	CLUBS_8,
	CLUBS_9,
	CLUBS_10,
	CLUBS_JACK,
	CLUBS_QUEEN,
	CLUBS_KING,
	HEART_ACE,
	HEART_2,
	HEART_3,
	HEART_4,
	HEART_5,
	HEART_6,
	HEART_7,
	HEART_8,
	HEART_9,
	HEART_10,
	HEART_JACK,
	HEART_QUEEN,
	HEART_KING,
	JOKER,
	BACK,
}

static func index_to_text(index: int) -> String:
	var rank = index % 13
	@warning_ignore("integer_division") 
	var suit = index / 13
	var cardName = ""
	match rank:
		Ranks.ACE: 
			cardName = "Ace "
		Ranks.TWO, Ranks.THREE, Ranks.FOUR, Ranks.FIVE, Ranks.SIX, Ranks.SEVEN, Ranks.EIGHT, Ranks.NINE, Ranks.TEN:
			cardName = str(rank + 1) + " "
		Ranks.JACK:
			cardName = "Jack "
		Ranks.QUEEN:
			cardName = "Queen "
		Ranks.KING:
			cardName = "King "
	match suit:
		Suits.SPADE:
			cardName += "of Spades"
		Suits.DIAMD:
			cardName += "of Diamonds"
		Suits.CLUBS:
			cardName += "of Clubs"
		Suits.HEART:
			cardName += "of Hearts"
		Suits.NONE:
			if rank == 0:
				cardName = "JOKER"
			elif rank == 1:
				cardName = "Card Back"
	return cardName
