class Scores {//Se compose d'un pseudo du score du tableau qui stocke les scores et du tableau que stocke les pseudos
  String pseudo;
  int score;
  String[][] pseudosScores;
  int[][] valeursScores;

  Scores()//Constructeur qui sera utilise dans le setup pour permettre de pouvoir acceder aux scores avant de lancer un niveau
  {
    pseudosScores=new String[3][5];
    valeursScores=new int[3][5];
  }

  Scores(Perso p, Niveau niv)//Le "vrai" constructeur qu'on utilise quand on a fini un niveau
  {
    pseudo=askString("Quel est votre pseudo ?");
    score=constrain(1000-p.compteurPas, 0, 1000);//J'ai prefere faire un score qui commence a 1000 et qui diminue au fur et a mesure qu'on avance
    pseudosScores=new String[3][5];
    valeursScores=new int[3][5];
    int i=0;
    for (int y=0; y<5; y++)//Permet de placer les bonnes valeurs directement dans le tableau comme ca pas besoin de trier ensuite
    {
      int ybis=y+i;
      for (int x=0; x<3; x++)
      {
        pseudosScores[x][y]=split(loadStrings("pseudosScores.txt")[ybis], " ")[x];
        valeursScores[x][y]=int(split(loadStrings("valeursScores.txt")[ybis], " ")[x]);
        if (x==niv.numNiv-1) {
          if (score!=-1&&valeursScores[x][y]<score)
          {
            valeursScores[x][y]=score;
            pseudosScores[x][y]=pseudo;
            i=-1;
            score=-1;
          }
        }
      }
    }
    PrintWriter outputPseudo, outputValeurs; //On demarre la procedure d'ecriture
    outputPseudo=createWriter("data/pseudosScores.txt");//On cree 2 ecrivains pour pouvoir ecrire dans les 2 tableaux
    outputValeurs=createWriter("data/valeursScores.txt");
    for (int y=0; y<5; y++)//On parcourt le tableau
    {
      for (int x=0; x<3; x++)
      {
        outputPseudo.print(pseudosScores[x][y]+" ");
        outputValeurs.print(valeursScores[x][y]+" ");
      }
      outputPseudo.println();
      outputValeurs.println();//Quand on  passe a un nouveau Y on fait un retour a la ligne
    }
    outputPseudo.flush();
    outputValeurs.flush();
    outputPseudo.close();
    outputValeurs.close();//On ferme correctement l'ecrivain
    p.compteurPas=0;
  }
  void Afficher() {//On affiche dans un premier temps les en tete des 3 niveaux
    rectMode(CORNER);
    fill(150, 0, 0);
    rect(0, 0, width/3, height/6, 15);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Niveau 1", width/6, height/12);

    fill(150, 0, 0);
    rect(width/3, 0, width/3, height/6, 15);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Niveau 2", 3*width/6, height/12);

    fill(150, 0, 0);
    rect(2*width/3, 0, width/3, height/6, 15);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Niveau 3", 5*width/6, height/12);

    for ( int y =1; y<6; y++)
    {
      for (int x=0; x<3; x++)
      {
        pseudosScores[x][y-1]=split(loadStrings("pseudosScores.txt")[y-1], " ")[x];//On charge les fichiers texte dans les tableaux
        valeursScores[x][y-1]=int(split(loadStrings("valeursScores.txt")[y-1], " ")[x]);
        fill(0, 200, 0);//Ensuite on affiche simplement les scores avec une colonne par niveau
        rect(x*width/3, y*height/6, width/3, height/6, 15);
        textAlign(CENTER, CENTER);
        fill(0);
        if (valeursScores[x][y-1]!=0) {//Cette verification permet de ne rien afficher quand la valeur est a 0 plutot que 0 ou null
          text(valeursScores[x][y-1], (x*width+0.5*width)/3, (y*height+0.75*height)/6);
        }
        textAlign(CENTER, CENTER);
        fill(0);
        if (!pseudosScores[x][y-1].equals("0")) {
          text(pseudosScores[x][y-1], (x*width+0.5*width)/3, (y*height+0.25*height)/6);
        }
      }
    }
  }
}
