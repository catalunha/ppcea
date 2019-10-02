### Preparar para exportar query
~~~
sqlite> .output stdout
sqlite> .output query01.txt
sqlite> .mode list
sqlite> select ....;
~~~
Diversas
~~~
# 
.schema <tabela>
# configuracoes
.show

~~~

~~~
sqlite> .header on
sqlite> .mode column
sqlite> pragma table_info('<tabela>');
~~~


## Tabelas

~~~
sqlite> .tables
auth_group                                
auth_group_permissions                    
auth_permission                           
auth_user                                 
auth_user_groups                          
auth_user_user_permissions                
django_admin_log                          
django_content_type                       
django_migrations                         
django_session                            
fluxus_variavel                           
infraestrutura_espaco                     
infraestrutura_espaco_servidores          
matrizcurricular_bibliografia             
matrizcurricular_conselhonacionaleducacao 
matrizcurricular_disciplina               
matrizcurricular_disciplina_cne           
matrizcurricular_disciplina_equivalente   
matrizcurricular_disciplina_mec           
matrizcurricular_disciplina_prerequisito  
matrizcurricular_disciplina_professor     
matrizcurricular_ementa                   
matrizcurricular_ementa_dependente        
matrizcurricular_equivalente              
matrizcurricular_ministerioeducacaocultura
matrizcurricular_ppc                      
painel_variavel                           
servidor_professor                        
servidor_tecnico 
~~~

