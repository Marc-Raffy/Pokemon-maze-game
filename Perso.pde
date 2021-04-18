class Perso { //<>//
  int caseX;
  int caseY;
  int decalageEntreCasesX;
  int decalageEntreCasesY;

  int tailleBloc;

  int tempsDebutDeplacement;
  int tempsDeplacement; // en milliseconds

  boolean seDeplace;

  PImage perso_haut;
  PImage perso_bas;
  PImage perso_droite;
  PImage perso_gauche;

  int directionX;
  int directionY;
  int orientation;
  int compteurPas=0;

  Perso() {
    decalageEntreCasesX=0;
    decalageEntreCasesY=0;
    tempsDeplacement=100;
    seDeplace=false;
    perso_haut=loadImage("perso_haut.png");
    perso_bas=loadImage("perso_bas.png");
    perso_droite=loadImage("perso_droite.png");
    perso_gauche=loadImage("perso_gauche.png");
    directionX=0;
    directionY=0;
    orientation=1; //On mettra la variable à 1,2,3,4 pour bas, haut, gauche, droite.
  }

  void Afficher() {
    //Affichage basique du personnage en focntion de ses coordonées et de son orientation
    if (orientation==1)
    {
      image(perso_bas, caseX*tailleBloc+decalageEntreCasesX, caseY*tailleBloc+decalageEntreCasesY, tailleBloc, tailleBloc);
    } else {
      if (orientation==2)
      {
        image(perso_haut, caseX*tailleBloc+decalageEntreCasesX, caseY*tailleBloc+decalageEntreCasesY, tailleBloc, tailleBloc);
      } else {
        if (orientation==3)
        {
          image(perso_gauche, caseX*tailleBloc+decalageEntreCasesX, caseY*tailleBloc+decalageEntreCasesY, tailleBloc, tailleBloc);
        } else {
          image(perso_droite, caseX*tailleBloc+decalageEntreCasesX, caseY*tailleBloc+decalageEntreCasesY, tailleBloc, tailleBloc);
        }
      }
    }
  }

  void LancerDeplacement() {
    if (!seDeplace)//On verifie que le personnage ne se deplace pas avant de pouvoir appuyer a nouveau sur une touche
    {
      tempsDebutDeplacement=millis();//On initialise tempsDebutDeplacement on en aura beosin ensuite pour le deplacement fluide
      switch(keyCode)//Selon la fleche sur laquelle on appuie cela va changer l'orientation du personange et
      {              //on initialise les directions pour le deplacement
      case DOWN:  
        orientation=1;
        directionX=0;
        directionY=1;
        seDeplace=true;
        break;

      case UP:
        orientation=2;
        directionX=0;
        directionY=-1;
        seDeplace=true;
        break;

      case LEFT:
        orientation=3;
        directionX=-1;
        directionY=0;
        seDeplace=true;
        break;

      case RIGHT:
        orientation=4;
        directionX=1;
        directionY=0;
        seDeplace=true;
        break;
      }
    }
  }


  void MiseAJour(Niveau niv) {
    if (seDeplace)//On ne deplace le personnage que si on a appuye sur une touche au prealable
    {
      int nvleCaseX=caseX+directionX;//Variables de 
      int nvleCaseY=caseY+directionY;// travail
      if (!(nvleCaseX<niv.nbrBlocsX && nvleCaseY<niv.nbrBlocsY && nvleCaseX>=0 && nvleCaseY >=0))//On verifie qu'on ne sort pas du tableau
      {
        seDeplace=false;  //Si on sort du tableau on arrete tout et on attend un nouveau deplacement
      } else {
        if (niv.niveau[nvleCaseX][nvleCaseY]==1 || niv.niveau[nvleCaseX][nvleCaseY]==5)//Si on rencontre un rocher ou l'entree bouchee
        {
          seDeplace=false;//On arrete et on attend un nouveau deplacement
        } else {
          if (millis()-tempsDebutDeplacement>tempsDeplacement)//Si on se deplace depuis plus longtemps que le temps alloue au deplacement (tempsDeplacement)
          {                                                   //On se teleporte sur la case d'arrivee
            compteurPas++;
            caseX=nvleCaseX;
            caseY=nvleCaseY;
            decalageEntreCasesX=0;
            decalageEntreCasesY=0;
            if (niv.niveau[nvleCaseX][nvleCaseY]!=2)//Si on n'est pas sur de la glace on arrete le deplacement
            {
              seDeplace=false;
            } else {
              tempsDebutDeplacement=millis();//Sinon on continue le deplacement et on reinitialise tempsDebutDeplacement
            }                                //Pour ne pas avoir un deplacement trop rapide sur la glace
          } else {//Si on se deplace depuis moins logntemps que le temps alloue au ddeplacement
            float u =(millis()-tempsDebutDeplacement)/float(tempsDeplacement);  //Nous donne la proportion entre 0 et 1 de bloc qu'on va pouvoir parcourir a chaque tour de boucle
            if (directionX<0)                                                   //On le multipliera par tailleBloc pour avoir le bon nombre de pixels
            {   //On met les bonnes valeurs au decalage selon si on se deplace vers le haut,la droite, etc...
              decalageEntreCasesX=-int(u*tailleBloc);
              decalageEntreCasesY=0;
            } else {
              if (directionX>0)
              {
                decalageEntreCasesX=int(u*tailleBloc);
                decalageEntreCasesY=0;
              } else {
                if (directionY>0)
                {
                  decalageEntreCasesX=0;
                  decalageEntreCasesY=int(u*tailleBloc);
                } else {
                  if (directionY<0)
                  {
                    decalageEntreCasesX=0;
                    decalageEntreCasesY=-int(u*tailleBloc);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
