- [Script fera](#script-fera)
    - [Preparar para exportar query](#preparar-para-exportar-query)
- [](#)
- [configuracoes](#configuracoes)
  - [Tabelas](#tabelas)
    - [matrizcurricular_ppc](#matrizcurricularppc)
  - [Query](#query)
    - [Query01](#query01)
      - [matrizcurricular_bibliografia](#matrizcurricularbibliografia)
      - [lista das bibliografias](#lista-das-bibliografias)
      - [Script fera](#script-fera-1)
    - [Query02](#query02)
      - [matrizcurricular_disciplina](#matrizcurriculardisciplina)
      - [Script fera](#script-fera-2)
    - [Query03](#query03)
      - [matrizcurricular_ementa](#matrizcurricularementa)
      - [Script fera](#script-fera-3)
    - [Query04](#query04)
      - [matrizcurricular_disciplina_prerequisito](#matrizcurriculardisciplinaprerequisito)
      - [Script fera](#script-fera-4)



# Script fera
~~~
sqlite3 members.db "select bib.id,bib.tipo, bib.citacao,disc.id,disc.nome,bib.isbn_issn,bib.quantidade,bib.uso from matrizcurricular_bibliografia as bib, matrizcurricular_disciplina as disc where bib.disciplina_id=disc.id limit 10" | awk -F'|' '
   # sqlite output line - pick up fields and store in arrays
   cl{ id[++i]=$1; fname[i]=$2; gname[i]=$3; genderid[i]=$4 }

   END {
      printf "[\n";
      for(j=1;j<=i;j++){
         printf "  {\n"
         printf "    |id|:%d,\n",id[j]
         printf "    |fname|:|%s|,\n",fname[j]
         printf "    |gname|:|%s|,\n",gname[j]
         printf "    |genderid|:%d\n",genderid[j]
         closing="  },\n"
         if(j==i){closing="  }\n"}
         printf closing;
      }
      printf "]\n";
   }' | tr '|' '"'
~~~


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





## Query

### Query01

#### matrizcurricular_bibliografia
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

#### lista das bibliografias
~~~
sqlite> select bib.id,bib.disciplina_id,disc.nome,bib.tipo,bib.quantidade,bib.uso,bib.citacao,bib.isbn_issn from matrizcurricular_bibliografia as bib, matrizcurricular_disciplina as disc where bib.disciplina_id=disc.id limit 10;
id|tipo|id|nome|quantidade|uso|citacao|isbn_issn
1|livro|135|Eletricidade aplicada e Instrumentação Ambiental|10|basica|Cotrim, Ademaro A.M.B., 1939-. Instalações elétricas. 5ed. São Paulo. Pearson Pretice Hall. 2009. 08-10784. CDD 621.3192.  UFT00067178|978-85-7605-208-1
2|livro|104|Administração e Empreendedorismo|1|basica|dasdasd asd|11
3|livro|125|Economia Ambiental|20|basica|Economia Ambiental - Gestão de custos e investimentos, 2011. Editora Del Rey.|9788538401773
4|livro|125|Economia Ambiental|0|basica|Manual para Valoração de Recursos Naturais, Ronaldo Seroa da Mota, 1997|Não tem
5|livro|96|Caracterização Ambiental I|10|basica|Sano, S.M.; Almeida, S.P.; Ribeiro, J.F. (eds). Cerrado, Ecologia e Flora. Editora, Volume 1. Embrapa, Brasília, DF. 406p. 2008.|978-85-7383-397-3
6|livro|96|Caracterização Ambiental I|10|basica|Ricklefs, R.E. A Economia da Natureza. Editora Guanabara Koogan, Rio de Janeiro, RJ, sétima edição. 503p. 2016|9788527729628
7|livro|96|Caracterização Ambiental I|5|basica|Cullen Jr., L.; Rudran, R.; Valladares-Pádua, C. (orgs). Métodos de Estudos em Biologia da Conservação e Manejo da Vida Silvestre. Editora UFPR, segunda edição revisada. 652p. 2006.|978-8573351743
8|livro|96|Caracterização Ambiental I|5|basica|Odum, E.P. Fundamentos em Ecologia. Fundação  Calouste Gulbenkian. Lisboa, Portugal, sétima edição. 928p. 2004.|9789723101584
9|livro|96|Caracterização Ambiental I|5|basica|Cain, M.; Bowman, W.D.; Hacker, S.D. Ecologia. Artmed Editora. Porto Alegre, RS. 644p. 2011.|9788536325477
10|livro|96|Caracterização Ambiental I|2|complementar|Townsend, C.R.; Begon, M. Harper, J.L. Fundamentos em Ecologia. Artmed Editora. Porto Alegre, RS. 576p. 2010|9788536320649
~~~
#### Script fera
~~~
sqlite3 db.sqlite3 "select bib.id,bib.disciplina_id,disc.nome,bib.tipo,bib.quantidade,bib.uso,bib.citacao,bib.isbn_issn from matrizcurricular_bibliografia as bib, matrizcurricular_disciplina as disc where bib.disciplina_id=disc.id" | awk -F'|' '
   # sqlite output line - pick up fields and store in arrays
   { id[++i]=$1; disc_id[i]=$2; disc_nome[i]=$3; tipo[i]=$4; quantidade[i]=$5; uso[i]=$6; citacao[i]=$7; isbn_issn[i]=$8 }

   END {
      printf "[\n";
      for(j=1;j<=i;j++){
         printf "  {\n"
         printf "    |id|:%d,\n",id[j]
         printf "    |disc_id|:%d,\n",disc_id[j]
         printf "    |disc_nome|:|%s|,\n",disc_nome[j]
         printf "    |tipo|:|%s|,\n",tipo[j]
         printf "    |quantidade|:%d,\n",quantidade[j]
         printf "    |uso|:|%s|,\n",uso[j]
         printf "    |citacao|:|%s|,\n",citacao[j]
         printf "    |isbn_issn|:|%s|\n",isbn_issn[j]
         closing="  },\n"
         if(j==i){closing="  }\n"}
         printf closing;
      }
      printf "]\n";
   }' | tr '|' '"' > query01.json
~~~


### Query02

#### matrizcurricular_disciplina
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

Lista com as disciplinas

~~~
sqlite> select disc.id,disc.codigo,disc.nome,disc.periodo,disc.categoria,disc.chteorica,disc.chpratica from matrizcurricular_disciplina as disc where ppc_id=3 order by disc.periodo limit 10;
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

#### Script fera
~~~
sqlite3 db.sqlite3 "select disc.id,disc.codigo,disc.nome,disc.periodo,disc.categoria,disc.chteorica,disc.chpratica from matrizcurricular_disciplina as disc where ppc_id=3 order by disc.periodo" | awk -F'|' '
   # sqlite output line - pick up fields and store in arrays
   { field1[++i]=$1; field2[i]=$2; field3[i]=$3; field4[i]=$4; field5[i]=$5; field6[i]=$6; field7[i]=$7; }

   END {
      printf "[\n";
      for(j=1;j<=i;j++){
         printf "  {\n"
         printf "    |id|:%d,\n",field1[j]
         printf "    |codigo|:|%s|,\n",field2[j]
         printf "    |nome|:|%s|,\n",field3[j]
         printf "    |periodo|:%d,\n",field4[j]
         printf "    |categoria|:|%s|,\n",field5[j]
         printf "    |chteorica|:%d,\n",field6[j]
         printf "    |chpratica|:%d\n",field7[j]
         closing="  },\n"
         if(j==i){closing="  }\n"}
         printf closing;
      }
      printf "]\n";
   }' | tr '|' '"' > query02.json
~~~



### Query03

#### matrizcurricular_ementa

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

Lista das ementas por disciplina
~~~
select ementa.id,ementa.disciplina_id,disc.nome,ementa.ordem,ementa.item from matrizcurricular_ementa as ementa, matrizcurricular_disciplina as disc where ementa.disciplina_id=disc.id limit 10;
    
~~~

#### Script fera
~~~
sqlite3 db.sqlite3 "select ementa.id,ementa.disciplina_id,disc.nome,ementa.ordem,ementa.item from matrizcurricular_ementa as ementa, matrizcurricular_disciplina as disc where ementa.disciplina_id=disc.id" | awk -F'|' '
   # sqlite output line - pick up fields and store in arrays
   { field1[++i]=$1; field2[i]=$2; field3[i]=$3; field4[i]=$4; field5[i]=$5; }

   END {
      printf "[\n";
      for(j=1;j<=i;j++){
         printf "  {\n"
         printf "    |id|:%d,\n",field1[j]
         printf "    |disc_id|:%d,\n",field2[j]
         printf "    |disc_nome|:|%s|,\n",field3[j]
         printf "    |ordem|:%d,\n",field4[j]
         printf "    |item|:|%s|\n",field5[j]
         closing="  },\n"
         if(j==i){closing="  }\n"}
         printf closing;
      }
      printf "]\n";
   }' | tr '|' '"' > query03.json
~~~



### Query04


#### matrizcurricular_disciplina_prerequisito
~~~
sqlite> pragma table_info('matrizcurricular_disciplina_prerequisito');
cid|name|type|notnull|dflt_value|pk
0|id|integer|1||1
1|from_disciplina_id|integer|1||0
2|to_disciplina_id|integer|1||0
~~~


Lista dos prereq por disciplina

~~~
sqlite> select pr.id,pr.from_disciplina_id,discf.nome,pr.to_disciplina_id,disct.nome from matrizcurricular_disciplina_prerequisito as pr, matrizcurricular_disciplina as discf,matrizcurricular_disciplina as disct where pr.from_disciplina_id=discf.id and pr.to_disciplina_id=disct.id order by pr.from_disciplina_id limit 10;
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

#### Script fera
~~~
sqlite3 db.sqlite3 "select pr.id,pr.from_disciplina_id,discf.nome,pr.to_disciplina_id,disct.nome from matrizcurricular_disciplina_prerequisito as pr, matrizcurricular_disciplina as discf,matrizcurricular_disciplina as disct where pr.from_disciplina_id=discf.id and pr.to_disciplina_id=disct.id order by pr.from_disciplina_id" | awk -F'|' '
   # sqlite output line - pick up fields and store in arrays
   { field1[++i]=$1; field2[i]=$2; field3[i]=$3; field4[i]=$4;field5[i]=$5;}

   END {
      printf "[\n";
      for(j=1;j<=i;j++){
         printf "  {\n"
         printf "    |id|:%d,\n",field1[j]
         printf "    |disc_id|:%d,\n",field2[j]
         printf "    |disc_nome|:|%s|,\n",field3[j]
         printf "    |disc_prereq_id|:%d,\n",field4[j]
         printf "    |disc_prereq_nome|:|%s|\n",field5[j]
         closing="  },\n"
         if(j==i){closing="  }\n"}
         printf closing;
      }
      printf "]\n";
   }' | tr '|' '"' > query04.json
~~~