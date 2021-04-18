class Niveau { //<>// //<>// //<>//
  int[][] niveau;
  int nbrBlocsX;
  int nbrBlocsY;
  int tailleBloc;
  int numNiv;

  int entreeX, entreeY, pikachuX, pikachuY;

  boolean pikachuTrouve;
  boolean fini;
  boolean edition;

  PImage neige;
  PImage rocher;
  PImage glace;
  PImage pikachu;
  PImage entree;
  PImage sortie;
  PImage entreeBouchee;
  String pseudo;

  Niveau(String nomFichier, Perso perso) {
    nbrBlocsX=int (split(loadStrings(nomFichier)[0], ' ')[0]); //On recupere le nombre de blocs en X et et
    nbrBlocsY=int (split(loadStrings(nomFichier)[0], ' ')[1]); // en Y qui se situent sur la premiere ligne du fichier texte
    niveau= new int[nbrBlocsX][nbrBlocsY];  //On initialise a la bonne taille le tableau qui construira le niveau
    for (int y=0; y<nbrBlocsY; y++)//On parcourt le tableau
    {
      for (int x=0; x<nbrBlocsX; x++)
      {
        niveau[x][y]=int(split(loadStrings(nomFichier)[y+1], ' ')[x]); //On recupere les valeurs pour les mettres dans le tableau et on commence a y+1 
        if (niveau[x][y]==3)                                           //car la premiere ligne est pour definir la taille du tableau
        {
          //On recupere les coordonees de l'entree pour faire apparaitre le personnage au bon endroit
          entreeX=x;
          entreeY=y;
        }
        if (niveau[x][y]==4)
        {
          pikachuX=x;
          pikachuY=y;
        }
      }
    }

    tailleBloc=min(width/nbrBlocsX, height/(nbrBlocsY)); //Cela permet au niveau d'occuper le maximum d'espace selon la taille de notre fenetre
    numNiv=nomFichier.charAt(3)-48; //Le charAt ne me convertit pas proprement un caractere de chiffre en entier donc je suis obligé de lui soustraire cette valeur pour bien  obtenir les 1,2,3
    pikachuTrouve=false;
    fini=false;
    edition=false;
    neige=loadImage("neige.png");
    rocher=loadImage("rocher.png");
    glace=loadImage("glace.png");
    pikachu=loadImage("pikachu.png");
    entree=loadImage("entree.png");
    sortie=loadImage("sortie.png");
    entreeBouchee=loadImage("entreeBouchee.png");
    perso.caseX=entreeX; // On attribue au personnage ses coordonees de depart
    perso.caseY=entreeY;
    perso.tailleBloc=tailleBloc;
    String pseudo;
  }


  void MiseAJour(Perso p) {
    if (niveau[p.caseX][p.caseY]==4)
    {
      //Si on se trouve sur le pikachu on dit qu'on l'a trouve puis on remplace la case courante par de la neige et on bouche l'entree
      pikachuTrouve=true;
      niveau[p.caseX][p.caseY]=0;
      niveau[entreeX][entreeY]=5;
    }
    if (pikachuTrouve)
    {
      if (niveau[p.caseX][p.caseY]==6)
      {
        fini=true; // Si on se trouve sur la sortie et qu'on a recupere le pikachu le niveau se finit
      }
    }
  }

  void Afficher(Perso p) {
    for (int y=0; y<nbrBlocsY; y++)//On parcourt le tableau
    {
      for (int x=0; x<nbrBlocsX; x++)
      {
        //Affichage assez basique des differentes cases du niveau selon les valeurs du tableau qui s'adaptent a la taille de la fenetre
        if (niveau[x][y]==0)
        {
          image(neige, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc);
        }
        if (niveau[x][y]==1)
        {
          image(neige, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc); //On place d'abord de la neige sous le rocher car le rocher 
          image(rocher, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc); // n'a pas une texture "pleine"
        }
        if (niveau[x][y]==2)
        {
          image(glace, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc);
        }
        if (niveau[x][y]==3)
        {
          image(neige, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc); //Comme pour le rocher
          image(entree, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc);
        }
        if (niveau[x][y]==4)
        {
          image(neige, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc); // Comme pour le rocher
          image(pikachu, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc);
        }
        if (niveau[x][y]==5)
        {
          image(neige, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc); // Comme pour le rocher
          image(entreeBouchee, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc);
        }
        if (niveau[x][y]==6)
        {
          image(neige, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc); // Comme pour le rocher
          image(sortie, x*tailleBloc, y*tailleBloc, tailleBloc, tailleBloc);
        }
      }
    }
    if (!edition)//Permet de ne pas afficher le brouillard de guerre dans l'edition
    {
      if (!pikachuTrouve)
        loadPixels(); 
      {
        for (int x=0; x<width; x++)//On parcourt le tableau
        {
          for (int y=0; y<height; y++)
          {
            int loc=x+y*width; //Pour passer du tableau 2D au tableau 1D
            int distBrouillard=int(dist(p.caseX*tailleBloc+tailleBloc/2+p.decalageEntreCasesX, p.caseY*tailleBloc+tailleBloc/2+p.decalageEntreCasesY, x, y)); //On calcule la distance entre le personnage et un pixel du tableau que l'on parcourt
            if (distBrouillard>tailleBloc*3) { //Si cette distance est superieure a une distance donnee
              pixels[loc]=color(0); //On colore le pixel en  noir afin de creer le brouillard sur la plupart du niveau
            } else {
              int transparence=int(map(distBrouillard, 0, tailleBloc*3, 0, 255)); //On change l'intervalle de 0/tailleBloc*1.5 a 0/255 pour avoir un joli degrade
              float r =constrain(red(pixels[loc])-transparence, 0, 255); //On soustrait cette valeur aux composantes des pixels
              float g =constrain(green(pixels[loc])-transparence, 0, 255); // afin de les assombrir progressivement
              float b =constrain(blue(pixels[loc])-transparence, 0, 255); 
              pixels[loc]=color(r, g, b);
            }
          }
        }
        updatePixels(); //On met a jour pour bien afficher le brouillard
      }
    }
  }
}
