// Código completo corrigido para obj_inimigo/Step_0.gml
// Obtém o ID do tilemap da camada "Tiles_2" para uso nas colisões
var _mapats = layer_tilemap_get_id("Tiles_2");

// Inicializa variáveis (mantém grv = 2 mas corrige os valores de salto)
grv = 2;
// Remove a reinicialização de vely e movex aqui para manter continuidade
if (vely == undefined) vely = 0;
if (movex == undefined) movex = 0;

// Se o jogo estiver pausado, cancela o movimento e sai do script
if(variable_global_exists("gamepaused"))
{
	if (global.gamepaused) {
	    movex = 0;
	    return;
	}
}
// Estrutura switch para controlar os comportamentos com base no estado do inimigo
switch (state) {
    case ENEMYSTATES.IDLE:
        // Estado de espera/repouso do inimigo
        count1++;

        // Controla se pode mudar de direção/ação
        if (pode_mudar) {
            pode_mudar = false;
            opcao = round(irandom(2));
        } else if (count1 == 120) {
            count1 = 0;
            pode_mudar = true;
        }

        // Sub-switch para tratar as diferentes opções de comportamento
         switch (opcao) {
            case 0: // Anda para a esquerda
                if (enemy_id == 1) {
                    sprite_index = spr_boomba_direita;
                    image_xscale = -1.5;
                }
                movex = -2;
                break;
            case 1: // Anda para a direita
                if (enemy_id == 1) {
                    sprite_index = spr_boomba_direita;
                    image_xscale = 1.5;
                }
                movex = 2;
                break;
            case 2: // Fica parado (idle)
                if (enemy_id == 1 && movex == 0) {
                    sprite_index = sprite_ini_idle;
                }
                movex = 0;
                break;
        }

        // Aplica movimento horizontal
        x += movex;

        // Altera o sprite se não for inimigo do tipo 1
        if (enemy_id != 1) {
            sprite_index = sprite_ini_moving;
        }

        // CORREÇÃO: Física vertical melhorada para saltos suaves
        if (place_meeting(x, y + 2, _mapats)) {
            // Está no chão - pode saltar se houver obstáculo à frente
            if (vely >= 0) vely = 0; // Só zera vely se não estiver subindo
            
            // Verifica se há obstáculo à frente para saltar (área menor e mais precisa)
            if (collision_rectangle(bbox_left - 5, y - 5, bbox_right + 5, y - 1, _mapats, false, false)) {
                vely = -15; // Valor de salto mais suave (era -50 * grv = -100)
            }
        } else {
            // Está no ar - aplica gravidade gradualmente
            vely += grv;
            if (vely > 15) vely = 15; // Limita velocidade de queda máxima
        }

        // Aplica movimento vertical
        y += vely;

        // Corrige colisões com o chão
        correcao_de_colisoes(_mapats);

        // Muda para estado ALERT se o jogador estiver próximo
        if (collision_circle(x, y, 224, obj_slime_pai, false, false)) {
            state = ENEMYSTATES.ALERT;
        }
        break;

    case ENEMYSTATES.ALERT:
        // Estado de alerta, o inimigo persegue o jogador
        if (!(alarm_get(0) > 0)) {
            if (!collision_circle(x, y, 224, obj_slime_pai, false, false)) {
                state = ENEMYSTATES.IDLE;
                break;
            }

            // CORREÇÃO: Perseguição melhorada - calcula distância ao jogador
            var dist_to_player = point_distance(x, y, obj_slime_pai.x, obj_slime_pai.y);
            
            // Direção em que deve mover para se aproximar do jogador
            var dist = point_direction(x, y, obj_slime_pai.x, obj_slime_pai.y);
            
            // CORREÇÃO: Move sempre em direção ao jogador até estar em range de ataque
            if (dist > 90) {
                my_dir = point_direction(x, y, obj_slime_pai.x + 50, obj_slime_pai.y);
                facing = 1;
                if (enemy_id == 1) image_xscale = -1.5;
            } else {
                my_dir = point_direction(x, y, obj_slime_pai.x - 50, obj_slime_pai.y);
                facing = -1;
                if (enemy_id == 1) image_xscale = 1.5;
            }

            // CORREÇÃO: Velocidade de movimento baseada na distância
            var move_speed = 3;
            if (dist_to_player < 10) {
                move_speed = 1; // Move mais devagar quando muito próximo
            } else if (dist_to_player < 32) {
                move_speed = 2; // Velocidade média quando próximo
            }

            // Movimento em direção ao jogador (sempre se move até estar em range de ataque)
            movex = lengthdir_x(move_speed, my_dir);
            x += movex;

            // CORREÇÃO: Física vertical melhorada no estado ALERT
            if (place_meeting(x, y + 2, _mapats)) {
                // Está no chão
                if (vely >= 0) vely = 0;
                
                // Verifica obstáculos para saltar (área otimizada)
                if (collision_rectangle(bbox_left - 10, y - 10, bbox_right + 10, y - 1, _mapats, false, false)) {
                    vely = -18; // Salto um pouco mais alto quando perseguindo (era -50 * grv)
                }
            } else {
                // Está no ar
                vely += grv;
                if (vely > 15) vely = 15;
            }

            // Aplica movimento vertical de forma mais suave
            y += vely;
            
            correcao_de_colisoes(_mapats);
            sprite_index = sprite_ini_moving;

            // CORREÇÃO: Entra em ataque quando está próximo o suficiente para atacar
            if (collision_circle(x, y, 32, obj_slime_pai, false, false)) {
                state = ENEMYSTATES.ATTACKING;
                count2 = 55; // CORREÇÃO: Inicia próximo do limite para atacar quase imediatamente
                if (enemy_id == 1) alarm_set(0, 90);
                attaking = true;
            } else {
                attaking = false;
            }

            // Se o jogador pressionar "E" próximo ao inimigo, entra em estado de HIT
            if (collision_circle(x, y, 64, obj_slime_pai, false, false) && keyboard_check_pressed(ord("E"))) {
                state = ENEMYSTATES.HIT;
            }
        } else if (enemy_id == 1) {
            // Inimigo em "tempo de espera" entre ataques
            movex = 0;
            sprite_index = sprite_ini_ataque;
        }
        break;

    case ENEMYSTATES.ATTACKING:
        // Estado de ataque ativo - CORREÇÃO COMPLETA
        
        // Para de se mover horizontalmente durante o ataque
        movex = 0;
        
        // Continua a aplicar física vertical (gravidade)
        if (place_meeting(x, y + 2, _mapats)) {
            if (vely >= 0) vely = 0;
        } else {
            vely += grv;
            if (vely > 15) vely = 15;
        }
        y += vely;
        correcao_de_colisoes(_mapats);
        
        // Sistema de ataque melhorado com temporizador individual
		if(variable_global_exists("vida") && variable_global_exists("dead"))
		{
			if (collision_circle(x, y, 32, obj_slime_pai, false, false) && global.vida > 0 && !global.dead) {
			    sprite_index = sprite_ini_ataque;
			    
			    // Incrementa o contador individual deste inimigo
			    count2++;
			    
			    // Ataca a cada 60 frames (1 segundo a 60fps)
			    if (count2 >= 60) {
					if(variable_global_exists("vida"))
					{
						if (!global.gamepaused) {
						    global.vida -= enemy_damage;
						}
					}
					count2 = 0; // Reinicia apenas o contador deste inimigo
			    }
			} else {
			    // Se o jogador saiu de alcance, volta a perseguir
			    count2 = 0; // Reinicia o contador ao sair do ataque
			    state = ENEMYSTATES.ALERT;
			}
		}
        // Pode ser atingido pelo jogador durante o ataque
        if (collision_circle(x, y, 64, obj_slime_pai, false, false) && keyboard_check_pressed(ord("E"))) {
            state = ENEMYSTATES.HIT;
        }
        break;

    case ENEMYSTATES.HIT:
        // Estado em que o inimigo está a ser atacado
        if (!collision_circle(x, y, 64, obj_slime_pai, false, false)) {
            state = ENEMYSTATES.ALERT;
        }

        if (collision_circle(x, y, 64, obj_slime_pai, false, false) && keyboard_check_pressed(ord("E")) && !global.dead) {
            global.vida_inimigo--; // Diminui a vida do inimigo
        }

        if (global.vida_inimigo == 0) {
            state = ENEMYSTATES.DEAD;
        }
        break;

    case ENEMYSTATES.DEAD:
        // Estado de morte
        if (global.vida_inimigo == 0) {
            // Marca inimigo como morto, dependendo do ID
			if (ini_id == 0) show_message("Tutorial completo!")
            if (ini_id == 1) global.ini1_morto = true;
            if (ini_id == 2) global.ini2_morto = true;
            if (ini_id == 3) global.ini3_morto = true;

            // Cria objetos de drop ao morrer
            for (var _i = 0; _i < enemy_drops; _i++) {
                var _random_pos = irandom(100);
                var _esc_dir = choose(0, 1);
                if (_esc_dir == 0) _random_pos = -_random_pos;
                instance_create_depth(x + _random_pos, y, depth, obj_drop);
            }
            
            instance_destroy(self); // Destroi o inimigo
        } else {
            state = ENEMYSTATES.IDLE;
        }
        break;
}