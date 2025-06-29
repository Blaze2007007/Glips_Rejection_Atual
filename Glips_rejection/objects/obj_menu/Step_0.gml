if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || (mouse_check_button_pressed(mb_left) && instance_position(mouse_x, mouse_y, obj_menu)))// se se clicar no enter, no espaço ou com o rato no botão, executa-se o seguinte código
{
	// Usar transição específica para menu (game over) - sem posicionar jogador
	start_circle_transition_to_menu(rm_inicio);
	
	// Limpar alpha do background
	if(instance_exists(obj_bg)) {
		obj_bg.image_alpha = 0;
	}
	if(instance_exists(obj_sala_secreta_bg)) {
		obj_sala_secreta_bg.image_alpha = 0;
	}
	
	// Destruir este objeto
	instance_destroy(obj_menu);
}