clear
clc;
imgsrc = imread('TestImage2c.jpg');
[y, x, dim] = size(imgsrc);

%??????
if dim>1
    imgsrc = rgb2gray(imgsrc);
end

sigma = 1;
gausFilter = fspecial('gaussian', [3,3], sigma);
img= imfilter(imgsrc, gausFilter, 'replicate');

zz = double(img);

 %----------------------------------------------------------
 [m, theta, sector, canny1,  canny2, bin] = canny1step(img, 20 , 50);%2nd 20 50


I=edge(img,'Canny',0.10);%2nd0.10 3rd 0.13
%I=bin;
figure(2)
imshow(I);

hold on
[H,theta, rho]=houghTs(I,0.5,0.5);
%[r,c,hnew]=hough_peaks(H,800);
[rr,cc,hnew]=hpeak(H);
%[r,c]=hmax(H);
%lines=hough_line(I,theta,rho,r,c);
%imshow(H);

%thin lines number
r=[];c=[];
for a=1:length(rr)-1
    flag=1;
    for b=a+1:length(rr)
        if(abs(cc(a)-cc(b))<=10&&abs(rr(a)-rr(b))<=15)%2nd 10/15 %3rd 26/22(14)
            flag=0;
            break;
        end
    end
    if(flag==1)
        r(end+1)=rr(a);
        c(end+1)=cc(a);
    end
end
r(end+1)=rr(length(rr));
c(end+1)=cc(length(cc));

% for a=1:length(r)
%     cbin=c(a);
%     thetac=theta(cbin)*pi/180;
%     rhoc=rho(r(a));
%     if(thetac<90&&thetac>0)
%         plot([0 rhoc/sin(thetac)],[rhoc/cos(thetac) 0],'LineWidth',1,'Color','Red');
%     end
%     if(thetac>-90&&thetac<0)
%         plot([x,rhoc/sin(thetac)],[(rhoc-x*sin(thetac))/cos(thetac),0], ...
%             'LineWidth',1,'Color','Red');
%     end
% end

paradiff=24; %2nd 24; 3rd 20
%pingxingxian
para1=[];para2=[];
for a=1:length(r)-1
    for b=a+1:length(r)
        if(abs(c(a)-c(b))<=paradiff&&abs(r(a)-r(b))>10)%2nd 10;; 3rd 5
            para1(end+1)=a;
            para2(end+1)=b;
        end
    end
end

%test para lines
% for p1=1:length(para1)
%     a=para1(p1);
%     cbin=c(a);
%     thetac=theta(cbin)*pi/180;
%     rhoc=rho(r(a));
%     if(thetac<90&&thetac>0)
%         plot([0 rhoc/sin(thetac)],[rhoc/cos(thetac) 0],'LineWidth',1,'Color','Red');
%     end
%     if(thetac>-90&&thetac<0)
%         plot([x,rhoc/sin(thetac)],[(rhoc-x*sin(thetac))/cos(thetac),0], ...
%             'LineWidth',1,'Color','Red');
%     end
% end
% 
% for p2=1:length(para2)
%     a=para2(p2);
%     cbin=c(a);
%     thetac=theta(cbin)*pi/180;
%     rhoc=rho(r(a));
%     if(thetac<90&&thetac>0)
%         plot([0 rhoc/sin(thetac)],[rhoc/cos(thetac) 0],'LineWidth',2,'Color','Blue');
%     end
%     if(thetac>-90&&thetac<0)
%         plot([x,rhoc/sin(thetac)],[(rhoc-x*sin(thetac))/cos(thetac),0], ...
%             'LineWidth',2,'Color','Blue');
%     end
% end

