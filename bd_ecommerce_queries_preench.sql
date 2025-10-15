-- inserções de dados e queries 
use ecommerce;

show tables;

-- Clientes>:id_cliente, Fname, Mname , Lname, CPF_Cliente 11, País, Estado, Cidade, Bairro, Rua, CEP 7, Num_casa, Data_Nasc, 
-- Gênero enum('Feminino', 'Masculino') default ('Não declarado'), Num_telefone varchar(10) 
desc cliente;
insert into cliente(Fname, Mname, Lname, País, Estado, Cidade, Bairro, Rua, CEP, Num_casa, Data_Nasc, Gênero, Num_telefone)
	values('Luiza', 'T', 'Castilho', 'Brasil', 'São Paulo', 'São Paulo', 'Canadim', 'Rua Fleamaont','1234567','345', '1999-08-19','Feminino', '123654789' ),
		  ('Carlos', 'L', 'Ruint', 'Brasil', 'São Paulo', 'Juntinho', 'Prontin', 'Rua 675','1234567', '87', '2000-11-07', 'Masculino', '154899875'),
		  ('Julios', 'G', 'Jonas', 'Brasil', 'Rio Grande', 'Frontes ', 'Joaninha', 'Rua Carlos', '1234567', '23', '2000-10-01', 'Masculino', '4895762'),
          ('Amy', 'T', 'Fontes', 'Canada', 'Juntriy', 'Monstres', 'Hrtuon', 'Rua 90','1234567', '127','1987-09-22', 'Feminino', '5986422');

select * from cliente;

-- id_produto , Nome_produto, classificação_kids bool default false,categoria enum('Brinquedos', 'Eletrônicos', 'Vestimenta', 'Alimentos', 
-- 'Móveis', 'Livros') ,
 --  descrição varchar(200), avaliação float default 0, size varchar(10) default ('Não declarado'), Valor float NOT NULL
DELETE FROM produto where id_produto in (1,2,3,4);
INSERT INTO produto (Nome_produto, classificacao_kids, categoria, descricao, avaliacao, size, Valor)
VALUES
('Ferramentas', default, 'Móveis', 'Ferramentas para casa', 4, default, 45),
('Cama', default, 'Móveis', default, 2, default, 120),
('O apanhador', default, 'Livros', default, 5, default, 20),
('Boneca', true, 'Brinquedos', default, 5, default, 50);
SELECT * FROM produto;


-- pagamento: id pagamento, id_cliente, tipo  enum('Pix', 'Cartão Debito', 'Cartão crédito', 'Boleto'),
 -- Status_pagamento bool default 0,
insert into pagamento(id_cliente_pagamento, Tipo_pagamento, Status_pagamento)
	values(1,'Pix', 1),
		  (2, 'Cartaõ crédito',0),
          (3, 'Pix', 1),
          (4, 'Boleto', 1);
select * from pagamento;

--  pedido>:id_pedido, id_cliente_Pedido int, status_pedido ENUM('Em andamento', 
-- 'Peocessando', ' Enviado', 'Entregue') default ('Processando'),
-- Descrição_pedido varchar(200) ,frete float default 10,    
DELETE FROM pedido where id_cliente_Pedido in (1,2,3,4);
insert into pedido(id_cliente_Pedido, status_pedido, Descrição_pedido, frete, id_pagamento)
	values(3, 'Enviado', default, 5),
		  (2, 'Processando', default, 0),
          (4, default, default, 30),
          (1, 'Entregue', default, 8);
          
-- ADICIONANDO O ID_PAGAMENTO NA TABELA PEDIDO
UPDATE pedido SET id_pagamento = 1 WHERE id_cliente_Pedido = 1;

UPDATE pedido SET id_pagamento = 2 WHERE id_cliente_Pedido = 2;

UPDATE pedido SET id_pagamento = 3 WHERE id_cliente_Pedido = 3;

UPDATE pedido SET id_pagamento = 4 WHERE id_cliente_Pedido = 4;

SELECT *FROM PEDIDO;
select * from pagamento;

-- id_estoque, País varchar(20) NOT NULL, Estado varchar(20) NOT NULL, Cidade varchar(20) NOT NULL,
-- Bairro varchar(20) NOT NULL, Rua varchar(20) NOT NULL, Num_end_estq int NOT NULL, Quantidade int default 0
insert into estoque (País, Estado, Cidade, Bairro, Rua, Num_end_estq)
	values('Alemanha', 'TREUH', 'HAKLN', 'FAKTYU', 'Rua NHAUYT', 34),
		  ('Brasil', 'Rio de Janeiro', 'GRAPI', 'Gionduva', 'Rua gloria', 234);


