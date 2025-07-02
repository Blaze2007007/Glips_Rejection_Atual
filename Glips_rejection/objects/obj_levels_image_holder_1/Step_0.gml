niv2 = global.player_data.niv2

if(niv2)
{
	image_index = 2
	if(ativa == false)
	{
		ativa = true
	}
}
else
{
	image_index = 0
}
if((keyboard_check_pressed(vk_enter) || (mouse_check_button_pressed(mb_left))) && (instance_position(mouse_x, mouse_y, obj_levels_image_holder_1) || global.escolha == 1) && image_index == 2)
{
	start_circle_transition(rm_nivel2, 165, 630);
	draw_set_color(c_black)
	draw_text_ext_transformed((camera_get_view_width(view_camera[0]) - 750) + 28,camera_get_view_height(view_camera[0]) - 450 + 128,global.pontos,0,10,1,1,0) // desenhar os pontos do jogador

}

// Resto do código permanece igual...
if(instance_position(mouse_x, mouse_y, obj_levels_image_holder_1) or global.escolha == 1)
{
	image_xscale = lerp(image_xscale,3.2,0.1)
	image_yscale = lerp(image_yscale,3.2,0.1)
	global.escolha = 1
}
else
{
	image_xscale = lerp(image_xscale,2.7,0.1)
	image_yscale = lerp(image_yscale,2.7,0.1)
}
if(keyboard_check_pressed(vk_tab) && global.escolha == 1)
{
	global.escolha = 2
	image_xscale = lerp(image_xscale,2.7,0.1)
	image_yscale = lerp(image_yscale,2.7,0.1)
	obj_levels_image_holder_2.aumentar = true
}
if(instance_position(mouse_x, mouse_y, obj_levels_image_holder) or instance_position(mouse_x, mouse_y, obj_levels_image_holder_2) && global.escolha == 1)
{
	image_xscale = lerp(image_xscale,2.7,0.1)
	image_yscale = lerp(image_yscale,2.7,0.1)
}