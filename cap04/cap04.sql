----------------------------------------------------------------- CAPÍTULO 04 ------------------------------------------------------------------------------
create table tcurso (
       cd_curso numeric (3) not null,
       nome varchar (100) not null,
       valor numeric (10),
       carga_horaria numeric (5),
       primary key (cd_curso)
)

insert into tcurso(cd_curso, nome, valor, carga_horaria) values (1, 'Pedro', 500, 200);
insert into tcurso(cd_curso, nome, valor, carga_horaria) values (2, 'Java', 1500, 2000);
insert into tcurso(cd_curso, nome, valor, carga_horaria) values (3, 'C', 3500, 5200);



CREATE TABLE TALUNO (
       CD_ALUNO NUMERIC(5) NOT NULL, 
       NOME VARCHAR (20) NOT NULL, 
       CIDADE VARCHAR(20), 
       CEP VARCHAR(20), 
       ESTADO VARCHAR(2),
       PRIMARY KEY (CD_ALUNO)
       )
INSERT INTO TALUNO (CD_ALUNO, NOME, CIDADE, CEP, ESTADO) VALUES (1, 'PEDRO', 'MARINGA', 87023018, 'PR')
INSERT INTO TALUNO (CD_ALUNO, NOME, CIDADE, CEP, ESTADO) VALUES (2, 'RENAN', 'CAMPO MOURAO', 27025028, 'PR')
INSERT INTO TALUNO (CD_ALUNO, NOME, CIDADE, CEP, ESTADO) VALUES (3, 'HENRIQUE', 'SAO PAULO', 32323018, 'sp')
INSERT INTO TALUNO (CD_ALUNO, NOME, CIDADE, CEP, ESTADO) VALUES (4, 'FULANO', 'TEREZINHA', 32123018, 'PA')

UPDATE TALUNO SET ESTADO = 'SP' WHERE CD_ALUNO = 3

ALTER TABLE TALUNO ADD SALARIO NUMERIC (8, 2)

UPDATE TALUNO SET SALARIO = 1200 WHERE CD_ALUNO = 4

SELECT * FROM TALUNO WHERE NOME != 'FULANO' AND NOME != 'RENAN' ORDER BY SALARIO ASC

ALTER TABLE TALUNO ADD NASCIMENTO DATE DEFAULT SYSDATE - 1000

select * from taluno where cd_aluno in (select a.cd_curso from tcurso a)
select * from taluno where cd_aluno not in (select a.cd_curso from tcurso a)

select * 

select * from tcurso where nome like 'P%'  --Traz apenas os registros que começar com P, lembrando que é case sensitive
select * from tcurso where nome like '%a%' --Traz todos os registros que contenham a letra a
select * from tcurso where nome like '%va' --Traz todos os registros que terminem com 'va'

alter table tcurso add pre_req integer
update tcurso set pre_req = 1 where cd_curso = 2
update tcurso set pre_req = 3 where cd_curso = 3
update tcurso set pre_req = 1 where cd_curso = 2

select * from tcurso where pre_req is null -- Traz os cursos sem pré requisitos
select * from tcurso where pre_req is not null --Traz os cursos com pré requisitos
select * from taluno
--Precedência de Operadores: (), AND, OR


FUNÇÕES
Single-row: Funções que operam em linhas únicas retornando um resultado p/ cada linha processada

select * from taluno

select cd_aluno || nome from taluno -- Concatena
select nome, initcap(nome) from taluno
select nome, instr(nome, 'r') from taluno
select nome, length(nome) from taluno
select nome, lower(nome) from taluno
select nome, upper(nome) from taluno

select cd_aluno, lpad(cd_aluno, 5, '0') from taluno --Preenche
select cd_aluno, rpad(cd_aluno, 5, '0') from taluno --Preenche
select salario, lpad(salario, 10, 'R$') from taluno

select nome, substr(nome, 2, 3) from taluno -- Substring, copia parte de um texto
select replace(upper(nome), 'R', '$') from taluno

--            atrib | de onde | qts unidades
select substr(nome, length(nome), 1) from taluno -- Selecionando a última letra com base no comprimento da string
select substr(nome, length(nome)-1, 1) from taluno -- Selecionando a penúltima letra com base no comprimento da string
select substr(nome, 3, length(nome)) from taluno -- Selecionando a partir da posição 3

select * from dual -- Tabela que não existe, dummy
select sysdate from dual

select 
round(45.92345, 2), -- Arredonda duas casas decimais
trunc(45.92945, 2),
mod(9, 5) as resto_divisao
from dual

-- OPERAÇÕES COM DATAS
select nascimento, sysdate  from taluno

select sysdate - nascimento from taluno 
select trunc(sysdate - nascimento) from taluno -- Dias
select sysdate, trunc(sysdate) from dual -- Hora fica 00:00:00, eliminando ela da consulta

select months_between(sysdate, sysdate - 90) as dif_mes from dual -- Diferença de meses entre datas
select add_months(sysdate, 5) as adiciona_mes_data from dual -- Adiciona meses a data atual

select next_day(sysdate, 'WEDNESDAY') as proxima_quarta_data from dual -- Traz a próxima quarta feira a partir da data da consulta
select last_day(sysdate) as ultimo_dia_mes from dual -- Traz o último dia do mês da data da consulta

select round(sysdate, 'month') as primeiro_dia_proximo_mes from dual -- Traz o primeiro dia do próximo mês a partir da data da consulta
select trunc(sysdate, 'month') as primeiro_dia_mes_atual from dual -- Traz o primeiro dia do mês atual da data da consulta


-- FORMATAÇÃO DE DATA
select sysdate, to_char(sysdate, 'DD/MM/YYYY') data from dual -- Retira as horas da consulta da data

select sysdate, to_char(sysdate, 'DD') as apenas_dia from dual -- Traz apenas o dia referente a data da consulta
select sysdate, to_char(sysdate, 'MM') as apenas_mes from dual
select sysdate, to_char(sysdate, 'YYYY') as apenas_ano from dual
select sysdate, to_char(sysdate, 'DD/MM') as data_e_mes from dual
select sysdate, to_char(sysdate, 'MM/YYYY') as mes_e_ano from dual

select sysdate, to_char(sysdate, 'MONTH') as nome_mes_atual from dual
select sysdate, to_char(sysdate, 'DAY') as nome_dia_atual from dual
select sysdate, to_char(sysdate, 'DY') as nome_dia_simplificado_atual from dual
select sysdate, to_char(sysdate, 'D') as numero_do_dia_dentro_da_semana_atual from dual

select to_char(sysdate, ' "Maringá", fmDAY ", " DD "de" fmMonth "de" YYYY ') from dual

select to_char(sysdate, 'HH24:MI') hora_min from dual
select to_char(sysdate, 'HH24:MI:SS') hora_min_seg from dual
select to_char(sysdate, 'DD/MM HH24:MI') data_hora_min from dual
select to_char(sysdate, 'DD/MM/YYYY HH24:MI:SS') data_hora_completo from dual

-- FORMATAÇÃO DE CAMPO COM CIFRÃO E CONCATENAÇÃO
select 'R$ ' || round(salario, 2) as salario from taluno


-- COMO LIDAR COM NULL : NVL , NVL2 ; Transforma null em 0.


-- TRABALHANDO COM IF
select * from taluno

select nome, estado,
       case
         when estado = 'PR' then 'Paranauêee'
         when estado = 'SP' or salario = 1200 then 'Azarado'
         else 'Outros'
       end as apelido
from taluno
