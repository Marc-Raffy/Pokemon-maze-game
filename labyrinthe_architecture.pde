JeuLabyrinthe jeuLabyrinthe; //<>// //<>// //<>//
void setup() {
  size(1000, 600, P2D); //On utlise le P2D pour de meilleures performances
  jeuLabyrinthe = new JeuLabyrinthe(); //On initialise jeuLabyrinthe //<>//
}

void draw() {
  background(180);
  if (jeuLabyrinthe.menu.lancerJouer)//J'initialise dans le draw car j'ai beosin de savoir dans quel niveau j'ai clique
    //Cependant je passe tout de suite le boolean a false pour ne le faire qu'une fois et que ca ne boucle pas
  {
    jeuLabyrinthe.nivCourant = new Niveau("niv"+jeuLabyrinthe.menu.niveauSelectionne+".txt", jeuLabyrinthe.perso );
    jeuLabyrinthe.menu.lancerJouer=false;
  } 
  if (jeuLabyrinthe.menu.lancerEdition)//Pareil pour l'edition
  {
    jeuLabyrinthe.editeur =new Editeur("niv"+jeuLabyrinthe.menu.niveauSelectionne+".txt");
    jeuLabyrinthe.menu.lancerEdition=false;
  }

  jeuLabyrinthe.MiseAJour();
  jeuLabyrinthe.Afficher();
}

void keyPressed() {//Appelee a chaque fois qu'on appuie sur une touche
  jeuLabyrinthe.KeyPressed();
}

void mouseClicked() {//Appelee a chaque fois qu'on clique sur la souris
  jeuLabyrinthe.MouseClicked();
}

class JeuLabyrinthe { 
  Menu menu;

  Niveau nivCourant;
  Perso perso;
  Editeur editeur;
  Scores scores;

  int niveauSelectionne;
  boolean jouer;
  boolean edition;

  JeuLabyrinthe() { //Constructeur du labyrinthe
    menu=new Menu();
    perso=new Perso();
    scores=new Scores();
  }

  void MouseClicked() {  //Permet de cliquer dans les menus, le clic du labyrinthe n'est pas ici
    menu.MouseClicked(); // car la focntion mouseClicked ne donnerait pas un bon resultat
  }

  void MiseAJour() {
    if (menu.estEnCours)
    {
      if (menu.selecteurDeNiveauxJouer)//On utilise cette variable pour verifier si on joue car on  a passe lancerJouer a false dans le draw
      {
        perso.MiseAJour(nivCourant); //On met a jour le perso et le niveau
        nivCourant.MiseAJour(perso);
        if (nivCourant.fini)//Si le niveau est fini permet de revenir au menu principal
        {
          scores=new Scores(perso, nivCourant);
          menu.estEnCours=false;
          menu.menuPrincipal=true;
          menu.selecteurDeNiveauxJouer=false;
        }
      }
      if (menu.selecteurDeNiveauxEdition)//On utlise cette variable pour verifier si on est dans l'editeur de niveau car on a passe lancerEdition a false dans le draw
      {
        editeur.MiseAJour();
      }
    }
  }

  void Afficher() {
    if (!menu.estEnCours)// Si on est dans le menu on affiche le menu
      menu.Afficher();
    else { //Sinon on affiche soit le jeu soit l'edition avec le meme raisonnement que juste au dessus
      if (menu.selecteurDeNiveauxJouer)
      {
        nivCourant.Afficher(perso);
        perso.Afficher();
      }
      if (menu.selecteurDeNiveauxEdition)
      {
        editeur.Afficher();
      }
      if (menu.scores)
        scores.Afficher();
    }
  }

  void KeyPressed() {//Meme raisonnement que pour l'affichage
    menu.KeyPressed();
    if (menu.selecteurDeNiveauxJouer)
    {
      perso.LancerDeplacement();
    } else {
      if (menu.selecteurDeNiveauxEdition)
      {
        editeur.KeyPressed();
      }
    }
  }
}