x1=[];x2=[];x3=[];x4=[];
y1=[];y2=[];y3=[];y4=[];
for aa=1:length(para1)-1
    for bb=aa+1:length(para1)
        a=para1(aa);%get the ath
        a2=para2(aa);%pingxingxian
        b=para1(bb);
        b2=para2(bb);
        %a value
        cbin=c(a);
        thetaa=theta(cbin)*pi/180;
        rhoa=rho(r(a));
        %a2 value
        cbina2=c(a2); thetaa2=theta(cbina2)*pi/180; rhoa2=rho(r(a2));
        %b value
        cbinb=c(b);
        thetab=theta(cbinb)*pi/180;
        rhob=rho(r(b));
        %b2 value
        cbinb2=c(b2);
        thetab2=theta(cbinb2)*pi/180;
        rhob2=rho(r(b2));
        %they cross each other, get the point
        if(abs(cbin-cbinb)~=0)
            [xx1,yy1]=getpoint(thetaa,thetab,rhoa,rhob);%ab point
            [xx2,yy2]=getpoint(thetaa,thetab2,rhoa,rhob2);%ab2
            [xx3,yy3]=getpoint(thetaa2,thetab,rhoa2,rhob);%a2b
            [xx4,yy4]=getpoint(thetaa2,thetab2,rhoa2,rhob2);%a2b2
            if(xx1>=1&&xx1<=y&&yy1>=1&&yy1<=x&& ...
                    xx2>=1&&xx2<=y&&yy2>=1&&yy2<=x&& ...
                    xx3>=1&&xx3<=y&&yy3>=1&&yy3<=x&& ...
                    xx4>=1&&xx4<=y&&yy4>=1&&yy4<=x)
                x1(end+1)=xx1;y1(end+1)=yy1;
                x2(end+1)=xx2;y2(end+1)=yy2;
                x3(end+1)=xx3;y3(end+1)=yy3;
                x4(end+1)=xx4;y4(end+1)=yy4;
                plot(yy1,xx1,'*');
                plot(yy2,xx2,'d');
                plot(yy3,xx3,'o');
                plot(yy4,xx4,'s');
            end
        end
    end
end

%2-1;3-1;4-3;4-2
minlen=50;%2nd 50;3rd min10
for xa=1:length(x1)
    k1=(y2(xa)-y1(xa))/(x2(xa)-x1(xa));%k2_1
    k2=(y3(xa)-y1(xa))/(x3(xa)-x1(xa));
    k3=(y4(xa)-y3(xa))/(x4(xa)-x3(xa));%k4-3
    k4=(y4(xa)-y2(xa))/(x4(xa)-x2(xa));
    length1=((y2(xa)-y1(xa))^2+(x2(xa)-x1(xa))^2)^0.5;
    length2=((y3(xa)-y1(xa))^2+(x3(xa)-x1(xa))^2)^0.5;
    length3=((y4(xa)-y3(xa))^2+(x4(xa)-x3(xa))^2)^0.5;
    length4=((y4(xa)-y2(xa))^2+(x4(xa)-x2(xa))^2)^0.5;
    if(length1<=minlen||length2<=minlen||length3<=minlen||length4<=minlen)
         continue;
    end
    count1=0;count2=0;count3=0;count4=0;
    sign=1;
    if x2(xa)<x1(xa)
        sign=-1;
    end
    %compute edge 1
    n=0;
    yed1=y1(xa);
    for ed1=x1(xa):sign:x2(xa)
        if(I(ed1,yed1)~=0||I(ed1-1,yed1)~=0||I(ed1+1,yed1)~=0||I(ed1,yed1+1)~=0 ...
                ||I(ed1,yed1-1)~=0||I(ed1-1,yed1+1)~=0||I(ed1-1,yed1-1)~=0|| ...
                I(ed1+1,yed1+1)~=0||I(ed1+1,yed1-1)~=0)
            count1=count1+1;
        end
        n=n+1;
        yed1=round(y1(xa)+sign*k1*n);
     end
