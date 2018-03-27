# Parallelograms-Detection

## (1) convert them into grayscale images

## convert them into grayscale images by using the formula luminance = 0.30R + 0.59G +

## 0.11B

## detect edges using the Sobel’s operator,Sobel operator:

## Gx= *A

## Gy= *A

## G=

## Code:

```
f unct i on [ gr a y] =gr a yi mg( i mg)
%i mg =i mr e a d(' Test I ma ge 1c. j pg' );
R= d o u bl e(i mg( :,:, 1));
G= d o u bl e(i mg( :, :, 2));
B= d o u bl e(i mg( :,:, 3));
gr a y =0. 30 * R + 0. 59* G + 0. 11* B;
%f pr i nt f(' %f' , ma x( ma x( gr a y3) ));
%g r a y =d o u bl e( gr a y3) / dou bl e( ma x( ma x( gr a y3) ) ) *25 5. 0;
cl ear;
s our ce Pi c =i mr ea d(' Test I ma ge 3. j pg');
%g r a y Pi c = mat 2gr a y( s our ce Pi c);
%h a v e zr a y l
%n e w Gr a y Pi c =r gb 2 gr a y( s our ce Pi c); %c o n vert 3 D - 2D
gr a y Pi c =gr a yi mg( s our ce Pi c);
%f i g ur e;
%i ms h o w( gr a y Pi c);
[ m, n] =si ze( gr a y Pi c);
ne wGr a y Pi c =z er os( m, n);
[ m, n] =si ze( ne wGr a y Pi c);
%n e w Gr a y Pi c 2 =r gb 2 gr a y( s our ce Pi c);
s obel Nu m=0;
s obel Thr es hol d =4 0;%1 40; 2 70-80; 3 40
f or j =2: m- 1
f or k=2: n- 1
sobel Nu m=s qrt (( gr a y Pi c(j-1, k +1) +2 * gr a y Pi c(j, k+1) ...
+gr a y Pi c(j +1, k +1)-gr a y Pi c(j-1, k-1)-2*gr a y Pi c(j, k-1)-gr a y Pi c(j +1, k-1) ) ^2 +. ..
( gr ay Pi c(j-1, k-1) +2 * gr a y Pi c(j-1, k) +gr a y Pi c(j-1, k +1)-gr a y Pi c(j +1, k-1) ...
```
- 2*gr a y Pi c(j +1, k)-gr a y Pi c(j +1, k +1) ) ^2);
if( s obel Nu m > s obel Thr es hol d)
ne wGr a y Pi c(j, k) =2 5 5;
el se
ne wGra y Pi c(j, k) =0;
end
end
e n d
fi gur e;
i ms h o w( ne wGr a y Pi c)
titl e(' Sobel ?????? ?')


## In order to detect accurate straight lines, we improve the detection with canny and

### improve canny with Sobel operator instead of [-1,1;-1,1].

### Code:

f unct i on [ m, t het a, sect or, ca nn y 1, ca nn y 2, bi n] = ca nn y 1st ep( sr c, l o wTh , hi gh Th)
[ Ay, Ax, di m ] = si ze( sr c);
if di m>
sr c = r gb2 gr a y( sr c);
e n d
sr c = dou bl e( sr c);
m = zer os( Ay, Ax);
t het a = zer os( Ay, Ax);
s ect or = zer os( Ay, Ax);
c a n n y 1 = zer os( Ay, Ax);%??? ???
c a n n y 2 = zer os( Ay, Ax);%??? ??? ??
bi n = zer os( Ay, Ax);
f or y = 2: ( Ay-1)
f or x = 2: ( Ax-1)
gx = sr c( y-1, x+1) + 2*sr c( y, x +1) + sr c( y +1, x +1) - ...
sr c( y-1, x-1) - 2*sr c( y, x-1) - sr c( y +1, x-1);
gy = sr c( y +1, x-1) + 2*sr c( y +1, x) + sr c( y +1, x +1) ...

