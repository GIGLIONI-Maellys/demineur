/////////////////////////////////////////////////////
//
// Démineur
// DM "UED 131 - Programmation impérative" 2023-2024
// NOM         : GIGLIONI
// Prénom      : Maëllys
// N° étudiant : 20230124
//
// Collaboration avec :  processing 
//
/////////////////////////////////////////////////////
//
//Initialisation cote
int cote ; 
// 
//Initailisation des constantes globales INIT, STARTED et OVER 
int init =  0 ; 
int started = 1 ; 
int over = 2 ; 
//
// On déclare les constantes EMPTY, FLAG and BLOC 
int bloc = 0 ; 
int empty = 1 ; 
int flag = 2 ; 
// On déclare etat_bloc et on initialise à init 
int etat_bloc = init ; 
//
//On intiialise le variable etat à init 
int etat = init ; 
//
//Initialisation de la variable bandeau 
int bandeau ; 
//
// Declaration variable colonne 
int colonne = 30;

//
//Declaration variable ligne 
int ligne = 16 ;
//
//Initialisation du tableau paves 
int[][] paves = new int [colonne][ligne] ;
// 
// Initialisation d'un tableau de booléens bombes 
boolean [][] bombes = new boolean [colonne][ligne] ; 
//
// Initialisation d'un tableau d'entiers nb_bombes
int [][] nb_bombes = new int [colonne][ligne] ;
//Déclaration de la variable type PFONT et création de la fonte
// 
PFont ecriture ; 
// Initialisation de la fenêtre graphique
//
// 
//Déclaration variable du nombre de mines/bombes restantes 
//
int mines = 100 ; 

// déclaration variable start 
int start ; 
void settings() {
  cote = 20 ;
  bandeau = 50 ;
  size((colonne*cote), (ligne*cote)+bandeau) ;
}

//
// Initialisation du programme
//
void setup() {
  init();
}

