# Solution to Equ. 64  to 68 of https://pubs.usgs.gov/wri/wri034267/wri03_4267.pdf
library(kelvin)
library(rootSolve)
s = 0.0000001 #storage coefficient
rw = 0.08333333 # in ft
rc = 0.33333333 # in ft
Theta = -30.97
ThetaRad = Theta/180*pi
SP = s*(rc/rw)^2
Per = 4.46E+04 #x is T'
fun <- function (x) (ThetaRad + atan((pi/x*(Ker((2*pi*SP/x)^0.5)))/(1-pi/x*Kei((2*pi*SP/x)^0.5))))
#((1-pi/x*Kei((2*pi*SP/x)^0.5)))^2+(pi/x*(Ker((2*pi*SP/x)^0.5))^2))^(-0.5))
curve(fun(x), 0.000057, 0.1)
abline(h = 0, lty = 3)
TP <- uniroot(fun, c(0.000057, 0.1), tol =0.000000000000000000001)
#fun(all)
Tr = TP$root*(rc^2)/Per #Transmissivity
Tr