- sr c( y-1, x-1) - 2*sr c( y-1, x) - sr c( y-1, x +1) ;
m( y, x) = ( gx^2 +g y ^ 2) ^0. 5 ;
%- - ------------------------------
t het a( y, x) = at and( gx/ gy) ;
t e m = t het a( y, x);
%- - ------------------------------
if (t e m<6 7. 5) &&( t e m>2 2. 5)
sect or ( y, x) = 0;
el sei f (t e m<2 2. 5) &&( t e m>-2 2. 5)
sect or ( y, x) = 3;
el sei f (t e m<-2 2. 5) &&( t e m>-6 7. 5)
sect or ( y, x) = 2;
el se
sect or ( y, x) = 1;
end
%- - ------------------------------
end
e n d
%- - - - ---------------------
%??????
%- - - - --> x
% 2 1 0
% 3 X 3
%y 0 1 2
f or y = 2: ( Ay-1)
f or x = 2: ( Ax-1)
if sect or ( y, x) ==0 %?? - ??
if ( m( y, x) > m( y-1, x +1) ) &&( m( y, x) > m( y +1, x-1) )
ca nn y 1( y, x) = m( y, x);
el se
ca nn y 1( y, x) = 0;
end
el sei f sect or ( y, x) ==1 %?? ??
if ( m( y, x) > m( y-1, x) ) &&( m( y, x) > m( y +1, x) )
ca nn y 1( y, x) = m( y, x);
el se
ca nn y 1( y, x) = 0;
end
el sei f sect or ( y, x) ==2 %?? - ??
if ( m( y, x) > m( y-1, x-1) ) &&( m( y, x) > m( y +1, x +1) )
ca nn y 1( y, x) = m( y, x);
el se
ca nn y 1( y, x) = 0;
end
el sei f sect or ( y, x) ==3 %???
if ( m( y, x) > m( y, x +1) ) &&( m( y, x) > m( y, x-1) )
ca nn y 1( y, x) = m( y, x);
el se
ca nn y1( y, x) = 0;
end
end
end%e n d f or x
e n d%e n d f or y


f or y = 2: ( Ay-1)
f or x = 2: ( Ax-1)
if cann y 1( y, x) <l o wTh %??? ??
ca nn y 2( y, x) = 0;
bi n( y, x) = 0;
cont i nue;
el sei f ca nn y 1( y, x) >hi gh Th %??? ??
ca nn y 2( y, x) = ca nn y 1( y, x);
bi n( y, x) = 1;
cont i nue;
el se %?? ?? ??? 8? ?? ??? ??? ??? ???? ???
t e m =[ ca n n y 1( y-1, x-1), cann y 1( y-1, x), cann y 1( y-1, x +1);
cann y 1( y, x-1), ca nn y 1( y, x), cann y 1( y, x +1) ;
cann y 1( y +1, x-1), cann y 1( y +1, x), cann y 1( y +1, x +1) ];
t e mMa x = ma x(t e m) ;
if t e mMa x( 1) > hi gh Th
ca nn y 2( y, x) = t e mMa x( 1);
bi n( y, x) = 1;
cont i nue;
el se
ca nn y 2( y, x) = 0;
bi n( y, x) = 0;
cont i nue;
end
end
end%e n d f or x
e n d%e n d f or y
e n d%e n d of f unct i on

### (2) detect straight line segments using the Hough Transform

### Hough Transform

### Create (- 90 o^90 o )*(0, rho) space with 0 value, where rho is the sqrt(x2+y2).

### Get non-0 (edge) data of the image after edge detection, get the (x,y)

### Code:


### Hough Peak:

### Find the max(x,y) in certain local region. Eg,(7*7);

