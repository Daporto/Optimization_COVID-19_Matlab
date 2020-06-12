function dy = model(t,y,p)
%y = (S I R)
%P = (b g)
N = y(1)+y(2)+y(3);
dy(1,1) = -(p(1)*y(2)*y(1))/N; %-(bIS)/N
dy(2,1) = ((p(1)*y(2)*y(1))/N) - p(2)*y(2); %((bIS)/N)-gI
dy(3,1) =  p(2)*y(2); %gI
end
    