function [r, c, hnew] = hmax(h)
hmax=max(h(:));
hnew = h; r = []; c = [];
[hm, hn]=size(h);
localmaxa=150;
localmaxb=10;
for ha=1::hm
    for hb=1:hn
        if(hnew(ha,hb)>=hmax*0.2)
            r(end+1)=ha;c(end+1)=hb;
        end
      

    end
end