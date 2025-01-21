extends Control

const SlotClass = preload("res://scripts/slot.gd")
@onready var inventory_slots = $GridContainer #inventory slots are contained in grid container
var holding_item = null #item player is currently holding

func _ready() -> void:
	var slots = inventory_slots.get_children()
	#initialize slots and inventory
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
	initialize_inventory()


#is called whenever inventory is opened, refresh slots according to inventory array
func initialize_inventory() -> void:
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])


#handles mouse input on slots
func slot_gui_input(event: InputEvent, slot: SlotClass) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item: #place holding item to slot
					left_click_empty_slot(slot)
				else:
					if holding_item.item_name != slot.item.item_name: #different items, so swap
						left_click_different_item(event, slot)
					else: #same item, try to merge
						left_click_same_item(slot)
			elif slot.item:
				left_click_not_holding(slot)


#handles item movement with mouse when holding it
func _input(_event : InputEvent) -> void:
	if holding_item:
		holding_item.global_position = get_global_mouse_position()


#swap holding item with item in clicked slot
func left_click_different_item(event: InputEvent, slot: SlotClass) -> void:
	PlayerInventory.erase_item(slot)
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(holding_item)
	holding_item = temp_item


#add item to empty slot
func left_click_empty_slot(slot: SlotClass) -> void:
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	slot.putIntoSlot(holding_item)
	holding_item = null


#try to add holding item to clicked slot, keep the rest as holding
func left_click_same_item(slot: SlotClass) -> void:
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= holding_item.item_quantity:
		PlayerInventory.add_item_quantity(slot, holding_item.item_quantity)
		slot.item.add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free()
		holding_item = null
	else:
		PlayerInventory.add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add)
		holding_item.decrease_item_quantity(able_to_add)


#pick item from clicked slot
func left_click_not_holding(slot: SlotClass) -> void:
	PlayerInventory.erase_item(slot)
	holding_item = slot.item
	slot.pickFromSlot()
	holding_item.global_position = get_global_mouse_position()
