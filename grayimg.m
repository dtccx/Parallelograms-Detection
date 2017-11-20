function [gray]=grayimg(img)
%img=imread('TestImage1c.jpg');
R=double(img(:,:,1));
G=double(img(:,:,2));
B=double(img(:,:,3));
gray=0.30*R + 0.59*G + 0.11*B;
%fprintf('%f',max(max(gray3)));
%gray=double(gray3)/double(max(max(gray3)))*255.0;
