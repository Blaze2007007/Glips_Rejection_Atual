if(variable_global_exists("player_data"))
{
	if(global.player_data.niv2)
	{
		instance_destroy(obj_slimepegajoso)
		instance_destroy(obj_limite)
		obj_slime_pai.ativardialogo = false
		global.started = true
	}
}