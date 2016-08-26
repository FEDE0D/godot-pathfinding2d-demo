
extends RigidBody2D

# travel speed in pixel/s
export var speed = 200

# at which distance to stop moving
# NOTE: setting this value too low might result in jerky movement near destination
const eps = 1.5

# points in the path
var points = []

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	# refresh the points in the path
	points = get_node("../Navigation2D").get_simple_path(get_global_pos(), get_global_mouse_pos(), false)
	# if the path has more than one point
	if points.size() > 1:
		var distance = points[1] - get_global_pos()
		var direction = distance.normalized() # direction of movement
		if distance.length() > eps or points.size() > 2:
			set_linear_velocity(direction*speed)
		else:
			set_linear_velocity(Vector2(0, 0)) # close enough - stop moving
		update() # we update the node so it has to draw it self again

func _draw():
	# if there are points to draw
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)