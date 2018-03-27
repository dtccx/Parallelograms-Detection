clear;
sourcePic=imread('TestImage3.jpg');
grayPic=mat2gray(sourcePic);
[m,n,l]=size(grayPic);%have zray l
gray2=rgb2gray(sourcePic);%convert 3D - 2D
newGrayPic=medfilt2(gray2);
figure,imshow(newGrayPic);
sobelNum=0;
sobelThreshold=0.17;%2nd 0.3-0.35----- 3rd
for j=2:m-1 
    for k=2:n-1
        sobelNum=abs(grayPic(j-1,k+1)+2*grayPic(j,k+1) ...
            +grayPic(j+1,k+1)-grayPic(j-1,k-1)-2*grayPic(j,k-1)-grayPic(j+1,k-1))+ ...
            abs(grayPic(j-1,k-1)+2*grayPic(j-1,k)+grayPic(j-1,k+1)-grayPic(j+1,k-1) ...
            -2*grayPic(j+1,k)-grayPic(j+1,k+1));
        if(sobelNum > sobelThreshold)
            newGrayPic(j,k)=255;
        else
            newGrayPic(j,k)=0;
        end
    end
end
for a=1:m
    newGrayPic(a,1)=0;
    newGrayPic(a,n)=0;
end
for b=1:n
    newGrayPic(1,b)=0;
    newGrayPic(m,b)=0;
end
imwrite(newGrayPic,'test3sobel.jpg');
figure;
imshow(newGrayPic);