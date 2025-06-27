if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || (mouse_check_button_pressed(mb_left) && instance_position(mouse_x, mouse_y, obj_menu)))
{
	// Limpar dados temporários
	if(instance_exists(obj_bg)) {
		obj_bg.image_alpha = 0;
	}
	instance_destroy(obj_menu);
	
	// Transição para menu principal - jogador destruído durante transição
	start_circle_transition(rm_inicio, -1, -1, true);
}