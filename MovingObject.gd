extends Area2D
class_name MovingObject

# PARENT SHOULD ALWAYS BE A LANE NODE

# TODO: make a generic vehicle class, and truck inherits from that
# (so we can make cars and vans later)

@onready var parent = get_parent()
@onready var MOVE_TIME: float = parent.move_time
@onready var direction: Vector2 = parent.direction

# TODO: since every vehicle on the lane will have the same speed
# move the timer to the parent (lane node), no need to have so many timers
# simply connect the signals via script when the object is created

var tween: Tween

func _ready():
	if not parent is Lane:
		push_error("ERROR CREATING TRUCK: parent is NOT a lane")
		queue_free()
	move()

func move():
	# TODO: figure out a way to make it smooth and still be able to reset
	tween = create_tween()
	
	tween.connect("finished", _on_tween_completed)
	
	tween.tween_property(self, "position",
	 position  + direction * Globals.TILE_SIZE, MOVE_TIME)
	#position += direction * Globals.TILE_SIZE

func _on_tween_completed():
	move()

#position is relative to its parent, so simply make it zero
func _on_visible_on_screen_notifier_2d_screen_exited():
	tween.stop()
	position.x = 0
	move()

