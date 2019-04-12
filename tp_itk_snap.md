# Reponse aux questions du sujet

### Question 1 : quelle est la taille du champ de vue de l'image du thorax, en voxels et en millimètres ?

- Definition : Champ de vue est l'extension dans l'axis z qu'on peut afficher d'une image DICOM.

A partir de l'onglet tools -> image information... -> info, on trouve des informations sur les dimensions de l'image et l'ecart entre les voxels.

* Dimensions en Voxels
	- X : 512
	- Y : 512
	- Z (Champs de Vue) : 56 

* Dimensions en Milimetres
	- X spacing : 0.6113mm -> Dimension X : 312,9856mm 
	- Y spacing : 0.6113mm -> Dimension Y : 312.9856mm
	- Z spacing : 3mm      -> Dimension Z : 168mm


### Question 2 : à quoi correspondent les 56 fichiers dans ce répertoire ?

Chaque fichier DICOM correspond a un coupe (slice) dans l'axis Z.

### Question 3 : quelles sont les différences entre ces trois images du même sujet ?

La seule image non change peut etre trouve par son identifiant 'image type' dans le metadata.
On dit ORIGINAL ou DERIVE. On note aue le plan coupe plus interessant est mentionne dans le nom des fichiers : COR, pour coronal et SAG pour le plan sagital.

Les resolutions de profondeur z sont differents pour chaque image. On peut se concentrer sur une region specifique pour les champs de vue plus reduites.

- On chage l'orientation pour mieux afficher l'aorte.

- champs de vue plus epaisses ont un rapport signal a bruit plus eleve. Les redondances des coupes sont moyennees pour former la nouvelle image.

### Question 4 : quelle est la relation entre les champs Minimum / Maximum et les champs Level / Window ?

- Level est le niveau d'intensite de moyen entre le minimum et maximum.

- Window est la difference entre minimum et maximum (taille de la fenetre).

### Question 5 : quelle est la valeur de le courant électrique injecté dans le tube à rayons X ?

* X-Ray Tube Current : 190mA

### Question 6 : quelle est la valeur de l’attribut « Image Type » pour chacune des trois images ? S’agit-il de trois acquisitions différentes ?

Les noms des deux images modifies ont change de ORIGINAL pour DERIVE et de SPI pour SPO.

- ORIGINAL\PRIMARY\AXIAL\CT\_SOM5 SPI
- DERIVED\PRIMARY\AXIAL\CT\_SOM5 SPO
- DERIVED\PRIMARY\AXIAL\CT\_SOM5 SPO

Il s'agit toujours de le meme image, mais qui ont passe pour un traitement d'orientation et interpolation (subsampling).


### Question 7 : sur l'image de thorax, laquelle des trois coupes correspond à une vue de face du patient ? 

Le plan le plus proche d'une personne devant nous est le plan coronnal.

### Question 8 : à quoi correspondent les lettres affichées à la bordure des trois coupes (R, A, L, P, S, I) ?

- R : Right
- A : Anterieur
- L : Left
- P : Posterieur
- S : Superieur
- I : Inferieur

### Question 9 : quelle est l'unité des valeurs affichées dans les champs Cursor Position ?

Les unites  du champs cursor position sont toujours des coordonnees de voxels (adimensionnels).

### Question 10 : à quoi correspondent les couleurs affichées ?

Chaque coleur correspond a une label.
Les labels representent des differents structures presents dans le cerveau.

### Question 11 : quelles informations sont contenues dans le fichier anat\_labels.txt ? Vous pouvez l'ouvrir dans un éditeur de texte standard pour en vérifier le contenu.

Le fichier contient une table de correspondance entre les valeurs de label et le nom de leurs structures.

### Question 12 : quels sont les avantages et les inconvénients d'une visualisation par coupes et d'une visualisation surfacique ?

Lors d'une visualisation par coupes, on peut identifier des structures le plus internes du cerveau et les segmenter.
Afficher en coupes est aussi plus rapide que la renderization surfacique.
La visualisation surfacique, cependant, nous permetre verifier l'aspect 3D de le structure et recconaitre sa anatomie.

### Question 13 : quel est le volume en mm 3 de l'hippocampe gauche (Left hippocampus) ?

On ouvre le menu segmentation -> label statistics et trouve la label 48, qui correspond au left hipocampus.
Le volume est 4488mm3.

### Question 14 : quelle est l'intensité moyenne de cette même structure ? Sachant qu'il s'agit d'une image IRM, pouvez-vous déterminer l'unité de cette valeur ?

On trouve l'intensite moyenne aussi dans label statistics. [Quel unite???]

### Question 15 : à quoi correspond l'entrée Clear Label ?

C'est le label standard. Ou on n'a pas de segmentation.

### Question 16 : quels sont les avantages et inconvénients de ces deux outils ?

On arrive a une tres bonne resolution pour l'outil polygonne, mais on demmande plusieurs cliques.
Pqr contre, le pinceau est grossier mais en moins nombreauses cliques.

### Question 17 : comparez la façon dont vous avez placé les contours sur les deux coupes segmentées par l'outil polygone. Que pensez-vous de la reproductibilité de cette méthode de segmentation ?

On perd la resolution spatiale entre deux coupes consecutifs. Par consequence, on peut cliquer sur des endroits proches, mais qui ne sont pas de tout connectes.

### Question 18 : comment évoluent les sphères placées lors de l'étape 2 ?

Les contours evoluent de maniere a ajouter des voxels connexes qui sont dans les thresholds indiquees.

### Question 19 : l'image seuillée de la première étape est appelée image de vitesse. Expliquez ce terme.

Les niveaux de seuillage determinent la region ou les spheres peuvent s'agrandir.

### Question 20 : quels sont les avantages et les inconvénients de cette méthode de segmentation par rapport à la précédente ?

Beaucoup plus rapide, mais on risque de ajouter a la segmentation structures de niveaux de gris proches.

### Question 22 : décrivez le décalage de ces deux images.

Le simages T1 et T2 ne sont pas totallement correles.
L'image T2 est translade par la direction inferieur et presente une rotation

### Question 23 : sachant que ces deux images proviennent du même sujet, est-il nécessaire d'ajuster les paramètres d'homothétie ? 

Les proportions entre les images n'ont pas vraiment change.
Cest le cas, une fois les deux images viennet d'un meme individu et d'une meme machine.

### Question 24 : à quoi correspondent les courbes affichées en dessous du bouton Run registration ?

Se sont des metriques de similarite 4x et 8x utilisees pour le recalage.

### Question 25 : est-ce que les paramètres de rotation, translation et homothétie décrivent complètement une transformation affine ? Pourquoi ?

Bonne question.

### Question 26 : expliquez pourquoi toutes les différences n'ont pas été compensées par le recalage

Se sont deux individus differents et qui ont des structures differents
