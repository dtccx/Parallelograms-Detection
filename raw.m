% dim1=756;
% dim2=1008;
dim1=756;
dim2=1008;
fid = fopen('TestImage2c.raw');
img = fread(fid,[dim2*3, dim1*9]);
figure,imshow(img,[]);
status = fclose(fid);