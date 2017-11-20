clear
clc;
imgsrc = imread('TestImage2c.jpg');
[y, x, dim] = size(imgsrc);

hough
%??????
if dim>1
    imgsrc = rgb2gray(imgsrc);
end

sigma = 1;
gausFilter = fspecial('gaussian', [3,3], sigma);
img= imfilter(imgsrc, gausFilter, 'replicate');

zz = double(img);

 %----------------------------------------------------------
 [m, theta, sector, canny1,  canny2, bin] = canny1step(img, 33 , 57);
%  [msrc, thetasrc, sectorsrc, c1src,  c2src, binsrc] = canny1step(imgsrc, 22);


[xx, yy] = meshgrid(1:x, 1:y);

% figure(1)
%     imshow(bin);%????bin
% figure(2)    
%     subplot(1,3,1);
%         imshow(img);%?????
%     subplot(1,3,2);
%         imshow(uint8(canny1));%??????
%     subplot(1,3,3);
%         imshow(uint8(canny2));%??

I=bin;
figure(2)
imshow(I);
hold on
[H,theta, rho]=houghTs(I,0.5,0.5);
[r,c]=hough_peaks(H,300);
lines=hough_line(I,theta,rho,r,c);
%imshow(H);
p_diff=20;
theta_diff=8;
len_diff=15;




%thin
oline = [];
for a=length(lines):-1:1
    flag=1;
    for b=a-1:-1:1
        if(abs(lines(a).rho-lines(b).rho)<=p_diff&&abs(lines(a).theta-lines(b).theta) ...
                <=theta_diff)%same line
            %lines(a).point2+=lines(a).point2;
            flag=0;% same
        end
%         if(lines(a).point1(1)-lines(b).point1(1)<=2 ...
%                 &&lines(a).point1(2)-lines(b).point1(2)<=2&& ...
%                 lines(a).point2(1)-lines(b).point2(1)<=2&& ...
%                 lines(a).point2(2)-lines(b).point2(2)<=2)
%             flag=0;
%         end
    end
    if(flag==1)
        oline(end+1)=a;
        %fprintf(b);
%         xy = [lines(a).point1; lines(a).point2];
%         plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Red');
    end
end


for c=1:length(oline)
    d=oline(c);
    m1a=lines(d).point1(1);
    na=lines(d).point1(2);
    xa=lines(d).point2(1);
    ya=lines(d).point2(2);
    count=0;
    lengthl=sqrt(power((xa-m1a),2)+power((ya-na),2));
    %point1 point2 trans
    if(m1a>xa)
        ttt=m1a;
        m1a=xa;
        xa=ttt;
        ttt2=na;
        na=ya;
        ya=ttt2;
    end
    %compute k
    kl=(ya-na)/(xa-m1a);
    fprintf("%f",kl);
    x=fix(xa);
    m1=fix(m1a);
    for line_x=m1:x-1
        if(I(line_x,fix(na))==1||I(line_x,fix(na)-1)==1||I(line_x-1,fix(na)-1)==1 ...
                ||I(line_x-1,fix(na)-1)==1||I(line_x-1,fix(na))==1)
            count=count+1;
            na=na+kl;
        end
    end
    
    if(count>=lengthl*0.6&&lengthl>=40)
        xy = [lines(d).point1; lines(d).point2];
        plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Blue');
    end
end

% for d=1:length(lines)
%     m1a=lines(d).point1(1);
%     na=lines(d).point1(2);
%     xa=lines(d).point2(1);
%     ya=lines(d).point2(2);
%     count=0;
%     lengthl=sqrt(power((xa-m1a),2)+power((ya-na),2));
%     %point1 point2 trans
%     if(m1a>xa)
%         ttt=m1a;
%         m1a=xa;
%         xa=ttt;
%         ttt2=na;
%         na=ya;
%         ya=ttt2;
%     end
%     %compute k
%     kl=(ya-na)/(xa-m1a);
%     fprintf("%f",kl);
%     x=fix(xa);
%     m1=fix(m1a);
%     for line_x=m1:x
%         if(I(line_x,fix(na))~=0||I(line_x+1,fix(na)+1)~=0||I(line_x-1,fix(na)-1)~=0 ...
%                 ||I(line_x+1,fix(na)-1)~=0||I(line_x-1,fix(na)+1)~=0)
%             count=count+1;
%             na=na+kl;
%         end
%     end
%     
%     if(count>=lengthl*0.4)
%         xy = [lines(d).point1; lines(d).point2];
%         plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Blue');
%     end
% end
        
       

for e=1:length(lines)
    xy = [lines(e).point1; lines(e).point2];
    plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Red');
end
%     
% for c=1:length(oline)
%     d=oline(c);
%     xy = [lines(d).point1; lines(d).point2];
%     plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Red');
% end



%             plot(lines(k).point1[0,1],'r.','MarkerSize',20);
%             plot(lines(k).point2,'r.','MarkerSize',20);
%             text(,max_text);


% for i=1:length(oline)-1
%     for j=i+1:length(oline)
%         a=oline(i);
%         b=oline(j);
%         if(abs(lines(a).length-lines(b).length)<=len_diff&&abs(lines(a).theta ...
%                 -lines(b).theta)<=theta_diff&&abs(lines(a).rho-lines(b).rho)>=p_diff)
%             para=[lines(a).point1;lines(a).point2];
%             para2=[lines(b).point1;lines(b).point2];
%             fprintf('%d,%d\n',a,b);
%             plot(para(:,2),para(:,1),'LineWidth',2,'Color','Yellow');
%             plot(para2(:,2),para2(:,1),'LineWidth',2,'Color','Blue');
%         end
%     end
% end

