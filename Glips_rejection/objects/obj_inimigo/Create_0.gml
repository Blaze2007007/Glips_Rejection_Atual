grv = 0.5 // Gravidade
movex = 0 // Movimento horizontal
vely = 0  // Velocidade vertical
dis_from_player = 0 // Distancia do jogador (usada para verificações)
my_dir = 0 // Direção do inimigo
state = ENEMYSTATES.IDLE // Definir a variável "state" como um dos estados do enumerador "ENEMYSTATES"
pode_mudar = false // Definir a variável "pode_mudar" como false (usada para definir se o inimigo pode ou não mudar a sua direção)
opcao = 0 // Opção(do programa) usada para definir a direção do inimigo  
count1 = 0 // 1º temporizador (usado para contar o tempo entre as mudanças de direção do inimigo)
count2 = 0 // 2º temporizador (usado para contar o tempo até ao proximo ataque do inimgo)
count3 = 0 // 3º temporizador (usado para contar o tempo até à morte do inimigo)
pode_atacar = true // Definir a variável "pode_atacar" como true (usada para definir se o inimigo pode ou não atacar o jogador, neste caso pode)
sprite_idle = spr_hollow_r // Definir o sprite "Idle" do inimigo
global.vida_inimigo = enemy_hp // Definir vida do inimigo para verificações nos ataques
facing = 0 //Para onde o inimigo está a olhar(-1 -> esquerda,0 -> frente, 1 -> direita )
global.count = 0 // temporizador

attaking = false // Boolean para verificação de ataque

depth = 101 // separação de camada entre outros objetos
sprite_ini_idle = spr_hollow_r // definição de sprite idle default dos inimigos
sprite_ini_moving = spr_hollow_r // definição de sprite de movimento default dos inimigos
sprite_ini_ataque = spr_hollow_ataque // definição de sprite de ataque default dos inimigos

if(enemy_id == 1) // Se o id do inimigo for igual a 3 troca os sprites para o respetivo inimigo
{
	sprite_ini_idle = spr_boomba
	sprite_ini_moving = spr_boomba_direita
	sprite_ini_ataque = spr_boomba_ataque_direita
}

function reset_enemy_to_spawn() 
{
    x = spawn_x;
    y = spawn_y;
    vely = 0;
    movex = 0;
    state = ENEMYSTATES.IDLE;
    global.vida_inimigo = spawn_hp;
    count1 = 0;
    count2 = 0;
    count3 = 0;
    pode_mudar = false;
    opcao = 0;
    
    // Reset sprite para idle
    if (enemy_id == 1) {
        sprite_index = sprite_ini_idle;
        image_xscale = 1.5;
    } else {
        sprite_index = sprite_ini_idle;
    }
}

enum ENEMYSTATES // Definir o enumerador com todos os estados do inimigo
{
	IDLE,      // Mover numa direção aleatória ou ficar parado
	ALERT,     // Perseguir o jogador
	ATTACKING, // Atacar o jogador
	HIT,	   // Ser atacado pelo jogador
	DEAD	   // Morrer
}

spawn_x = x;
spawn_y = y;
spawn_hp = enemy_hp;
