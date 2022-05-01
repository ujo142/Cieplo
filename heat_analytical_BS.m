%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     %
%       Autor:  Beniamin Sereda       %
%       Tytul:  Projekt na cieplo     %
%       Wersja: Analityczna           %
%                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Skrypt dla kazdego kroku przestrzennego w petli 
% liczy sume szeregu m elementow, to ten szereg An
% w funkcji w(x,t). Nastepnie dodaje go do v(x) w danym kroku.
% Ostatni krok to wyzerowanie zmiennej pomocniczej i przejscie do kroku
% nastepnego



%%%%%%%%   Stale i zmienne   %%%%%%%%
xmin=0;       % Lewa krawedz dziedziny
xmax=2;       % Prawa krawedz dziedziny
nx=520;       % Ilosc punktow na siatce

tmin=0;       % Czas poczatkowy
tmax=40000;   % Czas koncowy
nt=520;       % Ilosc korkow czasowych

x=linspace(xmin,xmax,nx);     % Dziedzina przestrzenna
t=linspace(tmin,tmax,nt);     % Dziedzina czasowa

global T0;    % Temperatura początkowa pręta na (0,L)
global H;     % Stała przy wyrazie na zrodla ciepla wew.
global L;     % Dlugosc dziedziny
global a;     % wsp. wyrownania temp.
global m;     % Ilosc wyrazow w rozwiniecu sumy wsp. An
global pom;   % Zmienne pomocnicza

T0 = 20;
H=12.66;
L=xmax;
a=0.00001;
m = 150;
pom = 0;

T = [nx, nt]; % Tworzenie siatki dla przyspieszenia obliczen



%%%%%%%%   Glowna petla skryptu   %%%%%%%%
for i=1:nt
    for j=1:nx
        for k=1:m
            pom = pom + An(k)*sin(k*x(j)*pi/L).*exp(-a*k^2*pi^2*t(i)/(L^2));
        end
        T(i,j) = (H/12)*(x(j).^4 - 2*L*x(j).^3+x(j)*L^3) + pom;
        pom=0;
    end
    
end



%%%%%%%%   Tworzenie wykresu   %%%%%%%%
pcolor(x, t, T);
colormap hot
shading flat; 
colorbar 
xlabel('x [m]'); 
ylabel('t [s]');
caxis([0 20]);



%%%%%%%%   Funkcje   %%%%%%%%
function wynik = An(n)
    global  L;
    global T0;
    global H;

    wynik = L*((pi^3*H*L^4*n^3+12*pi*H*L^4*n)*sin(pi*n)...
    + (24*H*L^4-12*pi^4*T0*n^4)*cos(pi*n)...
    + 12*pi^4*T0*n^4-24*H*L^4)/(12*pi^5*n^5);
end

