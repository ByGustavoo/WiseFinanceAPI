CREATE TABLE IF NOT EXISTS situacao_cadastro (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS bandeira (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS cartao (
    id SERIAL PRIMARY KEY,
    id_bandeira INT NOT NULL,
    ultimos_digitos VARCHAR(4) NOT NULL,
    id_situacaocadastro INT NOT NULL,
    FOREIGN KEY (id_bandeira) REFERENCES bandeira (id),
    FOREIGN KEY (id_situacaocadastro) REFERENCES situacao_cadastro(id)
);

CREATE TABLE IF NOT EXISTS usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    id_situacaocadastro INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_situacaocadastro) REFERENCES situacao_cadastro(id)
);

CREATE TABLE IF NOT EXISTS tipo_movimentacao (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS tipo_pagamento (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL
);

CREATE TABLE  IF NOT EXISTS tipo_categoria (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(30) NOT NULL,
    id_situacaocadastro INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_situacaocadastro) REFERENCES situacao_cadastro (id)
);

CREATE TABLE IF NOT EXISTS movimentacao (
    id SERIAL PRIMARY KEY,
    id_cartao INT NOT NULL,
    id_usuario INT NOT NULL,
    id_tipocategoria INT NOT NULL,
    id_tipopagamento INT NOT NULL,
    id_tipomovimentacao INT NOT NULL,
    numero_parcelas INT,
    valor_parcelas NUMERIC(10,2),
    valor_total NUMERIC(10,2) NOT NULL,
    data_movimentacao DATE DEFAULT CURRENT_DATE,
    observacao VARCHAR,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_tipocategoria) REFERENCES tipo_categoria(id),
    FOREIGN KEY (id_tipomovimentacao) REFERENCES tipo_movimentacao(id),
    FOREIGN KEY (id_tipopagamento) REFERENCES tipo_pagamento(id),
    FOREIGN KEY (id_cartao) REFERENCES cartao(id)
);

INSERT INTO situacao_cadastro (id, descricao) VALUES
(0, 'EXCLUIDO'),
(1, 'ATIVO');

INSERT INTO tipo_movimentacao (id, descricao) VALUES
(0, 'SAIDA'),
(1, 'ENTRADA');

INSERT INTO tipo_pagamento (descricao) VALUES
('PIX'),
('DINHEIRO'),
('CARTAO DE DEBITO'),
('VALE ALIMENTACAO'),
('CARTAO DE CREDITO');