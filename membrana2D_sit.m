function membrana2D_sit(N)
%N...pocetelementunanhranuoblastijednotkovehoctverce
%
%Rovnice
%-(d^2/dx^2+d^2/dy^2)u=f,f=-1;Lx=Ly=1;u=0 nahranici
%
%Pomocnekonstantynb=N-1;
%pocetvnitrnichuzlunahranu(bezu_gamma)np=
n
^2;
%
pocet
vsech
vnitrnich
uzlu
h
=1/
N
;
%
krok
site
%
%
Efektivni
sestaveni
ridke
matice
A
e0
= 4*
ones
(
np
,1);
e2
= -
ones
(
np
,1);
e1h
= -
ones
(
np
,1);
e1h
((
n
+1):
n
:
end
)=0;
e1d
= -
ones
(
np
,1);
e1d
(
n
:
n
:
end
)=0;
A
=
spdiags
([
e2
,
e1d
,
e0
,
e1h
,
e2
],[-
n
,-1,0,1,
n
],
np
,
np
);
%
%
Vektor
prave
strany
f
= -
ones
(
np
,1)*
h
^2;
%
%
Vypocet
u
(
vnitrni
uzly
)
u
=
A
\
f
;
%
%
vizualizace
x
=0:
h
:1;
y
=0:
h
:1;
%
souradnice
[
X
,
Y
]=
meshgrid
(
x
,
y
);
U
=[
zeros
(1,
N
+1);...
zeros
(
n
,1) ,...
reshape
(
u
,
n
,[]) ,...
zeros
(
n
,1);
zeros
(1,
N
+1)];
surf
(
X
,
Y
,
U
,
?
FaceColor
?
,
?
interp
?
)
