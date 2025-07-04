function load_player_data(arquivo) {
    // Se o ficheiro existir, tentamos ler os dados
    if (file_exists(arquivo)) {
        var filer = file_text_open_read(arquivo);
        var dados_jsonr = file_text_read_string(filer);
        file_text_close(filer);

        // Se o ficheiro estiver vazio, cria-se conteúdo novo
        if (dados_jsonr == "") {
            show_debug_message("Ficheiro vazio detectado, a criar dados padrão");
            var dados_jsonw = json_stringify(Init_player_data());
            var filew = file_text_open_write(arquivo);
            file_text_write_string(filew, dados_jsonw);
            file_text_close(filew);

            // Reabrir para leitura dos dados criados
            filer = file_text_open_read(arquivo);
            dados_jsonr = file_text_read_string(filer);
            file_text_close(filer);
        }

        // Usar parsing seguro em vez de json_parse direto
        return safe_json_parse(dados_jsonr);
    } else {
        // Se o ficheiro não existir, criamos novo com dados padrão
        show_debug_message("Ficheiro não existe, a criar novo com dados padrão");
        var dados_iniciais = json_stringify(Init_player_data());
        var filew = file_text_open_write(arquivo);
        file_text_write_string(filew, dados_iniciais);
        file_text_close(filew);

        return Init_player_data(); // Retorna direto os dados padrão
    }
}