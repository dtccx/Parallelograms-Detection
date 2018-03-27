close all;
clear;
I  = imread('test1sobel.jpg');
[m,n]=size(I);
%I=rgb2gray(I2);
figure;
%subplot(1,2,1);
imshow(I);
[H,T,R] = houghTs(I);%??????????????H hough space I, R p
%[H,T,R]=hough(I,'RhoResolution',0.2,'ThetaResolution',0.2);

%axis on,axis square,hold on;
%P  = houghpeaks(H,10);
%x = T(P(:,2)); 
%y = R(P(:,1));
%plot(x,y,'s','color','white');%?????
%lines=houghlines(I,T,R,P);%????
[r,c]=hough_peaks(H,5);
lines=hough_line(I,T,R,r,c);
figure;
%subplot(1,2,2);
imshow(I), hold on;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',4,'Color','green');%????
    %plot(xy(1,1),xy(1,2),'x','LineWidth',4,'Color','yellow');%??
    %plot(xy(2,1),xy(2,2),'x','LineWidth',4,'Color','red');%??
end