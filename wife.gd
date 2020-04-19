extends Sprite

onready var navigation = $"../Navigation2D"
onready var spider = $"../spider"
onready var countdown = 1.0
onready var flyspray = $"../flyspray"

var inventory = {}
var intention
export var speed=30
var travelled = 0

func _process(delta):
	if countdown > 0:
		countdown -= delta
	else:
		countdown = 1
		if inventory.has(flyspray.get_instance_id()):
			if position.distance_squared_to(spider.position) < 2:
				$"/root/Node2D".queue_free()
			intention = navigation.get_simple_path(position, spider.position)
			travelled = 0
		else:
			var originalFlyspray = $"../flyspray"
			if originalFlyspray:
				if position.distance_squared_to(originalFlyspray.position) < 2:
					inventory[originalFlyspray.get_instance_id()] = true
					originalFlyspray.get_parent().remove_child(originalFlyspray)
					add_child(originalFlyspray)
					originalFlyspray.position = Vector2()
				else:
					intention = navigation.get_simple_path(position, originalFlyspray.position)
					travelled = 0
			$"../Line2D".points = intention
	
	travelled += delta * speed
	moveAlong(intention, travelled)

func moveAlong(intent, amount):
	var remaining = amount
	if intent:
		for point in intent:
			var dnext = position.distance_to(point)
			if dnext > remaining:
				position += position.direction_to(point) * remaining
				return
			position = point
			remaining -= dnext
			
