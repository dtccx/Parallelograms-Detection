function [x,y]=getpoint(theta1,theta2,p1,p2)
x=(p2-p1*sin(theta2)/sin(theta1))/(cos(theta2)-sin(theta2)/tan(theta1));
y=(p1-x*cos(theta1))/sin(theta1);
x=fix(x);
y=fix(y);
