CREATE TABLE public.cozinheira (
	id_cozinheira int NOT NULL,
	nome varchar(100) NOT NULL,
	email varchar NOT NULL,
	senha varchar NOT NULL,
	CONSTRAINT cozinheira_pk PRIMARY KEY (id_cozinheira),
	CONSTRAINT cozinheira_unique UNIQUE (senha)
);

CREATE TABLE public.cardapio (
	id_cardapio int NOT NULL,
	prato varchar(100) NOT NULL,
	turno varchar(50) NOT NULL,
	sobremesa varchar(100) NOT NULL,
	bebida varchar(50) NOT NULL,
	CONSTRAINT cardapio_pk PRIMARY KEY (id_cardapio)
);
