extends Label

var percent = 0

func _ready():
	pass

func _on_empty_visibility_changed():
	if visible:
		percent = 0

func _process(delta):
	if percent<100:
		percent += delta
		percent_visible = percent


func _on_paper_visibility_changed():
	if visible:
		percent = 0


func _on_glass_visibility_changed():
	if visible:
		percent = 0


func _on_spider_visibility_changed():
	if visible:
		percent = 0


func _on_paperandglass_visibility_changed():
	if visible:
		percent = 0
