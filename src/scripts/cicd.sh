#!/bin/bash

VERSION=1.0.0

DEP_DIR=$(dirname $0)


source $DEP_DIR/cicd-actions/job.sh
source $DEP_DIR/cicd-utils/usage.sh
source $DEP_DIR/cicd-utils/version.sh


case $1 in
  "job")
    shift
    job $* ;;
  "version" | "-version" | "--version" )
   version ;;
  "help")
    usage ;;
  *)
    echo "don't understand :( maybe read the help doc" ;;
esac


Mon but est de mettre en place un jeux de script shell permettant de faire du cicd en ligne de commande
Pour cela je vais avoir besoin d'un ensemble d'utilitaire. 
Pour commencer je doit pouvoir interpréter un fichier définissant un job. Je vais pour cela choisir le format clon
Il me faut donc un utilitaire permettant de requete ce genre de fichier 'clon'. Il prendra pour argument le fichier source ainsi qu'un pattern de recherche 
et imprimera sur la sortie standard la valeur de ce qui était recherché : 
  - clon build.clon "meta.version" => (version 1.0.0)
  - clon build.clon "meta.version" value => 1.0.0
Cicd peut aussi stocker des credentials dans un fichier privé, il va donc falloir disposé d'un utilitaire permettant de crypté ceux-ci, on prendra donc l'algorithme ARES pour ce faire
il prendra en argument la chaine à chiffrer et le mdp de chiffrement et retournera sur la sortie standard le résultat du chiffrement: 
 - ares "dmlqskdmqlsk" "mlsqkd" => "opixcand"
Il faudra ensuite stocker ce résultat dans un fichier aux accès restreint. 
Il faudra donc un utilitaire de gestion de credentials. On prendra le format clon encore une fois. 
 - clon credentials.clon "appli.password" set "opixcand" 
 - clon credentials.clon "appli.password" set $(ares "dmlqskdmqlsk" "mlsqkd")
Un job de base suit le format suivant : 
(job
  (meta 
    (version "1.0.0")
    (author "padget")
    (lastdate "12/10/2012")
    (name "build clon utilitary"))
  (steps  
    (run "make")
    (run "make compile")
    (run "make install")
    (archive 
      (files "dist/*")
      (algo "zip")))
  (credentials 
    (appl1 
      (login "Bob")
      (password "dankzjdn\==")
    (appl2 
      (login "Marcel") 
      (password "dqlkjdlijqzda=="))))


L'utilitaire clon doit pouvoir 
 - clon build.clon "steps.run" name => "run"
 - clon build.clon "steps.run" value => "make"
 - clon build.clon "steps.run:1" name => "run"
 - clon build.clon "steps.run:1" value => "make install"
 - clon build.clon "credentials.appl1.password" set "qpsodkqpdo==" => set the value in the file build.clon