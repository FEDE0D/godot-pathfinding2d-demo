
extends RigidBody2D

export var speed = 200

# points in the path
var points = []

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	# refresh the points in the path
	points = get_node("../Navigation2D").get_simple_path(get_global_pos(), get_global_mouse_pos(), false)
	# if the path has more than one point
	if points.size() > 1:
		var direction = (points[1] - get_global_pos()).normalized() # direction of movement
		set_linear_velocity(direction*speed)
		update() # we update the node so it has to draw it self again

func _draw():
	# if there are points to draw
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)