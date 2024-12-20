extends ProgressBar

@onready var damage_bar: ProgressBar = $damagebar
@onready var timer: Timer = $Timer
# timer is used to display the effect of taking damage as the damagebar catches up with the healthbar after a time interval

var health = 0 : set = _set_health

# function to set the health displayed to the new value after taking damage
func _set_health(new_health):
	var initial_health = health  # saves initial health for comparison
	health = min(new_health,max_value)
	value = health
	
	if health<=0: # the healthbar dequeues if the player hits 0 health
		queue_free()
		print("You Died") # optional, can be replaced with the quueeing of a "u died" scene
	
	if health < initial_health:
		timer.start()
	else:
		damage_bar.value = health
				

func _init_health(_health): # instance of the healthbar to be used a child of the character
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health
	

func _on_timer_timeout() -> void: # catching up with the already receeded healthbar after timeout
	damage_bar.value = health