%     if(count1>=length1*0.4)
%         plot([y1(xa),y2(xa)],[x1(xa),x2(xa)],'LineWidth',2,'Color','Yellow');
%     end


    %compute edge 2
    sign=1;
    if x3(xa)<x1(xa)
        sign=-1;
    end
    yed1=y1(xa);
    n=0;
    for ed1=x1(xa):sign:x3(xa)
        if(I(ed1,yed1)~=0||I(ed1-1,yed1)~=0||I(ed1+1,yed1)~=0||I(ed1,yed1+1)~=0 ...
                ||I(ed1,yed1-1)~=0||I(ed1-1,yed1+1)~=0||I(ed1-1,yed1-1)~=0|| ...
                I(ed1+1,yed1+1)~=0||I(ed1+1,yed1-1)~=0)
            count2=count2+1;
        end
        n=n+1;
        yed1=round(y1(xa)+sign*k2*n);
    end
%     if(count2>=length2*0.4)
%         plot([y1(xa),y3(xa)],[x1(xa),x3(xa)],'LineWidth',2,'Color','Green');
%     end
%     
    %compute edge 3
    sign=1;
    if x4(xa)<x3(xa)
        sign=-1;
    end
    yed1=y3(xa);
    n=0;
    for ed1=x3(xa):sign:x4(xa)
        if(I(ed1,yed1)~=0||I(ed1-1,yed1)~=0||I(ed1+1,yed1)~=0||I(ed1,yed1+1)~=0 ...
                ||I(ed1,yed1-1)~=0||I(ed1-1,yed1+1)~=0||I(ed1-1,yed1-1)~=0|| ...
                I(ed1+1,yed1+1)~=0||I(ed1+1,yed1-1)~=0)
            count3=count3+1;
        end
        n=n+1;
        yed1=round(y3(xa)+sign*k3*n);
    end
%     if(count3>=length3*0.4)
%         plot([y3(xa),y4(xa)],[x3(xa),x4(xa)],'LineWidth',2,'Color','Red');
%     end
%     
    %compute edge 4
    sign=1;
    if x4(xa)<x2(xa)
        sign=-1;
    end
    n=0;
    yed1=y2(xa);
    for ed1=x2(xa):sign:x4(xa)
        if(I(ed1,yed1)~=0||I(ed1-1,yed1)~=0||I(ed1+1,yed1)~=0||I(ed1,yed1+1)~=0 ...
                ||I(ed1,yed1-1)~=0||I(ed1-1,yed1+1)~=0||I(ed1-1,yed1-1)~=0|| ...
                I(ed1+1,yed1+1)~=0||I(ed1+1,yed1-1)~=0)
            count4=count4+1;
            
        end
        n=n+1;
        yed1=round(y2(xa)+sign*k4*n);
    end
%     if(count4>=length4*0.2)
%         plot([y2(xa),y4(xa)],[x2(xa),x4(xa)],'LineWidth',2,'Color','Blue');
%     end
        
    minn=25;%2nd 25; 3rd 1
    if(count1<=minn||count2<=minn||count3<=minn||count4<=minn)
        continue;
    end
    if((count1+count2+count3+count4)>=(length1+length2+length3+length4)*0.4 ...
       &&count1>=length1*0.2&&count2>=length2*0.15&&count3>=length3*0.2&& ...
        count4>=length4*0.2) %2nd 0.4,0.2,0.29(0.15 1st),0.2,0.2;;;;;(3rd 0.15~0.25,/,/,/,/)
        plot([y1(xa),y2(xa)],[x1(xa),x2(xa)],'LineWidth',2,'Color','Yellow');
        plot([y1(xa),y3(xa)],[x1(xa),x3(xa)],'LineWidth',2,'Color','Green');
        plot([y3(xa),y4(xa)],[x3(xa),x4(xa)],'LineWidth',2,'Color','Red');
        plot([y2(xa),y4(xa)],[x2(xa),x4(xa)],'LineWidth',2,'Color','Blue');
    end
end

