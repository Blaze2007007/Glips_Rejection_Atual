arquivo_dados = "jogador_dados.json"; // criação de variável com o nome do arquivo que armazena os dados do jogador

if(!variable_global_exists("player_data") || !is_struct(global.player_data))
{
	global.player_data = Init_player_data() // Atribuição de valores iniciais do jogador
}
else
{
	global.player_data = load_player_data(arquivo_dados)
	
	// SEMPRE começar com vida cheia no início do jogo
	global.player_data.vida = 3;
	global.vida = 3; // Força a vida a ser sempre 3 no início
	
	global.pontos = global.player_data.pontos // Determina os pontos do jogador
	global.gamepaused = false // Variável utilizada para a verificação da pausa do jogo
	global.slime = global.player_data.slime // Determina qual o slime(personagem) a ser usado
	global.troca = false // Boolean para verificar se já se podem trocar os personagens
	global.dead = false // Boolean para verificação da morte (sempre vivo no início)
	global.ini1_morto = false // Boolean para verificação da morte do 1º inimigo
	global.ini2_morto = false // Boolean para verificação da morte do 2º inimigo
	global.ini3_morto = false // Boolean para verificação da morte do 3º inimigo
}
mensagem = true

count = 0 // definição de temporizador