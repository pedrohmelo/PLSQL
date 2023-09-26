----------------------------------------------------------------- CAPÍTULO 06 ------------------------------------------------------------------------------
select * from tcontrato 

select count(*) as qtde_registro,
       avg(total) as media,
       round(avg(total), 2) as media,
       max(total) as maximo,
       min(total) as minimo,
       sum(total) as soma,
from tcontrato

select max(cd_contrato) + 1 as proximo_codigo from tcontrato -- Próximo código sequencial da tabela

-- Total de contratos POR ALUNO
select cd_aluno, 
       sum(total) as soma_valor_contratos, 
       count(*) as qtde_de_contratos
from tcontrato
group by cd_aluno
order by cd_aluno asc

-- Total de contratos POR DATA
select to_char(trunc(data), 'DD/MM/YYYY') as data, -- Aqui retiro as horas da data para conseguir trabalhar com elas
       count(*) as qtde_de_contratos,
       sum(total) as valor_total,
       sum(desconto) as desconto_total
from tcontrato
group by trunc(data) -- SE NÃO COLOCAR O TRUNC NO GROUP BY ELE CONTINUA PEGANDO AS HORAS DA DATA!
order by to_char(trunc(data), 'DD/MM/YYYY') asc


select count(desconto) from tcontrato --- = 8

select * from tcontrato 

update tcontrato
set desconto = null
where cd_contrato = 7

select * from tcontrato 

select count(desconto) from tcontrato --- = 7 ; Pois COUNT não conta NULL

select * from taluno -- Temos 4 registros aqui
select count(distinct(estado)) from taluno -- Aqui contamos apenas 3 registros, pois estamos apenas pegando os registros distintos (e existem 2 estados PR)

-- Quantidade de registros por estado
select estado, count(*) from taluno group by estado

select sum(desconto), avg(desconto), count(desconto), round(avg(NVL(desconto, 0)), 2) from tcontrato; -- O nvl faz o seguinte nesse caso, se o atributo desconto for nulo, ele atribui a ele o valor 0

-- Quantidade de registros por ESTADO
select a1.estado, sum(a2.total) as total, count(*) as qtde
from taluno a1, tcontrato a2
where a1.cd_aluno = a2.cd_aluno -- critério de união entre as 2 tabelas
group by a1.estado
order by a1.estado 

-- Quantidade de registros por ESTADO E por DATA
select a1.estado, trunc(a2.data) as data, sum(a2.total) as total, count(*) as qtde
from taluno a1, tcontrato a2
where a1.cd_aluno = a2.cd_aluno -- critério de união entre as 2 tabelas
group by a1.estado , trunc(a2.data)
order by a1.estado, data desc

-- Para filtrar colunas que utilizam funções de grupo, ao invés de utilizar WHERE, nós utilizamos HAVING

--CASO ERRADO
select a1.cd_aluno, avg(a1.total)
from tcontrato a1
where avg(a1.total) > 200 -- Erro ocorre aqui
group by a1.cd_aluno

--CASO CORRETO
select a1.cd_aluno, avg(a1.total)
from tcontrato a1
where a1.cd_aluno > 0 -- Não serve pra nada esse where, só foi pra mostrar que é possível utilizar ambos juntos, mas o having é sempre após o where
having avg(a1.total) > 200
group by a1.cd_aluno

select max(avg(total))
from tcontrato a1
group by a1.cd_aluno

-- Soma dos salários por estado
select estado, sum(salario) as total
from taluno
group by estado
