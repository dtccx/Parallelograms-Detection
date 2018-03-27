img3=imread('TestImage3.jpg');
img4=rgb2gray(img3);
img=medfilt2(img4);
img2=edge(img,'Canny',0.13);%2 0.182
figure;
imshow(img2);
imwrite(img2,'test3canny.jpg');