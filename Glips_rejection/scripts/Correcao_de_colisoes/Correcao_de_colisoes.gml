function correcao_de_colisoes(colisao) {
    // Early exit se não houver colisão
    if (!place_meeting(x, y, colisao)) {
        return;
    }
    
    // Reduzido de 1000 para 100 - mais eficiente e igualmente eficaz
    var max_iterations = 100;
    
    // Verificação otimizada - ordem mais provável de colisão
    for (var _i = 1; _i <= max_iterations; _i++) {
        // Horizontal primeiro (mais comum)
        if (!place_meeting(x + _i, y, colisao)) { 
            x += _i; 
            return; 
        }
        if (!place_meeting(x - _i, y, colisao)) { 
            x -= _i; 
            return; 
        }
        
        // Vertical
        if (!place_meeting(x, y - _i, colisao)) { 
            y -= _i; 
            return; 
        }
        if (!place_meeting(x, y + _i, colisao)) { 
            y += _i; 
            return; 
        }
        
        // Diagonais (menos comuns, verificar por último)
        if (!place_meeting(x + _i, y - _i, colisao)) { 
            x += _i; y -= _i; 
            return; 
        }
        if (!place_meeting(x - _i, y - _i, colisao)) { 
            x -= _i; y -= _i; 
            return; 
        }
        if (!place_meeting(x + _i, y + _i, colisao)) { 
            x += _i; y += _i; 
            return; 
        }
        if (!place_meeting(x - _i, y + _i, colisao)) { 
            x -= _i; y += _i; 
            return; 
        }
    }
}