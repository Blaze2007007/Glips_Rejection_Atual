if((keyboard_check_pressed(vk_enter)|| (mouse_check_button_pressed(mb_left))) && (instance_position(mouse_x, mouse_y, obj_start) || global.opcao_escolhida == 0))
{
	global.vida = 3;
	global.player_data.vida = 3;
	global.dead = false; // Garantir que o jogador não está morto
	global.started = true; // marcar que o jogo começou
	start_circle_transition(rm_nivel1, 190, 446);
	
}

if(instance_position(mouse_x, mouse_y, obj_start) or global.opcao_escolhida == 0)
{
	image_xscale = lerp(image_xscale,2,0.1)
	image_yscale = lerp(image_yscale,2,0.1)
	global.opcao_escolhida = 0
}
else
{
	image_xscale = lerp(image_xscale,1.5,0.1)
	image_yscale = lerp(image_yscale,1.5,0.1)
}
if(keyboard_check_pressed(vk_tab) && global.opcao_escolhida == 0 && !aumentar)
{
	global.opcao_escolhida = 1
	image_xscale = lerp(image_xscale,1.5,0.1)
	image_yscale = lerp(image_yscale,1.5,0.1)
	aumentar = true
}
if(instance_position(mouse_x, mouse_y, obj_levels) or instance_position(mouse_x, mouse_y, obj_exit)  or instance_position(mouse_x, mouse_y, obj_tutorial) && global.opcao_escolhida == 0)
{
	image_xscale = lerp(image_xscale,1.5,0.1)
	image_yscale = lerp(image_yscale,1.5,0.1)
}
if(aumentar && global.opcao_escolhida == 0)
{
	aumentar = false
	image_xscale = lerp(image_xscale,2,0.1)
	image_yscale = lerp(image_yscale,2,0.1)
}