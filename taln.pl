% Auteur: Mathieu Roy, Nicolas Garneau, Philippe Chayer
% Date: 25/04/2015

% Mécanique
% Permet de lancer le programme
%go :- write('Que désirez-vous connaître sur le touriste à Québec?'), nl,
%        lire(Chaine,Resultat), p(Resultat,[]).

% Permet de traduire une phrase en une liste de mots
%lire(Chaine,Resultat):-write('Entrer une question: '), read(Chaine),
%        name(Chaine, Temp), chaine_liste(Temp, Resultat),!.

% Prédicat de transformation de chaîne en liste
%chaine_liste([],[]).
%chaine_liste(Liste,[Mot|Reste]):-separer(Liste,32,A,B), name(Mot,A),chaine_liste(B,Reste).

% Sépare une liste par rapport à un élément
%separer([],X,[],[]):-!.
%separer([X|R],X,[],R):-!.
%separer([A|R],X,[A|Av],Ap):-X\==A, |, separer(R,X,Av,Ap).

% Analyse grammaticale pour une question
p( ACT, AGNT, ADV ) --> adv(ADV, N), gv(ACT, N), gn(AGNT, N). % phrase commence par un adverbe
p( ADJ, AGNT, ADV ) --> adv(ADV, N), gn(AGNT, N), gv(_, _), adj(ADJ, N). % phrase commence par un adjectif
p( ADJ, AGNT, AGNT2 ) --> adj(ADJ, N), gn(AGNT, N), gv(_, _), gn(AGNT2, N). % phrase commence par un adjectif et comporte 2 noms
gn( AGNT, N ) --> art(N), nc(AGNT, N). % lorsqu'un nom a un article
gn( AGNT, N ) --> nc(AGNT, N). % lorsqu'un nom a pas d'article
gv( ACT, N ) --> v(ACT, N). % groupe verbale
art( N ) --> [X], {dictionnaire(X, article(N))}.
nc( X, N ) --> [X], {dictionnaire(X, nom_commun(N))}.
v( X, N ) --> [X], {dictionnaire(X, verbe(N))}.
adv( X, N ) --> [X], {dictionnaire(X, adverbe(N))}.
adj( X, N ) --> [X], {dictionnaire(X, adjectif(N))}.

% ----------------
% Poser une question
% ----------------

% Répond aux question du type: Où se trouve le Château Frontenac ?
q(REP, QUEST, RESTE):-
    p(ACT, AGNT, ADV, QUEST, RESTE), SEM=..[ACT, AGNT, ADV, REP], SEM.

% Répond aux question du type: Quand le Musée des Beaux-Arts est-il ouvert ?
q(REP, QUEST, RESTE):-
    p(ADJ, AGNT, ADV, QUEST, RESTE), SEM=..[ADJ, AGNT, ADV, REP], SEM.

% Répond aux question du type: Quel événement a lieu en juillet ?
q(REP, QUEST, RESTE):-
    p(ADJ, AGNT, AGNT2, QUEST, RESTE), SEM=..[ADJ, AGNT, AGNT2, REP], SEM.

% -----------
% Dictionnaire
% -----------
% articles
dictionnaire('le', article(singulier)).
dictionnaire('un', article(singulier)).
dictionnaire('des', article(pluriel)).
dictionnaire('en', article(singulier)).
dictionnaire('au', article(singulier)).
dictionnaire('à', article(singulier)).
dictionnaire('les', article(singulier)).

% adverbes
dictionnaire('où', adverbe(singulier)).
dictionnaire('quand', adverbe(singulier)).
dictionnaire('qui', adverbe(singulier)).
dictionnaire('pourquoi', adverbe(singulier)).

% adjectifs
dictionnaire('ouvert', adjectif(singulier)).
dictionnaire('quel', adjectif(singulier)).

% noms propres
dictionnaire('Château Frontenac', nom_commun(singulier)).
dictionnaire('Vieux Québec', nom_commun(singulier)).
dictionnaire('musée des Beaux-Arts', nom_commun(singulier)).
dictionnaire('Festival d\'été de Québec', nom_commun(singulier)).
dictionnaire('Café du Monde', nom_commun(singulier)).
dictionnaire('Boulevard Champlain', nom_commun(singulier)).
dictionnaire('Grande Allée', nom_commun(singulier)).
dictionnaire('musée de la civilisation', nom_commun(singulier)).
dictionnaire('Québec', nom_commun(singulier)).
dictionnaire('Carnaval de Québec', nom_commun(singulier)).
dictionnaire('Red Bull Crashed Ice', nom_commun(singulier)).
dictionnaire('musée naval de Québec', nom_commun(singulier)).
dictionnaire('parc des Champs-de-Bataille', nom_commun(singulier)).
dictionnaire('plaines d\'Abraham', nom_commun(singulier)).

% noms communs
dictionnaire('évènement', nom_commun(singulier)).
dictionnaire('juillet', nom_commun(singulier)).
dictionnaire('février', nom_commun(singulier)).
dictionnaire('mars', nom_commun(singulier)).

% verbes
dictionnaire('se trouve', verbe(singulier)).
dictionnaire('est-il', verbe(singulier)).
dictionnaire('a lieu', verbe(singulier)).
dictionnaire('habite', verbe(singulier)).
dictionnaire('neige-t-il', verbe(singulier)).

%----------------------------------
% Base de connaissance. En rajouter ici!
%----------------------------------
'se trouve'('musée de la civilisation', 'où', 'Vieux Québec').
'se trouve'('plaines d\'Abraham', 'où', 'parc des Champs-de-Bataille').
'ouvert'('musée des Beaux-Arts', 'quand', '10h à 17h').
'ouvert'('musée naval de Québec', 'quand', '13h à 16h').
'quel'('évènement', 'juillet', 'Festival d\'été de Québec').
'quel'('évènement', 'février', 'Carnaval de Québec').
'quel'('évènement', 'mars', 'Red Bull Crashed Ice').
'habite'('Château Frontenac', 'qui', 'personne, c\'est un hôtel').
'neige-t-il'('Québec', 'pourquoi', 'parce qu\'il fait froid').
