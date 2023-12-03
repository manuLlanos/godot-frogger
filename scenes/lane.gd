extends Node2D
class_name Lane

# This node should be placed right on the start position
# Vehicles will reset to that location upon leaving the screen

## Direction the vehicles on this lane will always follow
@export var direction: Vector2 = Vector2.LEFT
## The time in seconds between every move
@export var move_time: float = 0.5
