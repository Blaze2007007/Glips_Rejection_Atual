if(keyboard_check_pressed(vk_escape) || (mouse_check_button_pressed(mb_left) && instance_position(mouse_x, mouse_y, obj_exit_levels))) 
{
	start_circle_transition(rm_inicio, -1, -1); // Voltar ao menu principal
}

// Resto do código permanece igual...
if(instance_position(mouse_x, mouse_y, obj_exit_levels))
{
	image_xscale = lerp(image_xscale,2.25,0.1)
	image_yscale = lerp(image_yscale,2.25,0.1)
}
else
{
	image_xscale = lerp(image_xscale,2,0.1)
	image_yscale = lerp(image_yscale,2,0.1)
}