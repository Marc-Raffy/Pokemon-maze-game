class Menu {
  boolean menuPrincipal; // Jouer; Edition niveaux; Scores; Quitter;
  boolean selecteurDeNiveauxJouer;
  boolean selecteurDeNiveauxEdition;
  boolean scores;

  boolean estEnCours; // J'ai compris le estEnCours dans le sens ou le jeu est en cours et non pas le menu
  int niveauSelectionne;
  boolean lancerJouer;
  boolean lancerEdition;

  String[] itemsMenuPrincipal = {"Jouer", "Edition Niveaux", "Scores", "Quitter"};
  String[] itemsSelecteurDeNiveauxJouer = {"Niveau 1", "Niveau 2", "Niveau 3", "Retour"};
  String[] itemsSelecteurDeNiveauxEdition = {"Niveau 1", "Niveau 2", "Niveau 3", "Retour"};

  int tailleBoutonsX = width/2;  //Changement de la taille des boutons
  int tailleBoutonsY = height/8; //pour qu'ils s'adaptent à la taille de la fenêtre

  Menu() { //Constructeur du menu
    //On met notamment les bonnes valeurs aux booleens pour commencer sur le menu principal lorsqu'on lance le jeu
    menuPrincipal=true;
    selecteurDeNiveauxJouer=false;
    selecteurDeNiveauxEdition=false;
    scores=false;
    estEnCours=false;
    niveauSelectionne=0;
    lancerJouer=false;
    lancerEdition=false;
  }

  void Afficher() {  //Affichage du menu
    if (!estEnCours)//On affiche le menu que si l'on est pas deja en train  de jouer
    {
      rectMode(CENTER); //Passage en mode center pour centrer plus facilement les boutons
      for (int i=0; i<4; i++) {
        fill(0);
        rect(width/2, (i+1)*height/4-height/8, tailleBoutonsX, tailleBoutonsY, 15); //Affichage de boutons qui s'adaptent à la taille de la fenêtre et arrondis dans les coins
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(tailleBoutonsY/3); //Variation de la taille du texte en fonction de la fenêtre
        if (menuPrincipal)
          //On affiche des textes differents selon le sous menu dans lequel on se toruve
        {
          text(itemsMenuPrincipal[i], width/2, (i+1)*height/4-height/8);
        } else {
          if (selecteurDeNiveauxJouer)
          {
            text(itemsSelecteurDeNiveauxJouer[i], width/2, (i+1)*height/4-height/8);
          } else {
            text(itemsSelecteurDeNiveauxEdition[i], width/2, (i+1)*height/4-height/8);
          }
        }
      }
    }
  }
  void MouseClicked() {
    if (!estEnCours)//On verfie qu'on n'est pas en train de jouer sinon on pourra cliquer dans le menu alors qu'on est dans un niveau
    {
      if (mouseX>(width-tailleBoutonsX)/2&&mouseX<(width+tailleBoutonsX)/2) //On teste si la souris est dans la "colonne" ou sont placés les boutons
      {
        //On regarde ensuite dans quel menu on se situe puis on teste la position en y pour cliquer sur les boutons
        if (menuPrincipal)
        {
          if (mouseY>(height/4-height/8)-tailleBoutonsY/2 && mouseY<(height/4-height/8)+tailleBoutonsY/2) 
          {
            menuPrincipal=false;
            selecteurDeNiveauxJouer=true;
          }
          if (mouseY>(2*height/4-height/8)-tailleBoutonsY/2 && mouseY<(2*height/4-height/8)+tailleBoutonsY/2)
          {
            menuPrincipal=false;
            selecteurDeNiveauxEdition=true;
          }
          if (mouseY>(3*height/4-height/8)-tailleBoutonsY/2 && mouseY<(3*height/4-height/8)+tailleBoutonsY/2)
          {
            menuPrincipal=false;
            scores=true;
            estEnCours=true;
          }
          if (mouseY>(4*height/4-height/8)-tailleBoutonsY/2 && mouseY<(4*height/4-height/8)+tailleBoutonsY/2)
          {
            exit();//On quitte le jeu
            println("C'est fini tout le monde descend");
          }
          return;
        }
        if (selecteurDeNiveauxJouer)
        {
          if (mouseY>(height/4-height/8)-tailleBoutonsY/2 && mouseY<(height/4-height/8)+tailleBoutonsY/2)
          {
            lancerJouer=true;
            estEnCours=true;
            niveauSelectionne=1;
          }
          if (mouseY>(2*height/4-height/8)-tailleBoutonsY/2 && mouseY<(2*height/4-height/8)+tailleBoutonsY/2)
          {
            lancerJouer=true;
            estEnCours=true;
            niveauSelectionne=2;
          }
          if (mouseY>(3*height/4-height/8)-tailleBoutonsY/2 && mouseY<(3*height/4-height/8)+tailleBoutonsY/2)
          {
            lancerJouer=true;
            estEnCours=true;
            niveauSelectionne=3;
          }
          if (mouseY>(4*height/4-height/8)-tailleBoutonsY/2 && mouseY<(4*height/4-height/8)+tailleBoutonsY/2)
          {
            selecteurDeNiveauxJouer=false;
            menuPrincipal=true;
          }
          return;
        }
        if (selecteurDeNiveauxEdition)
        {
          if (mouseY>(height/4-height/8)-tailleBoutonsY/2 && mouseY<(height/4-height/8)+tailleBoutonsY/2)
          {
            lancerEdition=true;
            estEnCours=true;
            niveauSelectionne=1;
          }
          if (mouseY>(2*height/4-height/8)-tailleBoutonsY/2 && mouseY<(2*height/4-height/8)+tailleBoutonsY/2)
          {
            lancerEdition=true;
            estEnCours=true;
            niveauSelectionne=2;
          }
          if (mouseY>(3*height/4-height/8)-tailleBoutonsY/2 && mouseY<(3*height/4-height/8)+tailleBoutonsY/2)
          {
            lancerEdition=true;
            estEnCours=true;
            niveauSelectionne=3;
          }
          if (mouseY>(4*height/4-height/8)-tailleBoutonsY/2 && mouseY<(4*height/4-height/8)+tailleBoutonsY/2)
          {
            selecteurDeNiveauxEdition=false;
            menuPrincipal=true;
          }
          return;
        }
      }
    }
  }
  void KeyPressed()
  {
    //Si l'on est dans un niveau et que l'on appuie sur Q cela nous permet de revenir au menu principal
    if ((key=='q' || key=='Q')&&estEnCours)
    {
      menuPrincipal=true;
      lancerJouer=false;
      lancerEdition=false;
      estEnCours=false;
      selecteurDeNiveauxJouer=false;
      selecteurDeNiveauxEdition=false;
      scores=false;
    }
  }
}
