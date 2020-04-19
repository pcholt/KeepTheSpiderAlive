extends Node
onready var label = $"../../Label"
onready var this = $"../hitbox_p"

var in_area = {}
var inventory = {}
signal inventory_change

func _on_hitbox_p_area_entered(area):
	if area.get_parent().name == "door" && inventory_contains("spider"):
		$"/root/Node2D/WinLabel".visible = true
		
	if inventory.has(area.get_parent().get_instance_id()):
		return
	in_area[area.get_parent().get_instance_id()] = area.get_parent()
	print_debug("enter " + str(in_area))
	return

func _process(delta):
	if Input.is_action_just_pressed("controller_get"):
		var hand = empty_hand()
		var node = closest_pickup(hand)
		if node && not in_area.empty():
			if not hand: hand = $"../r_hand"
			if node.get_parent() :
				node.get_parent().remove_child(node)
			hand.add_child(node)
			inventory[node.get_instance_id()] = node
			emit_signal("inventory_change", inventory)
			node.position = Vector2()
	if Input.is_action_just_pressed("controller_drop"):
		releaseFrom($"../r_hand")
		releaseFrom($"../l_hand")

func empty_hand():
	# Use right hand, unless full, in which case use left hand. 
	# If the left hand is full, don't do any pickupping
	var hand = $"../r_hand"
	if hand.get_child_count()>0:
		hand = $"../l_hand"
	if hand.get_child_count()>0:
		return null
	return hand
	
func closest_pickup(hand):
	for i in in_area:
		match in_area[i].name:
			"paper", "glass":
				if hand:
					return in_area[i]
			"spider":
				if inventory_contains("paper") && inventory_contains("glass"):
					moveInventoryToRightHand()
					return in_area[i]
	return null
	
func inventory_contains(s):
	for i in inventory:
		if inventory[i].name == s:
			return true
	return false
	
func releaseFrom(hand):	
	if hand:
		for c in hand.get_children():
			var t = c.global_position
			hand.remove_child(c)
			$"/root/Node2D".add_child(c)
			c.global_position = t + Vector2(0,4)
			inventory.erase(c.get_instance_id())
			emit_signal("inventory_change", inventory)

func moveInventoryToRightHand():
	for i in inventory:
		var element = inventory[i]
		element.get_parent().remove_child(element)
		$"../r_hand".add_child(element)

func _on_hitbox_p_area_exited(area):
	in_area.erase(area.get_parent().get_instance_id())
	print_debug("exit " + str(in_area))
	return