```
f unct i on [ h, t het a, r ho] = hou g h Ts( f, dt het a, dr ho)
if nar gi n < 3
dr ho = 1;
e n d
if nar gi n < 2
dt het a = 1;
e n d
f = dou bl e( f);
[ M, N] = si ze( f);
t het a = li ns pac e(-90, 0, ceil ( 90/ dt het a) + 1);
t het a = [t het a -fli pl r(t het a( 2: end - 1) )];
nt het a = l engt h(t het a);
D = s qrt (( M - 1) ^2 + ( N - 1) ^2);
q = ceil ( D/ dr ho) ;
nr ho = 2*q - 1;
r ho = li ns pace(-q*dr ho, q*dr ho, nr ho);
[ x, y, val ] = fi nd( f);
x = x - 1; y = y - 1;
% I ni ti ali ze out put.
h = zer os( nr ho, l engt h(t het a));
% To a v oi d e xcessi ve me mor y us a ge, pr ocess 100 0 no nzer o pi xel
% v al ues at a ti me.
f or k = 1: ceil (l engt h( val )/ 100 0)
first = ( k - 1) *10 0 0 + 1;
l ast = mi n( fi rst +9 9 9, l engt h( x) );
x_ mat ri x = r ep mat ( x( fi r st:l ast ), 1, nt het a);
y_ mat ri x = r ep mat ( y( fi r st:l ast ), 1, nt het a);
val _ mat ri x = r ep mat ( val (fi rst:l ast ), 1, nt het a);
t het a _ mat ri x = r ep mat (t het a, si ze( x_ mat ri x, 1), 1) *pi/ 180;
r ho_ mat ri x = x_ mat ri x. *c os(t het a_ mat ri x) + ...
y_ mat ri x. *si n(t het a _ mat ri x);
sl ope = ( nr ho - 1)/ (r ho( e nd) - r ho( 1) );
r ho_ bi n_i nde x = r oun d( sl ope *( r ho _ mat ri x - r ho( 1) ) + 1);
t het a _bi n_i nde x = r ep mat ( 1: nt het a, si ze( x_ mat ri x, 1), 1);
h = h + f ull ( s par se( r ho_ bi n_i nde x(: ), t het a _bi n_i nde x(: ), ...
val _ mat ri x(: ), nr ho, nt het a));
e n d
f unct i on [r, c, hne w] = hpea k( h, nho o d)
if nar gi n < 2
nho o d = si ze( h)/ 50;
% Ma ke s ur e t he nei ghb or ho o d si ze i s odd.
nho o d = ma x( 2*c eil ( nho o d/ 2) + 1, 1);
e n d
h ma x = ma x( h( : ));
h ne w = h; r = []; c = [];
[ h m, hn] =si ze( h);
l ocal ma xa =8 0;%2 n d 80; 3r d 5
l ocal ma x b =1 0;%2 n d 10; 3r d 5
f or ha =1 +l oc al ma xa: l ocal ma x a * 2: h m-l ocal ma x a
f or hb =1 +l ocal ma x b: l ocal ma x b * 2: hn-l ocal ma x b
hne wp =h ne w( ha-l ocal ma xa: ha +l ocal ma xa, hb-l ocal ma x b: hb +l ocal ma x b);
if( ma x( hne wp( : )) ~=0 &&ma x( h ne wp( : )) >=h ma x * 0. 2)%2 n d 0. 2 3r d0. 15
[ p, q] =f i nd( hne wp = = ma x( h ne wp( : )));
p=p +ha-l ocal ma xa-1;
q=q +h b-l ocal ma x b-1;
p=p( 1); q =q( 1);
r( end +1) =p; c( e nd +1) =q;
end
end
e n d
```

### The result of straight lines detection:

### Then thin the number of lines:

### EG:

### thin the number lines from 65->


### get the lines couple whose theta was like,

### And get the lines couple’s points where they cross each other.

### Calculate the function of two variable equation

### Detect point of parallelograms

### EG:


### (3) detect parallelograms from the straight-line segments detected in step (2).

### Firstly, determine pairs of parallel lines and from the parallel lines determine candidate

### parallelograms by computing the lines' intersection points.

### Then compute the number of edge points (in percentage) that are present on each of

### the four sides of the candidate parallelograms; if the percentage is high, it is a

### parallelogram.

### All parallelogram:

### parallelogram that is accurate:


### Result and step of the next two img:

### 1.straight lines:

### 2.parallelogram:


### Improve:

### Extra Credits (10 points). This part is optional.





