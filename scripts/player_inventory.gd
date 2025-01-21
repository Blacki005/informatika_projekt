extends Node

const NUM_INVENTORY_SLOTS = 12
const SlotClass = preload("res://scripts/slot.gd")
const ItemClass = preload("res://scripts/item.gd")

var inventory : Dictionary = {}
#	0: ["Computer", 1], #---> slot_index: [item_name, item_quantity]
#	10: ["Monitor", 1],
#	11: ["Mouse", 1]
#}

#add item_quantity of item_name in inventory
func add_item(item_name: String, item_quantity: int) -> bool:
	for item in inventory:
		if inventory[item][0] == item_name:
			#there already is this item type in inventory, try to add to it
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return true
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity -= able_to_add
	
	#item doesn't exist in inventory yet, add to an empty slot
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return true
	return false


#TODO: different skins for empty and full slots
func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_tree().get_first_node_in_group("user_interface").get_node("./inventory/GridContainer/Slot" + str(slot_index + 1))
	
	if slot == null:
		printerr("Error: Slot node not found!")
		return
	
	if slot.item != null:
		if new_quantity == 0:
			slot.remove_child(slot.item)
			return
		slot.item.set_item(item_name, new_quantity)
	else:
		slot.initialize_item(item_name, new_quantity)


func erase_item(slot):
	inventory.erase(slot.slot_index)


func remove_item(item_name : String, item_quantity : int) -> bool:
	for item in inventory:
		if inventory[item][0] == item_name:
			#item found, remove it as much as possible
			var able_to_remove = inventory[item][1]
			if able_to_remove >= item_quantity:
				#we can remove just from the one slot, no need ti find another
				inventory[item][1] -= item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return true
			else:
				item_quantity -= inventory[item][1]
				inventory[item][1] = 0
				update_slot_visual(item, inventory[item][0], inventory[item][1])
	#we werent able to remove enough
	return false


func add_item_to_empty_slot(item: ItemClass, slot: SlotClass) -> void:
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]


func add_item_quantity(slot: SlotClass, quantity_to_add: int) -> void:
	inventory[slot.slot_index][1] += quantity_to_add


func reset_inventory() -> void:
	inventory.clear()


func has_item(item_name : String) -> bool:
	for item in inventory:
		if inventory[item][0] == item_name:
			return true
	return false
