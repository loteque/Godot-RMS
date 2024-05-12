extends Resource

# A single instance to contain a single resource
class_name ResourceContainer

var res_type: ResourceType
var max: int
var min: int = 0

var _current: int = 0

signal container_changed(res_container: ResourceContainer, count: int)
signal container_max_reached(res_container: ResourceContainer)
signal container_min_reached(res_container: ResourceContainer)

func _init(res_type: ResourceType):
	self.res_type = res_type

func add(amount: int) -> bool:
	if _current + amount > max:
		emit_signal("container_max_reached", self)
		return false
	_current += amount
	emit_signal("container_changed", self, _current)
	return true

func remove(amount: int) -> bool:
	if _current - amount < min:
		emit_signal("container_min_reached", self)
		return false
	_current -= amount
	emit_signal("container_changed", self, _current)
	return true

func get_current() -> int:
	return _current

func get_resource_name() -> String:
	return res_type.name

func _on_max_reached() -> void:
	container_max_reached.emit(self)
	print("Maximum resource limit reached")

func _on_min_reached() -> void:
	container_min_reached.emit(self)
	print("Minimum resource limit reached")

func is_full() -> bool:
	return _current == max

func is_empty() -> bool:
	return _current == min

func can_add(amount: int) -> bool:
	return _current + amount <= max

func can_remove(amount: int) -> bool:
	return _current - amount >= min
