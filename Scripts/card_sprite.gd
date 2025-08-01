extends Sprite2D
class_name CardSprite
# Size of each card in pixels (adjust for your PNG)
@export var card_width: int = 50
@export var card_height: int = 70
@export var columns: int = 13

# Reference to the base AtlasTexture from the editor
@export var base_atlas: AtlasTexture

# The private copy of the AtlasTexture for THIS Sprite2D
var atlas_copy: AtlasTexture

func _ready():
	if base_atlas:
		# Make a private copy so changes don't affect other sprites
		self.atlas_copy = base_atlas.duplicate()
		self.texture = atlas_copy

func set_card(index: int):
	if not atlas_copy:
	# Make a private copy so changes don't affect other sprites
		self.atlas_copy = base_atlas.duplicate()
		self.texture = atlas_copy
	var col = index % columns
	var row = index / columns
	print("Sprite of ", Enums.index_to_text(index))

	self.texture.region = Rect2(
		col * card_width,
		row * card_height,
		card_width,
		card_height
	)
