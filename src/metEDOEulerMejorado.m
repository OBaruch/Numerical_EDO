clear all;
clc;
d=572;
f=@(t,y)(y-(((t.^3-d*t.^2-d*(d+2)*t+d.^3+2*d.^2).*(exp((-t.^2)/(2*d))))/(d)));
h=10.^(-3);

y(d)=0;

i=1;
t(1)=d;
%Solución numérica.
while(t(i)<=d+2)
    y1(i)=y(i)+h*f(t(i),y(i));
    y(i+1)=y(i)+(h/2)*(f(t(i),y(i))+f(t(i)+h,y1(i)));
    t(i+1)=t(i)+h;
    i=i+1;
end


%Solución analítica.
sol=(t-d).^2.*exp(-t.^2/(2*d));

%Graficacion
plot(t,y,'b',t,sol,'r*')
%plot(t,y,'b')
 legend('Solución numérica (aproximada)','Solución analítica (exacta)')
 xlabel(['Método de Euler mejorado'])


