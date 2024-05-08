Lors de l'instalation de pg avec la commande "gem install pg" dans mon terminal, cela me sortait une erreur d'instalation du package.
J'ai alors fais mes recherche et ceci est un problème courant mais je n'ai pas été en mesure de la résoudre.

J'ai alors décider d'executer mon code depuis ma machine virtuelle Debian car j'ai réussi à y installer pg sans aucun soucis.
Le code s'execute alors sans soucis mais n'arrive pas à se connecter à la base de donnée et me sort l'erreur suivante :

"connection to server at "127.0.0.1", port 5432 failed: Connection refused
Is the server running on that host and accepting TCP/IP connections?"

Je suis en train d'essayer de régler le problème en faisant des recherches.

UPDATE : J'ai réussi à me connecter à la base de donnée et je suis en train d'essayer d'ajouter les données du fichier excel à la base de donnée.

Voici la nouvelle erreur sur laquelle je travaille :

connexion à la base de donnée réussi
./Projet.rb:24:in `exec': ERROR:  null value in column "orderid" of relation "orders" violates not-null constraint (PG::NotNullViolation)
DETAIL:  Failing row contains (null, null, 0, 0, name, Mouse).
        from ./Projet.rb:24:in `insert_data'
        from ./Projet.rb:79:in `<main>'
