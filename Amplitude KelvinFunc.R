# Solution to Equ. 64  to 68 of https://pubs.usgs.gov/wri/wri034267/wri03_4267.pdf
library(kelvin)
library(rootSolve)
s = 0.0001 #storage coefficient
rw = 0.08333333 # well radius in ft
rc = 0.33333333 # well casing in ft
A = 0.0057 # Amplitude Ratio
SP = s*(rc/rw)^2 # S'
Per = 4.47E+04 # x is T' and Per is period
fun <- function (x) (A-(((1-pi/x*Kei((2*pi*SP/x)^0.5)))^2+(pi/x*(Ker((2*pi*SP/x)^0.5))^2))^(-0.5))
curve(fun(x), 0.005, 0.2)
abline(h = 0, lty = 3)
TP <- uniroot(fun, c(0.005, 0.2), tol =0.000000000000000000001)
#fun(all)
Tr = TP$root*(rc^2)/Per #Transmissivity
Tr	
