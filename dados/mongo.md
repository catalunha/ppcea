
catalunha@nb:~/projetos/ppcea/dados$ mongoimport --jsonArray -d ppcea2 -c bibliografia --file query01.json


https://www.youtube.com/watch?v=Y5X5rdzFScs&t=336s

db.createCollection("disciplina")
db.createCollection("bibliografia")
db.createCollection("ementa")
db.createCollection("prerequisito")

mongoimport --jsonArray -d ppcea1 -c disciplina --file disciplina.json
mongoimport --jsonArray -d ppcea1 -c bibliografia --file bibliografia.json
mongoimport --jsonArray -d ppcea1 -c ementa --file ementa.json
mongoimport --jsonArray -d ppcea1 -c prerequisito --file prerequisito.json
