extends Area2D

enum PieceClass{Pawn, Rook, Knight, Bishop, Queen, King}
export var pieceType = PieceClass.Pawn	
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = pieceType
	pass # Replace with function body.
func movePiece(target: Vector2, speed: float):
	$Mover.stop_all()
	var currentPosition = self.position
	$Mover.interpolate_property(self, position, currentPosition, target, speed, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Mover.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
