extends Area2D

const TILE_SIZE: int = 32


@onready var current_pos: Vector2 = Vector2(position.x/TILE_SIZE, position.y/TILE_SIZE)
@onready var ray: RayCast2D = $RayCast2D

@onready var moving: bool = false
@onready var alive: bool = true

var animation_speed: float = 5.0


var inputs = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

# dont move diagonally, and only move on single inputs so we do = instead of +=
func _unhandled_input(event):
	if moving or not alive:
		return
	for dir: String in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * TILE_SIZE
	ray.force_raycast_update()
	if not ray.is_colliding():
		#position += inputs[dir] * TILE_SIZE
		var tween = create_tween()
		tween.tween_property(self, "position",
		 position + inputs[dir] * TILE_SIZE, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false

func hit():
	alive = false
	$AnimationPlayer.play("death")

func drown():
	$Particles/WaterSplash.emitting = true
	Sound.play("WaterSplash")
	hit()

func _on_body_entered(body):
	if body is TileMap and body.name == "Water":
		drown()