//
// Initialisation du jeu
//
void init() {
  start = millis() ;
  background(92) ;
  bandeau() ;
  etat_bloc = bloc ; 
  //Initialisation des valeurs à bloc pour le tableau paves à double entrée 
  for ( int y = 0; y< ligne; y++) {
    for (int z = 0; z < colonne; z++) {
      paves[z][y] = bloc ;
    }
  }
  // Initialisation des valeurs à False pour le tableau bombes à double entrée 
  for (int x = 0; x < colonne; x ++) {
    for (int w = 0; w< ligne; w ++) {
      bombes[x][w] = false ;
    }
  }
  //Initialisation des valeurs à 0 pour le tableau nb_bombes puis valeurs=> calcul grâce à tableau bombe
  for (int v = 0; v < colonne; v ++ ) {
    for (int u = 0; u <ligne; u ++) {
      nb_bombes [v][u] = 0;
    }
  }

  //création de 100 bombes aux coordonnées aléatoires 
  for (int i = 0; i < 100; i++) {
    rc = int(random(colonne)) ; 
    rl = int(random(ligne)) ; 
    drawBomb(rc, rl) ; 
    bombes[rc][rl] = true ;
  }
  //Calcul du nombre de bombes autour d'une case grâce à tableau bombes

  for (int i = 1; i < (colonne); i++) {
    for (int j = 1; j<(ligne); j++) {
      if ( (i> 0) && (j >0) && (j< ligne-1) && (i < colonne-1) ) {
        //
        //Pour les blocs normaux qui ne sont pas en bord de fenêtre 
        //
        //ligne supérieure
        //
        if (bombes[i-1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne du bloc 
        //
        if (bombes[i-1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne inférieure 
        //
        if (bombes[i-1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
      }

      // dans les cas ou le bloc est sur le coin supérieur gauche de la fenêtre 
      if ((j == 0)&& (i==0)) {
        //
        //pas de ligne supérieur vu que c'est le bloc dans le coin supérieur gauche
        //ligne du bloc, pas de côté gauche vu qu'il est dans le coin supérieur gauche 
        //
        if (bombes[i+1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne inférieur, il n'y a que les deux blocs (en dessous et à droite car coin sup gauche
        //
        if (bombes[i][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
      }
      //
      //dans le cas ou le bloc se trouve dans le coin supérieur droit
      //
      if ((j == 0) && (i == (colonne-1))) {
        //
        //il n'y a pas de ligne supérieure, vu que le bloc se trouve dans le coin supérieur droit 
        //
        //ligne ou se trouve le bloc, pas de côté droit car le bloc se trouve dans le coin supérieur droit
        //
        if (bombes[i-1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne inférieure, pas de côté droit car coin sup droit 
        //
        if (bombes[i-1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
      }
      //
      //dans le cas ou le bloc se trouve dans le coin inférieur gauche 
      //
      if ((j == (ligne-1)) && (i== 0)) {
        //
        //ligne supérieur, pas de côté gauche car coin inf gauche 
        //
        if (bombes[i][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne où se toruve le bloc, pas de côté gauche car coin inf gauche 
        //
        if (bombes[i+1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //pas de ligne inférieure car coin inf gauche
        //
      }
      //
      //dans le cas ou le bloc se trouve dans le coin inférieur droit 
      //
      //ligne supérieure, pas de coin car coin inf droit 
      // 
      if ((j == (ligne-1)) && (i == (colonne -1))) {
        //
        //ligne supérieure, pas de coin car coin inf droit 
        // 
        if (bombes[i-1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne soù se trouve le bloc, pas de côté droit car coin inf droit 
        //
        if (bombes[i-1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        // 
        //pas de ligne inférieure car coin inf droit 
        //
      }
      //
      // dans le cas ou les blocs sont sur la première ligne mais pas dans un coin 
      //
      if ((j == 0) && (i != 0)) {
        //
        //pas de ligne supérieur car bloc ligne sup 
        //
        //ligne du bloc 
        //
        if (bombes[i-1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne inférieure 
        //
        if (bombes[i-1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
      }
      //
      // dans le cas ou le bloc se trouve sur la dernière ligne, mais pas dans un coin
      // 
      if ((j == (ligne-1)) && (i > 0) && (i < colonne-1)) {
        //
        //ligne supérieure
        //
        if (bombes[i-1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne du bloc 
        //
        if (bombes[i-1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        // 
        // bloc sur dernière ligne donc pas de ligne inférieure 
        //
      }
      //
      //dans le cas où le bloc est sur le côté gauche de la fenêtre 
      // 
      if ((i==0) && (j>0) && (j<(ligne-1))) {
        //
        //pour chaque ligne, pas de côté gauche car bloc colonne gauche 
        //
        //ligne supérieure
        //
        if (bombes[i][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne du bloc 
        //
        if (bombes[i+1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne inférieure 
        //
        if (bombes[i][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i+1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
      }
      // 
      //dans le cas ou le bloc se trouve sur l'extrémité droite de la fenêtre 
      // 
      if ((i== (colonne-1)) && (j> 0) && (j< (ligne-1))) {
        //
        // pour chaque ligne, pas de côté droit car bloc sur extrémité droite
        //
        //ligne supérieure
        //
        if (bombes[i-1][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j-1] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne du bloc 
        //
        if (bombes[i-1][j] == true) {
          nb_bombes[i][j] ++ ;
        }
        //
        //ligne inférieure 
        //
        if (bombes[i-1][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
        if (bombes[i][j+1] == true) {
          nb_bombes[i][j] ++ ;
        }
      }
    }
  }
}

//
//
//Initialisation de variables (random colonne utilisée dans création bombes
int rc ;
int rl ; 

//
// boucle de rendu
// - met à jour le temps écoulé depuis le début de la résolution
// - appelle la fonction d'affichage
//
void draw() {
  display();
}

//
// calcule le nombre de bombes dans les 8 cases voisines
// (x, y) = coordonnées de la case
//
//int voisins (int x, int y) {
//}

//
// affiche un bloc
// (x, y) = coordonnées du bloc
// (w, h) = dimensions du bloc
//
void drawBloc(int x, int y, int w, int h) {
  x = x*cote ;
  y = (y*cote)+ bandeau ;

  // fond blanc
  fill(255) ;
  rect(x, y, w, h) ;
  //rectangle gris clair
  fill(200) ;
  rect(x+2, y+2, 16, 16) ;
  //rectangles sur les côtés en plus foncé 
  fill(150) ;
  noStroke() ;
  rect(x+18, y+1, 2, 2) ;
  rect(x+1, y+18, 2, 2) ;
  rect(x+19, y, 2, 2) ;
  rect(x, y+19, 2, 2) ;
  strokeWeight(4) ;
}

//
// affiche un drapeau dans la case
// (x, y) = coordonnées de la case
//
void drawFlag(int x, int y) {
  x = x*cote ;
  y = y*cote + bandeau ;
  fill(0) ;
  //rectangles de la base du drapeau 
  rect(x+6, y+13, 8, 2) ;
  rect(x+4, y+15, 12, 2 );
  //rectangles formant la tige du drapeau
  rect(x+10, y+3, 1, 10) ;
  //drapeau rouge 
  noStroke() ;
  fill(255, 0, 0) ;
  rect(x+7, y+4, 3, 3) ;
  rect(x+5, y+5, 2, 1) ;
  rect(x+9, y+3, 1, 1) ;
  rect(x+9, y+7, 1, 1) ;
  strokeWeight(4) ;
}


//
// affiche une bombe dans la case
// (x, y) = coordonnées de la case
//
void drawBomb(int x, int y) {
  x = x*cote ;
  y = y*cote + bandeau;
  //cercle de base de la bombe 
  fill(0) ;
  rect(x+8, y+5, 5, 9);
  rect(x+6, y+7, 9, 5) ;
  rect(x+7, y+6, 7, 7) ;
  rect(x+4, y+9, 13, 1) ;
  rect(x+10, y+3, 1, 13) ;
  //lignes qui se croisent autour de la bombe
  rect(x+5, y+4, 1, 1) ;
  rect(x+6, y+5, 1, 1) ;
  rect(x+14, y+5, 1, 1) ;
  rect(x+15, y+4, 1, 1) ;
  rect(x+6, y+13, 1, 1) ;
  rect(x+5, y+14, 1, 1) ;
  rect(x+14, y+13, 1, 1) ;
  rect(x+15, y+14, 1, 1) ;
  // reflet blanc sur la bombe 
  fill (255) ;
  noStroke() ;
  rect(x+7, y+8, 4, 2) ;
  rect(x+8, y+7, 2, 4) ;
  strokeWeight(4) ;
}

//
// affiche dans la case le nombre de mines
//  présentes dans les 8 cases voisines 
//
void drawNbBombesACote(int i, int j) {
  String[] fontList = PFont.list();
  PFont ecriture1 = createFont("mine-sweeper.ttf", 15) ;
  textFont(ecriture1) ; 
  switch (nb_bombes[i][j]) {
  case 1 :
    fill(0, 35, 245) ; 
    break ; 

  case 2 :
    fill(55, 125, 35) ; 
    break ; 

  case 3 :
    fill(235, 50, 35) ; 
    break ; 

  case 4 :
    fill(120, 20, 10) ; 
    break ; 

  case 5 :
    fill(115, 20, 10) ; 
    break ; 

  case 6 :
    fill(55, 125, 125) ; 
    break ;

  default : 
    fill(0) ; 
    break ;
  }
  //dessiner les chiffres
  if (bombes[i][j] == false && nb_bombes[i][j]>0) {
    text(nb_bombes[i][j], 20*i+2, 20*j+bandeau+18) ;
  }
  if (bombes[i][j] == true) {
    fill(0) ;
  }
}

//
// affiche le nombre de mines restant à localiser
//
void drawScore() {
  // 
  fill(0) ; 
  rect(0, 0, 80, 40) ; 
  fill(90, 10, 10) ;
  text("888", 0, 38) ; 
  fill(255, 0, 0) ; 
  if (mines<10) {
    text("00", 0, 40) ; 
    text(mines, 52, 40) ;
  } else if (mines>10 & mines<100) {
    text("0", (colonne*cote)-80, 40) ; 
    text(mines, 27, 40) ;
  } else if (mines >= 100) {
    text(mines, 0, 40) ;
  }
}

//
// affiche le temps écoulé depuis le début de la résolution
//
// Initialisation de la variable time 
float time ; 
//

void drawTime() {
  // 
  //Déclaration de la variable time 
  //écriture
  String[] fontList = PFont.list();
  ecriture = createFont("DSEG7Classic-Bold.ttf", 32) ;
  //
  fill(0) ; 
  rect((colonne*cote)-80, 0, (colonne*cote), 40) ;
  textFont(ecriture) ; 
  fill(90, 10, 10) ;
  text("888", (colonne*cote)-80, 40) ; 
  fill(255, 0, 0) ; 
  textFont(ecriture) ; 

  if (etat == started ) {
    int sta = millis() ; 
    // Déclaration de la variable start et initialisation de la variable start 
    time = sta*0.001 - start*0.001 ; 
    if (time<10) {
      text("00", (colonne*cote)-80, 40) ; 
      text(time, (colonne*cote)-35, 40) ;
    } else if (time>10 & time<100) {
      text("0", (colonne*cote)-80, 40) ; 
      text(time, (colonne*cote)-58, 40) ;
    } else if (time >= 100 && time<1000) {
      text(time, (colonne*cote)- 84, 40) ;
    } else if (time==1000) {
      time = 0 ; 
      text(time, (colonne*cote)-35, 40) ;
    }
  }
}

//
// dessine un smiley content au centre du bandeau
// Remarque : lorsqu'il n'y a que le smiley qui s'affiche sur l'écran, on peut voir le sourire, cependant quand il y a aussi les blocs, le sourire ne s'affiche pas
//
float xoeild ;
float xoeilg ;

void drawHappyFace() {
  xoeild= (colonne*cote)/2 +10 ;
  xoeilg =(colonne*cote)/2 -10 ;
  fill(255, 255, 0) ;
  ellipse((colonne*cote)/2, 25, 40, 40) ; 
  fill(0) ; 
  //oeil droit 
  ellipse(xoeild, 15, 5, 5) ;
  //oeil gauche 
  ellipse(xoeilg, 15, 5, 5) ;
  arc((colonne*cote)/2, 35.0, 20.0, 10.0, 0, PI) ; 
  strokeWeight(4) ;
}

// dessine un smiley mécontent au centre du bandeau
//les croix des yeux ne s'affichent pas 
void drawSadFace() {
  xoeild= (colonne*cote)/2 + 10 ;
  xoeilg =(colonne*cote)/2 -10 ;
  fill(255, 255, 0) ;
  ellipse((colonne*cote)/2, 25, 40, 40) ; 
  strokeWeight(2);
  fill(0) ; 
  //oeil gauche
  line (xoeilg-2, 23, xoeilg +2, 27) ;
  line(xoeilg +2, 23, xoeilg-2, 27) ;
  //oeil droit 
  line(xoeild-2, 23, xoeild+2, 27) ;
  line (xoeild+2, 23, xoeild-2, 27) ;
  fill(0);
  arc((colonne*cote)/2, 35.0, 20.0, 7.0, PI, 2*PI) ;
}

void drawBlocHappy(int x, int y, int w, int h) {
  x = x*cote ;
  y = y*cote ;
  //fond gris foncé 
  fill(50) ; 
  rect(x, y, w, h) ;
  // fond blanc
  fill(250) ;
  rect(x, y, w - 3, h-3) ;
  //rectangle gris clair
  fill(200) ;
  rect(x+2, y+2, w-5, h-5) ;
}
//

//
// affiche le démineur
//
void display() {

  //bloc 
  drawBlocHappy(14, 0, 50, 50) ; 
  //
  if ((etat == 0 ) || (etat == 1)) {
    drawHappyFace() ;
  } else if (etat == 2) {
    drawSadFace() ;
  }
  drawTime() ; 
  drawScore() ;

  for (int i = 0; i < colonne; i++) {
    for (int j = 0; j<ligne; j++) {
      if (paves[i][j]== flag || (paves[i][j] == bloc)) {
        drawBloc(i, j, cote, cote) ; 
        if (paves[i][j] == flag ) {
          drawFlag(i, j) ;
        }
      }
      if (paves[i][j] == empty && nb_bombes[i][j] > 0) {
        drawNbBombesACote( i, j);
      }
    }
  }
}


void grille () {
  for ( int a = 0; a<100; a++) {
    for ( int c = 0; c< colonne; c ++) {
      for (int l = 0; l<ligne; l ++) {
        drawBloc(c, l, cote, cote) ;
      }
    }
  }
}

//
// affiche le démineur quand on a perdu
// = on révèle l'emplacement des bombes
// et on affiche le smiley mécontent
//
void displayBombs(int x, int y) {
}

//
// calcule les blocs qui doivent être découverts
// = les blocs vides autour si (x, y) est vide
//
void decouvre(int x, int y) {
}

//
// calcule les blocs qui doivent être découverts
// = les blocs vides autour de la case (x, y) portant un numéro, 
// dont on a localisé tous les blocs voisins
//
void decouvre2(int x, int y) {
}

//
// met à jour le nombre de drapeaux voisins 
// qui ont été localisés et marqués
//
void updateNbDrapeaux(int x, int y) {
  
}

//
// gère les interactions souris
//
void mouseClicked() {
  //mise à jour de la variable d'état, entre init, over et started quand on clique sur le bloc du smiley
  if (mouseX>14*cote && mouseX<64*cote && mouseY>0 && mouseY<50 ) {
    if (etat == started) {
      print(etat) ; 
      etat = init ; 
      init() ; 
      print(etat) ;
    }
    if (etat == over) {
      print(etat) ; 
      etat = init ;
      init () ; 
      print(etat) ;
    }
  }


  //numéro de ligne de case cliquée 
  int nlcase = (mouseY - bandeau) / cote ; 
  //
  //numéro de colonne de case cliquée 
  int nccase = mouseX/cote ; 

  if ((mouseX < colonne*cote) && (mouseX >= 0) && (mouseY >bandeau) && (mouseY < ligne*cote) ) {
    //mise à jour de la variable d'état pour quand on clique dans la zone de jeu
    if (etat == init ) {
      etat = started ;
      print(etat) ;
    } 
    // on complète la fonction pour donner les valeurs à état_bloc 
    if ((mouseButton == LEFT)&&(paves[nccase][nlcase]==bloc)) {
      paves[nccase][nlcase] = empty ;
    } else if ((mouseButton == RIGHT) && (paves[nccase][nlcase]== bloc)) {
      paves[nccase][nlcase] = flag ;
    } else if ((mouseButton == RIGHT) && (paves[nccase][nlcase] == flag)) {
      paves[nccase][nlcase] = bloc ;
    }
    //
    //numéro de ligne de la case cliquée 

    // lorsque on clique avec bouton de gauche 
    if ((mouseButton == LEFT ) && (bombes[nccase][nlcase] == true)) {
      etat = over ;
      mines = 100 ;
    }
    if ((mouseButton == LEFT ) && (bombes[nccase][nlcase] == false)) {
      paves[nccase][nlcase] = empty ;
    }
    //allez savoir pourquoi avec right ça ne marche pas et ça marche sur ma souris et mon ordi quand je mets !=RIGHT 
    if (mouseButton != RIGHT ) {
      if (paves[nccase][nlcase] == bloc ) {
        mines -- ; 
        paves[nccase][nlcase] = flag ;
      }
      if (paves[nccase][nlcase] == flag) {
        paves[nccase][nlcase] = bloc ; 
        mines ++ ;
      }
    }
  }
}
//bandeau initialisation et fonction 
// 
void bandeau () {
  fill (92) ;
  rect(0, 0, (colonne*cote), 50) ;
}