-- fornecedor( razão_social_fornecedor varchar(20) NOT NULL,CNPJ_forne char(14) NOT NULL,
-- Contato_fornecedor char(11) NOT NULL,
insert into fornecedor(razão_social_fornecedor, CNPJ_forne, Contato_fornecedor)
	values('Carmes de sol', '45632415896521', '54896521456'),
           ('Prasmemp', '47584127851254', '48546215484'),
           ('HTML', '48564123541454', '45652846584');
           

-- vendedor(Razão_Social_vendedor , País , Estado, Cidade, Bairro , Rua , Num_end_vendedor ,
-- Nome_Fantasia , CNPJ_vend char(14), CPF_vend char(9), contato_vend char(11) 
insert into vendedor(Razão_Social_vendedor, País, Estado, Cidade, Bairro, Rua,Num_end_vendedor, Nome_Fantasia, CNPJ_vend, CPF_vend, contato_vend)
	values('Lucas Livros', 'Estados Unidos', 'Oregin', 'Las Vegas', 'DinaMar', 'Rua cirt', 234, null, NULL, '156456632', '89748995632'),
		  ('Johan Moveis', 'Brasil', 'Flanos', 'GIRIBIA', 'GUIN','Rua hyu', 345, NULL,null, '278394876', '25665487456');
          

--  produto_has_estoque(id_produto_has int, id_estq_has int, Quantidade int,
select*from produto;
insert into produto_has_estoque(id_produto_has, id_estq_has, Quantidade)
	values(6,2, 26),
		  (5,1,500),
		  (7,2, 4),
		  (8,1,125);


-- produto_por_pedido(id_produto_por int, id_pedido_por int, quantidade_ped int NOT NULL, status_prod enum('Disponível','Sem estoque') default 'Disponível',
insert into produto_por_pedido(id_produto_por,id_pedido_por, quantidade_ped, status_prod)
	values(6,25,1, default),
		  (5,26, 2, default),
          (8,27,5, default),
          (7,28,2, default);
          
-- produto_por_vendedor(id_prod_vend int, id_vend_porvend int, quantidade_PERVEND int NOT NULL,
select * from fornecedor;
insert into produto_por_vendedor(id_prod_vend, id_vend_porvend, quantidade_PERVEND)
	VALUES(5 , 2, 1),
		  (6, 2, 1),
          (7, 1, 1),
          (8, 1, 1);
          
          
-- forn_dispo_prod(	id_fornecedor_dispo int,id_prod_dispo int,
insert into forn_dispo_prod(id_fornecedor_dispo, id_prod_dispo)
	values(4,5),
		  (4, 6),
          (6, 7),
          (6, 8);
          
          
-- insert into entrega id_entrega , data_entrega DATE, Status enum ('Pendente', 'Recebido') default('Pendente'),
-- Código_rastrei varchar (23), id_pedido int, id_pagamento int, id_cliente int,
insert into entrega(data_entrega, Status_entrega, Código_rastrei, id_pedido, id_pagamento, id_cliente)
	values('2025-10-02', 'Recebido', 'J89K56', 25, 3,3 ),
		  (default, default, '45t655',26,2,2),
          ('2025-09-28','Recebido','54T622', 27, 4, 4),
          ('2025-10-03','Recebido', '45s98d', 28, 1, 1);
          
          
          
          
-- 	QUERIES E PERGUNTAS

-- qual a quantidade de clientes
select count(*) from cliente;

-- clientes que fizeram um pedido
select * from cliente c, pedido p where c.id_cliente = p.id_cliente_Pedido;

select Fname, Lname, id_pedido, status_pedido from cliente c, pedido p where c.id_cliente = p.id_cliente_Pedido;

select concat(Fname,' ', Lname) as Clientes, id_pedido as Num_Pedido, status_pedido from cliente c, pedido p where c.id_cliente = p.id_cliente_Pedido;


-- Quantos pedidos foram feitos por cada cliente
select CONCAT(c.fname, ' ', c.lname) as Nome_Cliente, COUNT(p.id_pedido) as Total_Pedidos
from cliente c LEFT JOIN pedido p on c.id_cliente = p.id_cliente_Pedido
GROUP BY c.id_cliente, Nome_Cliente
ORDER BY Total_Pedidos DESC;


-- Algum vendedor também é forncedor - NÃO
select v.id_vendedor, v.Razão_Social_vendedor, v.CNPJ_vend, f.id_fornecedor, f.razão_social_fornecedor, f.CNPJ_forne
from vendedor v INNER JOIN fornecedor f ON v.CNPJ_vend = f.CNPJ_forne;

-- Relação de produtos, fornecedores e estoque 

select p.id_produto, p.Nome_produto,f.id_fornecedor, f.razão_social_fornecedor, e.id_estoque, e.País, e.Estado, e.Cidade, ph.Quantidade
from produto_has_estoque ph INNER JOIN produto p ON ph.id_produto_has = p.id_produto INNER JOIN estoque e ON ph.id_estq_has = e.id_estoque
INNER Join forn_dispo_prod fdp ON fdp.id_prod_dispo = p.id_produto inner join fornecedor f on fdp.id_fornecedor_dispo = f.id_fornecedor order by f.razão_social_fornecedor, p.Nome_produto;

-- Relação de nomes dos fornecedores e produtos 
select f.id_fornecedor, f.razão_social_fornecedor as Fornecedor, p.id_produto, p.Nome_produto as Produto from fornecedor f 
inner join forn_dispo_prod fdp on f.id_fornecedor = fdp.id_fornecedor_dispo inner join produto p on fdp.id_prod_dispo = p.id_produto 
order by f.razão_social_fornecedor, p.Nome_produto; 
