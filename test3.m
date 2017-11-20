I  = imread('test3canny.jpg');
[m,n]=size(I);
[H,theta, rho]=houghTs(I,0.5,0.5);
%imshow(theta,rho,H,[ ],'notruesize'),axis on, axis normal
%xlabel('\theta'),ylabel('\rho')
imshow(I);
hold on
[r,c]=hough_peaks(H,23);
lines=hough_line(I,theta,rho,r,c);
%imshow(H);
p_diff=20;
theta_diff=8;
len_diff=20;

for a=1:length(lines)
    xy = [lines(a).point1; lines(a).point2];
    plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Red');
end
 
%thin
oline = [];
for a=length(lines):-1:1
    flag=1;
    for b=a-1:-1:1
        if(abs(lines(a).rho-lines(b).rho)<=p_diff&&abs(lines(a).theta-lines(b).theta) ...
                <=theta_diff)%same line
            flag=0;%same
        %if(lines(a).point1-lines(b).point1&&lines(a).point2-lines(b).point2)
        %    flag=0;
        %end
        end
    end
    if(flag==1)
        oline(end+1)=a;
        %fprintf(b);
%         xy = [lines(a).point1; lines(a).point2];
%         fprintf("%d",a);
%         plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Red');
    end
end

for c=1:length(oline)
    d=oline(c);
    xy = [lines(d).point1; lines(d).point2];
    plot(xy(:,2),xy(:,1),'LineWidth',2,'Color','Red');
end



%             plot(lines(k).point1[0,1],'r.','MarkerSize',20);
%             plot(lines(k).point2,'r.','MarkerSize',20);
%             text(,max_text);


for i=1:length(oline)-1
    for j=i+1:length(oline)
        a=oline(i);
        b=oline(j);
        if(abs(lines(a).length-lines(b).length)<=len_diff&&abs(lines(a).theta ...
                -lines(b).theta)<=theta_diff&&abs(lines(a).rho-lines(b).rho)>=p_diff)
            para=[lines(a).point1;lines(a).point2];
            para2=[lines(b).point1;lines(b).point2];
            fprintf('%d,%d\n',a,b);
            plot(para(:,2),para(:,1),'LineWidth',2,'Color','Yellow');
            plot(para2(:,2),para2(:,1),'LineWidth',2,'Color','Blue');
        end
    end
end