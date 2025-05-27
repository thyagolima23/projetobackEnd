-- 1. Excluir banco (se existir)
DROP DATABASE IF EXISTS db_cantina;
DROP TABLE IF EXISTS public.votacao_tb;
DROP TABLE IF EXISTS public.prato_tb;
DROP TABLE IF EXISTS public.cozinheira_tb;

-- Depois disso, crie as tabelas normalmente

-- 2. Criar banco
CREATE DATABASE db_cantina;

-- A linha abaixo é específica do psql. Se estiver usando psql, mantenha-a.
-- Caso contrário, selecione o banco manualmente na ferramenta que estiver usando.
-- \c db_cantina

-- As próximas instruções devem ser executadas após conectar-se ao banco `db_cantina`.

-- Tabela de Cozinheiras
CREATE TABLE public.cozinheira_tb (
	id_usuario SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	senha VARCHAR(255) NOT NULL,
	CONSTRAINT cozinheira_tb_email_unique UNIQUE (email)
);

-- Tabela de Pratos
CREATE TABLE public.prato_tb (
	id_prato SERIAL PRIMARY KEY,
	dia DATE NOT NULL,
	turno VARCHAR(50) NOT NULL,
	principal VARCHAR(255) NOT NULL,
	sobremesa VARCHAR(255) NOT NULL,
	bebida VARCHAR(255) NOT NULL,
	imagem VARCHAR(255),
	id_usuario INT NOT NULL,
	CONSTRAINT prato_tb_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.cozinheira_tb(id_usuario)
	-- Se quiser garantir que um usuário só possa cadastrar um prato por dia e turno, descomente abaixo:
	-- ,CONSTRAINT prato_unico_dia_turno UNIQUE (id_usuario, dia, turno)
);

-- Tabela de Votação
CREATE TABLE public.votacao_tb (
	id_voto SERIAL PRIMARY KEY,
	id_prato INT NOT NULL,
	voto BOOLEAN NOT NULL,
	data_voto DATE NOT NULL,
	ip_usuario INET NOT NULL,
	CONSTRAINT votacao_tb_prato_fk FOREIGN KEY (id_prato) REFERENCES public.prato_tb(id_prato),
	-- Um IP só pode votar uma vez por prato:
	CONSTRAINT votacao_tb_unico_ip_prato UNIQUE (ip_usuario, id_prato)
);
