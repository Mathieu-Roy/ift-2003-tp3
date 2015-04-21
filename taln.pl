% Analyse grammaticale
p( SEM ) --> gn(AGNT, N), gv(ACT, OBJ, N), { SEM=..[ACT,AGNT, OBJ] }.
gn( AGNT, N ) --> art(N), nc(AGNT,N).
gv( ACT,OBJ, N) --> v(ACT, N), gn(OBJ,_).
art(N) --> [X], { dictionnaire(X,article(N))}.
nc( X, N ) --> [X], { dictionnaire(X,nom_commun(N))}.
v( X, N ) --> [X], { dictionnaire(X,verbe(N))}.

% -----------
% Dictionnaire
% -----------
% articles
dictionnaire('le', article(singulier)).
dictionnaire('un', article(singulier)).
dictionnaire('des', article(pluriel)).
dictionnaire('quel', article(singulier)).

% adverbes
dictionnaire('où', adverbe(singulier)).
dictionnaire('quand', adverbe(singulier)).

% noms communs
dictionnaire('Château Frontenac', nom_commun(singulier)).
dictionnaire('Vieux Québec', nom_commun(singulier)).
dictionnaire('Beaux-Arts', nom_commun(singulier)).
dictionnaire('Festival d\'été de Québec', nom_commun(singulier)).
dictionnaire('Café du Monde', nom_commun(singulier)).

dictionnaire('Boulevard Champlain', nom_commun(singulier)).
dictionnaire('Grande Allée', nom_commun(singulier)).

% verbes
dictionnaire('se trouve', verbe(singulier)).
dictionnaire('est-il', verbe(singulier)).
dictionnaire('a', verbe(singulier)).
