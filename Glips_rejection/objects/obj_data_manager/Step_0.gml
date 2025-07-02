if(instance_exists(obj_slime_pai)) // se o objeto obj_slime_pai existir define as variáveis do jogador e armazena-as num ficheiro
{
	if(room == rm_tutorial)
	{
		obj_slime_pai.player_slime = 0
		
		if(variable_global_exists("vida"))
		    global.player_data.vida = int64(global.vida)
		if(variable_global_exists("pontos"))
		    global.player_data.pontos = int64(global.pontos)
	}
	else
	{
		// Atribuição de valores a armazenar de acordo com os valores do jogador
		if(variable_global_exists("vida"))
 		global.player_data.vida = int64(global.vida)
		if(variable_global_exists("pontos"))
 		global.player_data.pontos = int64(global.pontos)
		
 		global.player_data.posicao._x = int64(obj_slime_pai.x)
		global.player_data.posicao._y = int64(obj_slime_pai.y)
		if(variable_global_exists("slime"))
		global.player_data.slime = int64(global.slime)
		if(variable_global_exists("ini1_morto"))
		global.player_data.ini1_morto = global.ini1_morto
		if(variable_global_exists("ini2_morto"))
		global.player_data.ini2_morto = global.ini2_morto
		if(variable_global_exists("ini3_morto"))
		global.player_data.ini3_morto = global.ini3_morto
		if(variable_global_exists("troca"))
		global.player_data.conv_1 = global.troca
		save_player_data(global.player_data,arquivo_dados) //Armazenar os valores anteriores no ficheiro respetivo
	}
}
count ++ // incremento de temporizador
if(count == 180) // se o temporizador contar 3 segundos(180 frames) carregam-se os dados do jogador e o temporizador reinicia
{
	mensagem = true //Definir que será mostrada uma mensagem dos dados 
	count = 0 // reinicia a contagem
}
else // caso contrário não se mostrará a mensagem com os dados
{
	mensagem = false
}
if(room != rm_tutorial) 
{
    global.player_data = load_player_data(arquivo_dados) // Carrega os dados do ficheiro para a variável global player_data e de acordo com o código anterior mostra ou não os dados numa mensagem
}
