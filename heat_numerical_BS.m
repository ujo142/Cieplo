%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    %
%       Autor:  Beniamin Sereda      %
%       Tytul:  Projekt na cieplo    %
%       Wersja: Numerycznie          %
%                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%   Stale i zmienne   %%%%%%%%
xmin=0;       % Lewa krawedz dziedziny
xmax=2;       % Prawa krawedz dziedziny
nx=520;       % Ilosc punktow na siatce

tmin=0;       % Czas poczatkowy
tmax=40000;   % Czas koncowy
nt=520;       % Ilosc korkow czasowych

x=linspace(xmin,xmax,nx);     % Dziedzina przestrzenna
t=linspace(tmin,tmax,nt);     % Dziedzina czasowa

global H;     % Stała przy wyrazie na zrodla ciepla wew.
global L;     % Dlugosc dziedziny
global a;     % wsp. wyrownania temp.
global ro;

H=12.66;
L = 2;
a = 0.00001;
ro = 7900;
m = 0;



%%%%%%%%   Rozwiazanie PDE   %%%%%%%%
T = pdepe(m, @heatpde, @heatic, @heatbc, x, t);



%%%%%%%%   Tworzenie wykresu   %%%%%%%%
figure(1);
colormap hot
imagesc(x, t ,T)
colorbar
xlabel('x [m]')
ylabel('t [s]')
set(gca,'YDir','normal')
caxis([0 20]);



%%%%%%%%   Funkcje   %%%%%%%%
function [c,f,s] = heatpde(x,t,T,dTdx)
    global a;
    global H;
    
    c = 1/a;
    f = dTdx;
    s = H.*(-x.^2+2*x);
end

function u = heatic(x)
    u = 20;   % Temperatura początkowa
end

function [pl,ql,pr,qr] = heatbc(xl, Tl, xr, Tr, t)
    pl = Tl;  % Lewy warunke brzegowy
    ql = 0;
    pr = Tr;  % Prawy warunek brzegowy
    qr = 0;

end