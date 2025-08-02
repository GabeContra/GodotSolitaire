extends Control

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if !data is Card: 
		return false
	var cardData := data as Card
	return get_parent().check_legality(cardData)

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if !data is Card: 
		return
	var cardData := data as Card
	get_parent().add_enforced_card(cardData)
	get_parent().update_pile_sprites()
