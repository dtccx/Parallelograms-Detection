function [r, c, hnew] = hpeak(h, nhood)
if nargin < 2
   nhood = size(h)/50;
   % Make sure the neighborhood size is odd.
   nhood = max(2*ceil(nhood/2) + 1, 1);
end

hmax=max(h(:));
hnew = h; r = []; c = [];
[hm, hn]=size(h);
localmaxa=80;%2nd 80; 3rd 5
localmaxb=10;%2nd 10; 3rd 5
for ha=1+localmaxa:localmaxa*2:hm-localmaxa
    for hb=1+localmaxb:localmaxb*2:hn-localmaxb

        hnewp=hnew(ha-localmaxa:ha+localmaxa,hb-localmaxb:hb+localmaxb);
        if(max(hnewp(:))~=0&&max(hnewp(:))>=hmax*0.2)%2nd 0.2 3rd0.15
            [p,q]=find(hnewp==max(hnewp(:)));
        p=p+ha-localmaxa-1;
        q=q+hb-localmaxb-1;
        p=p(1);q=q(1);
        r(end+1)=p;c(end+1)=q;
        end     
    end
end