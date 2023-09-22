----------------------------------------------------------------- CAPÍTULO 05 ------------------------------------------------------------------------------
Obtendo dados através de diversas tabelas

select table1.column, table2.column
from table1, table2
where table1.column1 = table2.column2

O que é um join?
Utilize um join p/ consultar dados de mais de uma tabela.
   Escreva a condição de join na cláusula WHERE.
   Prefixe o nome da coluna com o nome da tabela quando o mesmo nome de coluna existir em mais de uma tabela.

    - EQUIJOIN
    
       A junção equijoin conecta duas ou mais tabelas de acordo com dados que são comuns a elas.
       Ou seja, procura por dados idênticos nas tabelas envolvidas.

    - NON-EQUIJOIN
    
       A junção non-equijoin procura por relacionamentos que NÃO correspondam a uma condição de igualdade, 
       são geralmente utilizados para verficar valores dentro de um certo conjunto de dados.
     
    - OUTER-JOINS
    
       Neste tipo de junção, temos como resultado dados existentes em uma tabela que não possuem uma condição de igualdade 
       com a outra. Ou seja, os registros da tabela que não tem registros de ligação são incluídos no resultado.

       Você pode utilizars um outer join p/ também visualizars as linhas que não correspondem a condição de join.
       
       O operador de outer join é o sinal de adição (+)

    - SELF JOINS
      
      Nas junções deste tipo são relacionados os dados de uma mesma tabela mais de uma vez, usando o mesmo raciocínio de uma
      equijoin, só que nesse caso com a própria tabela.


create table tcontrato(
       cd_contrato numeric(5) not null,
       data date,
       cd_aluno numeric(5) not null,
       total numeric(10),
       desconto numeric(10),
       primary key (cd_contrato)
)
select * from tcontrato
select * from taluno

insert into tcontrato  (cd_contrato, data, cd_aluno, total, desconto) values (4, sysdate + 17, 4, 155, 22)

select taluno.cd_aluno, taluno.nome, tcontrato.total from taluno, tcontrato -- Produto Cartesiano --> Errado!

select taluno.cd_aluno as cod_no_taluno, tcontrato.cd_aluno as cod_no_contrato, taluno.cd_aluno, taluno.nome, tcontrato.total 
from taluno, tcontrato
where tcontrato.cd_aluno = taluno.cd_aluno
order by total asc

-- Faz a mesma coisa que o select acima, porém bem menos verboso
select a1.cd_aluno, a2.cd_aluno, a2.nome, a1.total
from tcontrato a1, taluno a2
where  a1.cd_aluno = a2.cd_aluno 
order by total asc

-- Fazendo um select com 4 tabelas
create table titem(
       cd_item number(3),
       cd_curso number(3),
       cd_contrato number(3),
       valor number(10)
       )

select * from titem
insert into titem (cd_item, cd_curso, cd_contrato, valor) values (5, 1, 5, 500)

create table tdesconto(
       classe varchar(1) primary key,
       inferior number(4, 2),
       superior number(4, 2)
       )
       
insert into tdesconto values ('A', 00, 10);
insert into tdesconto values ('B', 11, 15);
insert into tdesconto values ('C', 16, 20);
insert into tdesconto values ('D', 21, 25);
insert into tdesconto values ('E', 26, 30);

select * from tdesconto
select * from tcontrato

select a1.cd_contrato, a2.classe from tcontrato a1, tdesconto a2 --> ERRADO! Produto Cartesiano

--Mostra os contratos cujos descontos aplicados na tabela tcontrato estão entre as classes definidas na tabela tdesconto
select a1.cd_contrato, a2.classe 
from tcontrato a1, tdesconto a2
where a1.desconto between a2.inferior and a2.superior 
order by cd_contrato asc

select * from tcurso
select * from titem

--Mostrar os cursos vendidos
select a1.cd_curso, a1.nome, a2.valor
from tcurso a1, titem a2
where a1.cd_curso = a2.cd_curso

--Mostrar os cursos não vendidos
select b1.cd_curso, b1.nome, b2.valor
from tcurso b1, titem b2
where b1.cd_curso = b2.cd_curso(+) -- (+) = outer join
and b2.cd_item is null
select * from tcurso

--Select de "duas tabelas" porém é a mesma tabela aka inner join
select c1.nome as curso, c2.nome as pre_requisito
from tcurso c1, tcurso c2
where c1.pre_req = c2.cd_curso(+) -- Retire o + para ver o que acontece
