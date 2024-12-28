extends CharacterBody2D

@onready var animate: AnimatedSprite2D = $AnimatedSprite2D

var speed = 60
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta: float) -> void:
	
	deal_with_damage()
	update_zombie_heathbar()
	
	if player_chase:
		var x = player.position.x - position.x
		var y = player.position.y - position.y
		if abs((player.position - position).length()) > 18:
			position+= (player.position - position)/speed
			if x<0:
				if abs(x)>abs(y):
					animate.play("walk_left")
				else:
					if y>0:
						animate.play("walk_down")
					elif y<0:
						animate.play("walk_up")
			elif x>0:
				if abs(x)>abs(y):
					animate.play("walk_right")
				else:
					if y>0:
						animate.play("walk_down")
					elif y<0:
						animate.play("walk_up")
		else:
			if x<0:
				if abs(x)>abs(y):
					animate.play("idle_left")
				else:
					if y>0:
						animate.play("idle_down")
					elif y<0:
						animate.play("idle_up")
			elif x>0:
				if abs(x)>abs(y):
					animate.play("idle_right")
				else:
					if y>0:
						animate.play("idle_down")
					elif y<0:
						animate.play("idle_up")
	else:
		animate.play("idle")

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
	
func zombie():
	pass




func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack:
		if can_take_damage==true:
			health = health - 20
			$HealthBar/Timer.start()
			$take_damage_cooldown.start()
			can_take_damage = false
			print("Slime health:" , health)
			if health<=0:
				self.queue_free()


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true


func update_zombie_heathbar():
	var healthbar = $HealthBar
	var damagebar = $HealthBar/damageBar
	
	healthbar.value = health
	
	if health>=100:
		damagebar.value = 100
		healthbar.visible = false
	else:
		healthbar.visible = true
