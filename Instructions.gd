extends Control


func _on_b_collision_monitor_player_inventory_change(inventory):
	$empty.visible = false
	$paper.visible = false
	$glass.visible = false
	$spider.visible = false
	$paperandglass.visible = false
	if inventory.empty():
		$empty.visible = true
		return
	if inventory_contains(inventory, "spider"):
		$spider.visible = true
		return
	if inventory_contains(inventory, "glass"):
		if inventory_contains(inventory, "paper"):
			$paperandglass.visible = true
			return
		else:
			$glass.visible = true
	if inventory_contains(inventory, "paper"):
		$paper.visible = true
		return
	
func inventory_contains(inventory, s):
	for i in inventory:
		if inventory[i].name == s:
			return true
	return false
	
