clear;
sourcePic=imread('TestImage3.jpg');
%grayPic=mat2gray(sourcePic);

%have zray l
%newGrayPic=rgb2gray(sourcePic);%convert 3D - 2D
grayPic=grayimg(sourcePic);
%figure;
%imshow(grayPic);
[m,n]=size(grayPic);
newGrayPic=zeros(m,n);
[m,n]=size(newGrayPic);
%newGrayPic2=rgb2gray(sourcePic);
sobelNum=0;
sobelThreshold=40;%1 40; 2 70-80; 3 40
for j=2:m-1 
    for k=2:n-1
        sobelNum=sqrt((grayPic(j-1,k+1)+2*grayPic(j,k+1) ...
            +grayPic(j+1,k+1)-grayPic(j-1,k-1)-2*grayPic(j,k-1)-grayPic(j+1,k-1))^2+ ...
            (grayPic(j-1,k-1)+2*grayPic(j-1,k)+grayPic(j-1,k+1)-grayPic(j+1,k-1) ...
            -2*grayPic(j+1,k)-grayPic(j+1,k+1))^2);
        if(sobelNum > sobelThreshold)
            newGrayPic(j,k)=255;
        else
            newGrayPic(j,k)=0;
        end
    end
end
% for a=1:m
%     newGrayPic(a,1)=0;
%     newGrayPic(a,n)=0;
% end
% for b=1:n
%     newGrayPic(1,b)=0;
%     newGrayPic(m,b)=0;
% end
figure;
imshow(newGrayPic)
%imwrite(newGrayPic,'test2-1sobel.jpg');


title('Sobel???????')