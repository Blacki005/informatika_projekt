extends Panel

var ItemClass = preload("res://scenes/item.tscn")
var item = null
var slot_index : int

func _ready() -> void:
	refresh_style()


func pickFromSlot() -> void:
	remove_child(item)
	var inventoryNode = find_parent("inventory")
	if inventoryNode != null:
		inventoryNode.add_child(item)
		item = null
	refresh_style()


func putIntoSlot(new_item) -> void:
	item = new_item
	item.position = Vector2(0,0)
	var inventoryNode = find_parent("inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()


func initialize_item(item_name : String, item_quantity : int) -> void:
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
	refresh_style()


#TODO: refresh style of slot if its empty or full
func refresh_style():
	if item != null:
		self.tooltip_text = JsonData.item_data[item.item_name]["Description"]
	else:
		self.tooltip_text = ""
