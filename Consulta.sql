CREATE TABLE categorias(
	   categoriaId int AUTO_INCREMENT NOT NULL,
	   categoriaDescricao  varchar(30) NULL,
	   PRIMARY KEY (categoriaId)
);

CREATE TABLE produtos(
	produtoId int AUTO_INCREMENT NOT NULL,
	produtoNome varchar(60) NULL,
	produtoDescricao varchar(255) null,
	produtoValor decimal(18,5) default 0.00000 null,
	produtoQuantidade int DEFAULT 0 NULL,
	categoriaId int null,
	PRIMARY KEY (produtoId),
	CONSTRAINT FK_ProdutosCategorias 
	FOREIGN KEY (categoriaId) references categorias(categoriaId)
);

CREATE TABLE clientes(
	clienteId int AUTO_INCREMENT NOT NULL,
	clienteNome varchar(60) NULL,
	clienteCidade varchar(50) null,
	clienteUF varchar(2) NULL,
	PRIMARY KEY (clienteId)
);

CREATE table vendas (
  vendaId int AUTO_INCREMENT not null,
  clienteId int not null,
  dataVenda datetime,
  totalVenda decimal(18,5) DEFAULT 0,
  PRIMARY KEY (vendaId),
  CONSTRAINT FK_VendasClientes FOREIGN KEY (clienteId)
	REFERENCES clientes(clienteId)
);

CREATE table vendasitens (
  vendaId int AUTO_INCREMENT NOT NULL,
  produtoId int not null,
  itensValorUnitario decimal (18,5) default 0.00000,
  itensQuantidade decimal (18,5) default 0.00000,
  itensTotalProduto decimal (18,5) default 0.00000,
  PRIMARY KEY (vendaId,produtoId),
  CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (produtoId)
	REFERENCES produtos(produtoId)
);