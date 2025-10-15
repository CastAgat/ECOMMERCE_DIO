-- CRIAÇÃO DE BD PARA E-COMMERCE

create database ecommerce;
use ecommerce; 

-- criar tabela cliente
create table cliente(
	id_cliente 	int auto_increment primary key,
    Fname Varchar(15) NOT NULL,
    Mname Varchar(3),
    Lname Varchar(25) NOT NULL,
    CPF_Cliente char(11) NOT NULL,
    País Varchar(10) NOT NULL,
    Estado Varchar (15) NOT NULL,
    Cidade Varchar (15) NOT NULL,
    Bairro Varchar (25) NOT NULL,
    Rua Varchar (30) NOT NULL,
    CEP char(7) NOT NULL,
    Num_casa int NOT NULL,
    Data_Nasc date,
    Gênero enum('Feminino', 'Masculino') default ('Não declarado'),
    Num_telefone varchar(10) NOT NULL,
    constraint unique_CPF_client unique (CPF_Cliente)
    
);
alter table cliente auto_increment=1;

-- ciar tabela produto
-- size = dimensão
create table produto(
	id_produto int auto_increment primary key,
    Nome_produto varchar (40) NOT NULL,
    classificação_kids bool default false,
    categoria enum('Brinquedos', 'Eletrônicos', 'Vestimenta', 'Alimentos', 'Móveis', 'Livros') NOT NULL,
    descrição varchar(200),
    avaliação float default 0,
    size varchar(10) default ('Não declarado'),
    Valor float NOT NULL
    
);
alter table produto auto_increment=1;


-- criar tabela pagamento
create table pagamento(
 id_pagamento int auto_increment primary key,
 id_cliente_pagamento int,
 Tipo_pagamento enum('Pix', 'Cartão Debito', 'Cartão crédito', 'Boleto') NOT NULL,
 Status_pagamento bool default 0,
constraint fk_id_cliente_pagamento foreign key (id_cliente_pagamento) references cliente(id_cliente)
);
alter table pagamento auto_increment=1;

-- criar tabela pedido
create table pedido(
	id_pedido int auto_increment primary key,
    id_cliente_Pedido int,
    status_pedido ENUM('Em andamento', 'Peocessando', ' Enviado', 'Entregue') default ('Processando'),
    Descrição_pedido varchar(200),
    frete float default 10,    
    constraint fk_pedido_cliente foreign key (id_cliente_pedido) references cliente(id_cliente)
		on update cascade
);
 
 -- arruamando erros tabela pedido
 
 ALTER TABLE pedido
 Change column `status_pedido` status_pedido ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') default ('Processando');

ALTER TABLE pedido
Change column `Descrição_pedido` Descrição_pedido varchar(200) default '';


 -- ADICIONANDO O ID_PPAGAMENTO NA TABELA PEDIDO
alter table pedido
add COLUMN id_pagamento INT;

alter table pedido
add constraint fk_pagemento_pedido foreign key (id_pagamento) references pagamento(id_pagamento);

desc pedido;
alter table pedido auto_increment=1;

-- criar tabela estoque
create table estoque(
	id_estoque int auto_increment primary key,
    País varchar(20) NOT NULL,
    Estado varchar(20) NOT NULL,
    Cidade varchar(20) NOT NULL,
    Bairro varchar(20) NOT NULL,
    Rua varchar(20) NOT NULL,
    Num_end_estq int NOT NULL,
    Quantidade int default 0
);
alter table estoque auto_increment=1;

-- criar tabela fornecedor 
create table fornecedor(
	id_fornecedor int auto_increment primary key,
    razão_social_fornecedor varchar(20) NOT NULL,
    CNPJ_forne char(14) NOT NULL,
    Contato_fornecedor char(11) NOT NULL,
    constraint cnpj_fornec UNIQUE (CNPJ_forne)
);
alter table fornecedor auto_increment=1;

