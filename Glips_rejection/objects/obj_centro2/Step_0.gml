if(place_meeting(x,y,obj_slime_pai) && keyboard_check_pressed(ord("F"))) 
{
    // Verificar se já existe uma transição ativa
    if (!instance_exists(obj_circle_transition)) {
        // Iniciar transição - o jogador será destruído quando o círculo fechar completamente
        start_circle_transition(rm_inicio, -1, -1, true);
    }
}