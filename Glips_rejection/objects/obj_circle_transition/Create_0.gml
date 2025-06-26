// Configurações da transição circular
circle_radius = sqrt(power(display_get_gui_width()/2, 2) + power(display_get_gui_height()/2, 2)) + 50; // Começar com círculo GRANDE (tela visível)
min_radius = 0; // Raio mínimo (tela completamente preta)
max_radius = sqrt(power(display_get_gui_width()/2, 2) + power(display_get_gui_height()/2, 2)) + 50; // Raio que cobre toda a tela
radius_speed = 12; // Velocidade da transição (ajustável)

// Estados da transição
transitioning = false;
closing = true; // true = fechando círculo (escurecendo), false = abrindo círculo (clareando)
persistent = true; // IMPORTANTE: Manter o objeto entre mudanças de sala

// Informações da sala destino
target_room = -1;
target_x = 170; // Posição X onde o jogador aparece na nova sala
target_y = 600; // Posição Y onde o jogador aparece na nova sala

// Centro da transição (centro da tela)
center_x = display_get_gui_width() / 2;
center_y = display_get_gui_height() / 2;

// Surface para melhor performance na renderização
circle_surface = -1;