### matrizcurricular_bibliografia
sqlite> pragma table_info('matrizcurricular_bibliografia');
cid         name        type        notnull     dflt_value  pk        
----------  ----------  ----------  ----------  ----------  ----------
0           id          integer     1                       1         
1           iduu        varchar(55  1                       0         
2           tipo        varchar(25  0                       0         
3           citacao     varchar(25  0                       0         
4           arquivo     varchar(10  0                       0         
5           disciplina  integer     1                       0         
6           dtCreate    datetime    1                       0         
7           dtUpdate    datetime    1                       0         
8           isbn_issn   varchar(25  0                       0         
9           quantidade  smallint u  0                       0         
10          uso         varchar(25  0                       0         
sqlite> 

### matrizcurricular_disciplina
~~~ 
sqlite> pragma table_info('matrizcurricular_disciplina');
cid         name        type        notnull     dflt_value  pk        
----------  ----------  ----------  ----------  ----------  ----------
0           id          integer     1                       1         
1           iduu        varchar(55  1                       0         
2           codigo      varchar(25  1                       0         
3           sigla       varchar(25  0                       0         
4           nome        varchar(25  1                       0         
5           ppc0        varchar(5)  0                       0         
6           periodo     varchar(5)  0                       0         
7           categoria   varchar(25  0                       0         
8           chteorica   smallint u  1                       0         
9           chpratica   smallint u  1                       0         
10          chtecnica   smallint u  1                       0         
11          chlab       smallint u  1                       0         
12          objetivo    text        1                       0         
13          ementa      text        1                       0         
14          requisito   text        1                       0         
15          bibliograf  text        1                       0         
16          dtCreate    datetime    1                       0         
17          dtUpdate    datetime    1                       0         
18          ppc_id      integer     0                       0         
sqlite> 
~~~

### matrizcurricular_ppc
~~~
sqlite> select * from matrizcurricular_ppc;
id          iduu                                  dtCreate                    dtUpdate                    nome      
----------  ------------------------------------  --------------------------  --------------------------  ----------
1           45f792f5-2003-4eff-aa8f-a52a737cbf70  2017-02-22 09:33:09.243180  2017-02-22 09:33:09.243248  2001-2    
2           40a278d1-ecdd-49af-88a4-b1fb8a9bb049  2017-02-22 09:33:14.656011  2017-02-22 09:33:14.656063  2007-1    
3           859c2fd5-0b72-444d-9bc0-dca77390c07c  2017-02-22 09:33:20.329844  2017-02-22 09:33:20.329904  20xx-x    
sqlite> 
~~~

### matrizcurricular_ementa

~~~
sqlite> pragma table_info('matrizcurricular_ementa');
cid         name        type        notnull     dflt_value  pk        
----------  ----------  ----------  ----------  ----------  ----------
0           id          integer     1                       1         
1           iduu        varchar(55  1                       0         
2           ordem       varchar(25  1                       0         
3           item        varchar(25  1                       0         
4           disciplina  integer     1                       0         
5           dtCreate    datetime    1                       0         
6           dtUpdate    datetime    1                       0         
7           tipo        varchar(25  0                       0         
8           subnivel_i  integer     0                       0         
sqlite> 
~~~

### matrizcurricular_disciplina_prerequisito
~~~
sqlite> pragma table_info('matrizcurricular_disciplina_prerequisito');
cid|name|type|notnull|dflt_value|pk
0|id|integer|1||1
1|from_disciplina_id|integer|1||0
2|to_disciplina_id|integer|1||0
~~~



### matrizcurricular_ementa_dependente
~~~
sqlite> pragma table_info('matrizcurricular_ementa_dependente');
cid|name|type|notnull|dflt_value|pk
0|id|integer|1||1
1|from_ementa_id|integer|1||0
2|to_ementa_id|integer|1||0
sqlite> 
~~~

## Query

### Query01
lista das bibliografias
~~~
sqlite> select bib.id,bib.tipo, bib.citacao,disc.id,disc.nome,bib.isbn_issn,bib.quantidade,bib.uso from matrizcurricular_bibliografia as bib, matrizcurricular_disciplina as disc where bib.disciplina_id=disc.id limit 10;
id          tipo        citacao                                                                                                                                 id          nome                                              isbn_issn          quantidade  uso       
----------  ----------  --------------------------------------------------------------------------------------------------------------------                    ----------  ------------------------------------------------  -----------------  ----------  ----------
1           livro       Cotrim, Ademaro A.M.B., 1939-. Instalações elétricas. 5ed. São Paulo. Pearson Pretice Hall. 2009. 08-10784. CDD 621.3192.  UFT00067178  135         Eletricidade aplicada e Instrumentação Ambiental  978-85-7605-208-1  10          basica    
2           livro       dasdasd asd                                                                                                                             104         Administração e Empreendedorismo                  11                 1           basica    
3           livro       Economia Ambiental - Gestão de custos e investimentos, 2011. Editora Del Rey.                                                           125         Economia Ambiental                                9788538401773      20          basica    
4           livro       Manual para Valoração de Recursos Naturais, Ronaldo Seroa da Mota, 1997                                                                 125         Economia Ambiental                                Não tem            0           basica    
5           livro       Sano, S.M.; Almeida, S.P.; Ribeiro, J.F. (eds). Cerrado, Ecologia e Flora. Editora, Volume 1. Embrapa, Brasília, DF. 406p. 2008.        96          Caracterização Ambiental I                        978-85-7383-397-3  10          basica    
6           livro       Ricklefs, R.E. A Economia da Natureza. Editora Guanabara Koogan, Rio de Janeiro, RJ, sétima edição. 503p. 2016                          96          Caracterização Ambiental I                        9788527729628      10          basica    
7           livro       Cullen Jr., L.; Rudran, R.; Valladares-Pádua, C. (orgs). Métodos de Estudos em Biologia da Conservação e Manejo da Vida Silvestre. Edi  96          Caracterização Ambiental I                        978-8573351743     5           basica    
8           livro       Odum, E.P. Fundamentos em Ecologia. Fundação  Calouste Gulbenkian. Lisboa, Portugal, sétima edição. 928p. 2004.                         96          Caracterização Ambiental I                        9789723101584      5           basica    
9           livro       Cain, M.; Bowman, W.D.; Hacker, S.D. Ecologia. Artmed Editora. Porto Alegre, RS. 644p. 2011.                                            96          Caracterização Ambiental I                        9788536325477      5           basica    
10          livro       Townsend, C.R.; Begon, M. Harper, J.L. Fundamentos em Ecologia. Artmed Editora. Porto Alegre, RS. 576p. 2010                            96          Caracterização Ambiental I                        9788536320649      2           complement
sqlite> 

~~~
### Query01b
lista das bibliografias por disciplina
~~~
sqlite> select bib.id,bib.tipo, bib.citacao,disc.id,disc.nome,bib.isbn_issn,bib.quantidade,bib.uso from matrizcurricular_bibliografia as bib, matrizcurricular_disciplina as disc where bib.disciplina_id=disc.id and disc.id=125 limit 10;
id          tipo        citacao                                                                        id          nome                isbn_issn      quantidade  uso       
----------  ----------  -----------------------------------------------------------------------------  ----------  ------------------  -------------  ----------  ----------
3           livro       Economia Ambiental - Gestão de custos e investimentos, 2011. Editora Del Rey.  125         Economia Ambiental  9788538401773  20          basica    
4           livro       Manual para Valoração de Recursos Naturais, Ronaldo Seroa da Mota, 1997        125         Economia Ambiental  Não tem        0           basica    
74          livro       Rossetti, José Paschoal, Introdução à Economia. Editora Atlas, 992 pg, 2003    125         Economia Ambiental  9788522434671  20          basica    
75          livro       Stiglitz, J. E. Introdução à Microeconomia. 2003                               125         Economia Ambiental  9788535210446  20          basica    
76          livro       Moraes, O. J. Economia Ambiental - Instrumentos Econômicos para o Desenvolvim  125         Economia Ambiental  9788579280030  20          complement
77          livro       Huberman, L. História da Riqueza do Homem. Editora LTC. 2010                   125         Economia Ambiental  9788521617341  20          complement
78          livro       Motta, R. S. Economia Ambiental. Editora FGV. 399 pg. 2008.                    125         Economia Ambiental  978-852250544  20          complement
79          livro       Hirschfeld, H. Engenharia Econômica e Analise de Custos. Editora Atlas. 519 p  125         Economia Ambiental  8522426627     20          basica    
sqlite> 


~~~


### Query02
Lista com as disciplinas

~~~
sqlite> select disc.id,disc.codigo,disc.sigla,disc.nome,disc.periodo,disc.categoria,disc.chteorica,disc.chpratica from matrizcurricular_disciplina as disc where ppc_id=3 order by disc.periodo limit 10;
id          codigo      sigla       nome         periodo     categoria   chteorica   chpratica 
----------  ----------  ----------  -----------  ----------  ----------  ----------  ----------
79          ENG103                  Cartografia              optativa    30          15        
101         CET104                  Geoprocessa              optativa    15          30        
107         CBI339                  Recursos En              optativa    30          15        
124         ENG111                  Noções Bási              optativa    60          0         
138         CAG277                  Avaliação e              optativa    30          0         
141         Nova009                 Física Do S              optativa    30          15        
145         Nova007                 Ecologia da              optativa    60          40        
147         Nova005                 Caracteriza              optativa    30          15        
148         Nova010                 Gerenciamen              optativa    30          15        
149         Nova017                 Tratamento               optativa    30          15        
~~~

### Query03
Lista das ementas por disciplina
~~~
sqlite> select ementa.ordem,ementa.item,ementa.disciplina_id,disc.nome,ementa.subnivel_id from matrizcurricular_ementa as ementa, matrizcurricular_disciplina as disc where ementa.disciplina_id=disc.id and ementa.disciplina_id=125 order by ementa.ordem;
ordem       item                           disciplina_id  nome                subnivel_id
----------  -----------------------------  -------------  ------------------  -----------
01          Conceitos básicos de economia  125            Economia Ambiental             
02          Conceitos de Microeconomia e   125            Economia Ambiental             
03          Economia de Mercado.           125            Economia Ambiental             
04          Engenharia Econômica.          125            Economia Ambiental             
05          Economia em meio ambiente.     125            Economia Ambiental             
06          Conceitos economicos para o D  125            Economia Ambiental             
07          Valor econômico do meio ambie  125            Economia Ambiental             
08          Tecnicas de valoração econômi  125            Economia Ambiental             
09          Princípio do Poluidor Usuário  125            Economia Ambiental             
10          Gestão Econômica do Meio Ambi  125            Economia Ambiental             
11          Instrumentos econômicos de ge  125            Economia Ambiental             
~~~

### Query04
Lista dos prereq por disciplina

~~~
sqlite> select pr.from_disciplina_id,discf.nome,pr.to_disciplina_id,disct.nome from matrizcurricular_disciplina_prerequisito as pr, matrizcurricular_disciplina as discf,matrizcurricular_disciplina as disct where pr.from_disciplina_id=discf.id and pr.to_disciplina_id=disct.id order by pr.from_disciplina_id limit 10;
from_disciplina_id|nome|to_disciplina_id|nome
6|Meteorologia e Climatologia|41|Probabilidade e Estatística
10|Saúde e Vigilância Ambiental|16|Química Ambiental
11|Sensoriamento Remoto|59|Cartografia
13|Solos|42|Geologia
14|Sistemas de Gestão Ambiental|17|Avaliação de Impactos Ambientais
16|Química Ambiental|8|Química Geral
17|Avaliação de Impactos Ambientais|60|Caracterização Ambiental I
17|Avaliação de Impactos Ambientais|61|Caracterização Ambiental II
18|Tratamento de Efluentes|65|Processos e Operações Unitárias aplicados na Engenharia Ambiental
19|Análise de Impactos Ambientais|17|Avaliação de Impactos Ambientais
sqlite> 

~~~

### Query05
~~~
sqlite> select ementa.from_ementa_id,ementaf.item,ementa.to_ementa_id,ementat.item from matrizcurricular_ementa_dependente as ementa, matrizcurricular_ementa as ementaf, matrizcurricular_ementa as ementat where ementa.from_ementa_id=ementaf.id and ementa.to_ementa_id=ementat.id limit 10;
from_ementa_id|item|to_ementa_id|item
23|Gravitação|17|Leis de Newton
23|Gravitação|21|Lei de Conservação de energia
23|Gravitação|14|Grandezas físicas e vetoriais
32|Teoria cinética dos gases|17|Leis de Newton
32|Teoria cinética dos gases|20|Trabalho e energia
32|Teoria cinética dos gases|21|Lei de Conservação de energia
33|Entropia|20|Trabalho e energia
33|Entropia|21|Lei de Conservação de energia
24|Ondas em meios elásticos|16|Movimento circular e uniforme e variado
25|Ondas sonoras|16|Movimento circular e uniforme e variado
sqlite> 

~~~