-- criar tabela vendedor 
create table vendedor(
	id_vendedor int auto_increment primary key,
    Razão_Social_vendedor varchar(40),
    País varchar(20) NOT NULL,
    Estado varchar(20) NOT NULL,
    Cidade varchar(20) NOT NULL,
    Bairro varchar(20) NOT NULL,
    Rua varchar(20) NOT NULL,
    Num_end_vendedor int NOT NULL,
    Nome_Fantasia varchar(30),  
    CNPJ_vend char(14),
    CPF_vend char(9),
    contato_vend char(11) NOT NULL,
    constraint cnpj_vendedor UNIQUE (CNPJ_vend),
    constraint cpf_vendedor UNIQUE (CPF_vend)
);
alter table vendedor auto_increment=1;


create table clientes_pj(
	id_cliente int,
	cnpj char(14),
	constraint fk_cliente foreign key (id_cliente) references cliente(id_cliente)
);

alter table clientes_pj add constraint unique_client_pj unique(cnpj);
alter table clientes_pj
change column `cnpj` cnpj char(14) NOT NULL;

create table clientes_cpf(
	id_cliente int,
    cpf char(11),
    constraint fk_cliente2 foreign key (id_cliente) references cliente(id_cliente)
);

alter table clientes_cpf add constraint unique_cliente_cpf unique(cpf);

alter table clientes_cpf
change column `cpf` cpf char(11) NOT null;


-- correção tableba cliente(remocação cpf)
insert into clientes_cpf (id_cliente, cpf) select id_cliente, CPF_Cliente 
from cliente where CPF_Cliente is not null;

alter table cliente drop column CPF_Cliente;


SELECT * FROM cliente;
desc cliente;

-- criar tabela entregas
create table entrega(
	id_entrega int auto_increment primary key,
    data_entrega DATE default ('Não entregue'),
    Status_entrega enum ('Pendente', 'Recebido') default('Pendente'),
    Código_rastrei varchar (23) NOT NULL,
    id_pedido int,
    id_pagamento int,
    id_cliente int,
    constraint fk_pedido_entregue foreign key (id_pedido) references pedido(id_pedido),
    constraint fk_pagamento_entregue foreign key (id_pagamento) references pagamento(id_pagamento),
    constraint fk_cliente_entregue foreign key (id_cliente) references cliente(id_cliente)
);

-- arrumando a tabela entrega, descobri que data não pode ter frase
alter table entrega
change column `data_entrega` data_entrega DATE default NULL;


-- CRIAR RELAÇÕES

-- criar table produto has estoque
drop table produto_has_estoque;
create table produto_has_estoque(
	id_produto_has int,
    id_estq_has int,
    Quantidade int,
    primary key (id_produto_has, id_estq_has),
	constraint fk_prod_vendido foreign key (id_produto_has) references produto(id_produto),
    constraint fk_prod_estoque foreign key (id_estq_has) references estoque(id_estoque)
);

-- criar table relação de produto por pedido
create table produto_por_pedido(
	id_produto_por int,
    id_pedido_por int,
    quantidade_ped int NOT NULL,
    status_prod enum('Disponível','Sem estoque') default 'Disponível',
    primary key (id_produto_por, id_pedido_por),
    constraint fk_produto_pedido foreign key (id_produto_por) references produto(id_produto),
    constraint fk_pedido_pedido foreign key (id_pedido_por) references pedido(id_pedido)
); 

-- criar table produto por vendedor
create table produto_por_vendedor(
	id_prod_vend int,
    id_vend_porvend int,
    quantidade_PERVEND int NOT NULL,
    primary key (id_prod_vend, id_vend_porvend),
    constraint fk_prod_vend foreign key (id_prod_vend) references produto(id_produto),
    constraint fk_vend_vend foreign key (id_vend_porvend) references vendedor(id_vendedor)
);

-- criar table produto forncedor
create table forn_dispo_prod(
	id_fornecedor_dispo int,
    id_prod_dispo int,
    primary key (id_fornecedor_dispo, id_prod_dispo),
    constraint fk_forn_dispo foreign key (id_fornecedor_dispo) references fornecedor(id_fornecedor),
    constraint fk_prod_dispo foreign key (id_prod_dispo) references produto(id_produto)    
);

show tables;



