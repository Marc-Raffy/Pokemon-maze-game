class Editeur {
  Niveau niv;
  Perso p;

  int typeElementCourant;

  boolean fini;
  boolean entree=true; //Necessaires pour tester si l'on peut sauvegarder
  boolean pikachu=true;
  boolean sortie=true;

  int[][] tabIA; //Necessaires pour l'IA le premier pour aller jusqu'a pikachu
  int[][] tabIA2;//et le deuxieme pour aller jusqu'a la sortie

  Editeur(String nomFichier) {
    p=new Perso();
    niv=new Niveau(nomFichier, jeuLabyrinthe.perso);
    niv.edition=true;
    typeElementCourant=0;
    fini=false;
    tabIA=new int[niv.nbrBlocsX][niv.nbrBlocsY]; //on initialise ces tableaux de la meme taille que le niveau
    tabIA2=new int[niv.nbrBlocsX][niv.nbrBlocsY];//de maniere a stocker les emplacements ou on est deja alles
  }

  void Afficher() {
    niv.Afficher(p);//On reutilise la fonction d'affichage du niveau
    switch(typeElementCourant) {  //On va afficher en bas a droite de la souris le bloc que l'on a selectionne
    case 0 :
      image(niv.neige, mouseX+15, mouseY+15, niv.tailleBloc*0.75, niv.tailleBloc*0.75);
      break;
    case 1 :
      image(niv.rocher, mouseX+15, mouseY+15, niv.tailleBloc*0.75, niv.tailleBloc*0.75);
      break;
    case 2 :
      image(niv.glace, mouseX+15, mouseY+15, niv.tailleBloc*0.75, niv.tailleBloc*0.75);
      break;
    case 3 :
      image(niv.entree, mouseX+15, mouseY+15, niv.tailleBloc*0.75, niv.tailleBloc*0.75);
      break;
    case 4 :
      image(niv.pikachu, mouseX+15, mouseY+15, niv.tailleBloc*0.75, niv.tailleBloc*0.75);
      break;
    case 6 :
      image(niv.sortie, mouseX+15, mouseY+15, niv.tailleBloc*0.75, niv.tailleBloc*0.75);
      break;
    }
    if (!pikachu||!sortie||!entree)//Si il manque un element on affiche a cote de la souris qu'il y a un probleme
    {
      fill(0);
      textSize(10);
      text("Manque entree ou sortie ou pikachu", mouseX-20, mouseY-20);
    }
  }

  void KeyPressed() {
    switch(key) { //Change le bloc selectionne selon  la touche sur laquelle on appuie
    case '&' :
      typeElementCourant=0;
      break;
    case 'é' :
      typeElementCourant=1;
      break;
    case '"' :
      typeElementCourant=2;
      break;
    case '\'' :
      typeElementCourant=3;
      break;
    case '(' :
      typeElementCourant=4;
      break;
    case '-' :
      typeElementCourant=6;
      break;
    case 's':  //Si on appuie sur s cela permet de sauvergarder
      Sauvegarder();
      break;
    case 'S' :
      Sauvegarder();
      break;
    }
  }

  void MiseAJour() {
    if (mousePressed)
    {
      switch(typeElementCourant) { //Si on essaie de placer une entree une sortie ou un pikachu on regarde si il y en a deja une
      case 3 :                     //Si c'est le cas on remplacera l'ancien bloc par de la neige
        for (int y=0; y<niv.nbrBlocsY; y++)
        {
          for (int x=0; x<niv.nbrBlocsX; x++)
          {
            if (niv.niveau[x][y]==3) {
              niv.niveau[x][y]=0;
            }
          }
        }
        break;

      case 4 :
        for (int y=0; y<niv.nbrBlocsY; y++)
        {
          for (int x=0; x<niv.nbrBlocsX; x++)
          {
            if (niv.niveau[x][y]==4) {
              niv.niveau[x][y]=0;
            }
          }
        }
        break;
      case 6 :
        for (int y=0; y<niv.nbrBlocsY; y++)
        {
          for (int x=0; x<niv.nbrBlocsX; x++)
          {
            if (niv.niveau[x][y]==6) {
              niv.niveau[x][y]=0;
            }
          }
        }
        break;
      }
      if (mouseX/niv.tailleBloc<niv.nbrBlocsX&&mouseY/niv.tailleBloc<niv.nbrBlocsY&&mouseX/niv.tailleBloc>=0&&mouseY/niv.tailleBloc>=0)//On verifie qu'on  ne sort pas du tableau et donc de la fenetre
        niv.niveau[mouseX/niv.tailleBloc][mouseY/niv.tailleBloc]=typeElementCourant;                                                    //On remplace le bloc courant par le bloc selectionne
      switch (typeElementCourant) {                                                                                                      //On utilise aussi une division entiere car cela nous donne bien le bloc sur lequel la souris se trouve

      case 3 :
        niv.entreeX=mouseX/niv.tailleBloc;//On modifie bien en permanence les coordonnes de la classe niveau de l'entree et du pikachu 
        niv.entreeY=mouseY/niv.tailleBloc;//car on s'en sert pour l'IA et on a besoin qu'elles soient mises a jour meme si le niveau ne s'enregistre pas afin de justement tester si il peut s'enregistrer
        break;

      case 4 :
        niv.pikachuX=mouseX/niv.tailleBloc;
        niv.pikachuY=mouseX/niv.tailleBloc;
        break;
      }
    }
  }

  void Sauvegarder() {
    entree=false;
    pikachu=false;
    sortie=false;
    for (int y=0; y<niv.nbrBlocsY; y++)//On parcourt le tableau
    {
      for (int x=0; x<niv.nbrBlocsX; x++)
      {
        switch (niv.niveau[x][y]) {//On verifie qu'il y a bien au moins un pikachu une entree et une sortie
          // et pas besoin de verifier si c'est >1 car cela est verifie dans la mise a jour au dessus
        case 3 :
          entree=true;
          break;

        case 4 :
          pikachu=true;
          break;

        case 6 :
          sortie=true;
          break;
        }
      }
    }
    if (entree&&pikachu&&sortie)
    {
      if (TestIA())//Si l'IA retourne true on peut sauvegarder
      {
        {
          println("Le niveau a bien ete sauvegarde et il est possible");//Ecriture dans la console pour plus de simplicite
          PrintWriter output; //On demarre la procedure d'ecriture
          output=createWriter("data/niv"+niv.numNiv+".txt"); //On cree un ecrivain qui va reecrire sur nos niv1 ,niv2 ou niv3
          output.println(niv.nbrBlocsX+" "+niv.nbrBlocsY);   //On met d'abord sur la premiere ligne la taille du tableau
          for (int y=0; y<niv.nbrBlocsY; y++)//On parcourt le tableau
          {
            for (int x=0; x<niv.nbrBlocsX; x++)
            {
              output.print(niv.niveau[x][y]+" ");//On ajoute sur une meme ligne separes d'un espace tous les elements d'un Y donne en faisant varier les X
            }
            output.println(); //Quand on  passe a un nouveau Y on fait un retour a la ligne
          }
          output.flush();
          output.close();//On ferme correctement l'ecrivain
        }
      }
    }
  }

  boolean TestIA()//Fonction de test de l'IA qui appelle une focntion recursive
  {
    for (int y=0; y<niv.nbrBlocsY; y++)//On initialise bien les tableaux d'IA a 0 pour eviter tout probleme
    {
      for (int x=0; x<niv.nbrBlocsX; x++)
      {
        tabIA[x][y]=0;
        tabIA2[x][y]=0;
      }
    }
    int caseCouranteX=niv.entreeX;//On demarre a l'entree
    int caseCouranteY=niv.entreeY;
    boolean pikachuTrouve=false;//On n'a pas encore trouve le pikachu
    RecursiveIA(caseCouranteX, caseCouranteX, caseCouranteY, caseCouranteY, tabIA, pikachuTrouve);//Teste si c'est possible d'aller jusquau pikachu
    if (tabIA[niv.pikachuX][niv.pikachuY]>0) {
      pikachuTrouve=true;//Si on a ete jusquau pikachu la valeur dans la case du tableau IA est passee a 1 et donc on passe le booleen a true
    }

    caseCouranteX=niv.pikachuX;//On commence maintenant a partir du pikachu
    caseCouranteY=niv.pikachuY;
    RecursiveIA(caseCouranteX, caseCouranteX, caseCouranteY, caseCouranteY, tabIA2, pikachuTrouve);//Teste si c'est possible d'aller jusqua la sortie
    rectMode(CENTER);
    for (int y=0; y<niv.nbrBlocsY; y++)
    {
      for (int x=0; x<niv.nbrBlocsX; x++)
      {
        if (tabIA[x][y]==1) {
          rectMode(CENTER);
          rect(x*niv.tailleBloc+niv.tailleBloc/2, y*niv.tailleBloc+niv.tailleBloc/2, 15, 15);
        }
      }
    }
    for (int y=0; y<niv.nbrBlocsY; y++)
    {
      for (int x=0; x<niv.nbrBlocsX; x++)
      {
        if (niv.niveau[x][y]==6&&tabIA2[x][y]==1)//Si la fonction recursive a ete jusqua la sortie la case correspondante sera passee a 1 et on pourra retourner true car le niveau est possible
        {
          return true;
        }
      }
    }
    return false;
  }


  void RecursiveIA(int x, int xPrecedent, int y, int yPrecedent, int[][] tabIA, boolean pikachuTrouve)
  {

    if (x>=0&&y>=0&&x<niv.nbrBlocsX&&y<niv.nbrBlocsY)//On verifie qu'on ne sort pas du tableau
    {


      if (niv.niveau[x][y]==1||(niv.niveau[x][y]==3&&pikachuTrouve)||tabIA[x][y]>0) {//Si on se cogne contre un rocher la sortie bouchee ou une case deja testee on arrete
        return;
      } else {
        if (niv.niveau[x][y]==0||niv.niveau[x][y]==3||(niv.niveau[x][y]==6&&!pikachuTrouve)||(niv.niveau[x][y]==4&&pikachuTrouve))//Si on est sur une case avec laquelle on n'a pas de collision on teste toutes les cases alentours et on passe la case courante a 1
        {
          tabIA[x][y]=1;
          RecursiveIA(x+1, x, y, y, tabIA, pikachuTrouve);
          RecursiveIA(x-1, x, y, y, tabIA, pikachuTrouve);
          RecursiveIA(x, x, y+1, y, tabIA, pikachuTrouve);
          RecursiveIA(x, x, y-1, y, tabIA, pikachuTrouve);
        }
        if (niv.niveau[x][y]==2)//Si on est sur de la glace
        {
          int directionX=x-xPrecedent;
          int directionY=y-yPrecedent;
          if (x+directionX>0&&y+directionY>0&&x+directionX<niv.nbrBlocsX&&y+directionY<niv.nbrBlocsY)
          {
            if (niv.niveau[x+directionX][y+directionY]==2)//Si le bloc sur lequel on va glisser est de la glace on teste cette nouvelle case cependant on ne remplit pas la case courante par un 1 pour eviter les problemes de croisement sur la glace
            {
              RecursiveIA(x+directionX, x, y+directionY, y, tabIA, pikachuTrouve);
            } else {
              if (niv.niveau[x+directionX][y+directionY]==1||(niv.niveau[x+directionX][y+directionY]==3&&pikachuTrouve))
              {
                tabIA[x][y]=1;
                RecursiveIA(x+1, x, y, y, tabIA, pikachuTrouve);
                RecursiveIA(x-1, x, y, y, tabIA, pikachuTrouve);
                RecursiveIA(x, x, y+1, y, tabIA, pikachuTrouve);
                RecursiveIA(x, x, y-1, y, tabIA, pikachuTrouve);
              } else {
                RecursiveIA(x+directionX, x, y+directionY, y,tabIA,pikachuTrouve);
              }
            }
          }
        }
        if (niv.niveau[x][y]==4&&!pikachuTrouve)//Si on trouve le pikachu alors qu'on ne l'a pas encore trouve on passe la case a 1 pour pouvoir verifier ensuite si on a bien atteint cette case
        {
          tabIA[x][y]=1;
          return;
        }
        if (niv.niveau[x][y]==6&&pikachuTrouve)//Meme raisonnement que pour le pikachu
        {
          tabIA[x][y]=1;
          return;
        }
      }
    }
  }
}
