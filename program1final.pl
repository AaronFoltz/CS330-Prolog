/*Aaron Foltz*/
/*Due November 3*/
/*CS330*/

article(123,name(donald,knuth),'Babylonian Algorithms',1975,[40,123]).
article(111,name(donald,jones),'Linux',1993,[123,180]).
article(50,name(donald, trump),'Win Big',2009,[190,150]).

article(100,name(donald,richards),'Donald Knuth',1993,[110,111]).
article(40,name(aaron,smith),'Dont Fail',1960,[123,111,130,50]).
article(60,name(david,goldberg),'Genetic Algorithms in Search, Optimization, and Machine Learning',1989,[123,110]).

article(110,name(donald,knuth),'The art of computer programming, Vol. 3: sorting and searching',1973,[111,60,123]).
article(120,name(jeffrey,vitter),'External memory algorithms and data structures: dealing with massive data',2001,[123,170,180]).
article(130,name(michael,stutz),'Getting Help With Linux',1998,[111,140,150,50]).
                    
article(140,name(rick,lehrbaum),'Using Linux in Embedded and Real-Time Systems',2000,[130,111]).
article(150,name(alex,withers),'Linux Apprentice',1998,[111,140]).
article(160,name(philip,rabinowitz),'Practical error coefficients in the integration of periodic analytic functions by the trapezoidal rule',1968,[123]).

article(170,name(wilfred,hansen),'The structure of “data structures”',1981,[180]).
article(180,name(aaron,tenenbaum),'Memory utilization efficiency under a class of first-fit algorithms',1980,[40,160]).
article(190,name(li,pan),'The impact of e-money on the monetary policy',2005,[50,40]).

subject(123,'Algorithms').
subject(123,'History').
subject(40,'History').
subject(50,'Money').
subject(150,'Biography').
subject(111,'Technology').
subject(60,'Algorithms').
subject(110,'Programming').
subject(120,'Data Structures').
subject(130,'Technology').
subject(140,'Technology').
subject(150,'Technology').
subject(160,'Error Coefficients').
subject(170,'Data Structures').
subject(180,'Algorithms').
subject(190,'Money').

/*Succeeds if H is not a member of T*/
notmember(H,T):- member(H,T),!,fail.
notmember(H,T).

/*This succeeds if X refers to Y; X and Y are codes.*/
art2art(X,Y) :- article(X,name(_,_),_,_,Z),member(Y,Z).

/*Succeeds if there is a chain of references from last name X to last name Y*/
/*Base - X refers directly to Y*/
authchain(X,Y):- article(F,name(_,X),_,_,Z),article(C,name(_,Y),_,_,_), art2art(F,C).
authchain(X,Y):- article(F,name(_,X),_,_,Z),article(C,name(_,Y),_,_,_),append([F],[],Result),chain(C,Z,Result),
	different(F,C).

/*This succeeds if there is a chain of references from list [H|T] to code C*/
/* Used for authchain(X,Y)*/
chain(C,[H|T],Result):- notmember(H,Result),art2art(H,C). /*Base case - X refers to C*/
chain(C,[H|T],Result):- notmember(H,Result),append([H],Result,L),article(H,name(_,_),_,_,Z),chain(C,Z,L).
chain(C,[_|T],Result):- chain(C,T,Result).

/*Succeeds if two things are different*/
different(X,X):- !,fail.
different(_,_).

/*This succeeds if X and Y share a subject;X and Y are codes.*/
subj2subj(X,Y):- subject(X,Z),subject(Y,Z).

/*A paper with title X on subject Y published before year Z.*/
publbefore(X,Y,Z):- article(C,name(F,L),X,A,_),subject(C,Y), A<Z.

/*Checks if article with Code X was published before year Y*/
refbefore(X,Y):- article(X,name(_,_),_,A,_),A<Y.
	
	
	
	
