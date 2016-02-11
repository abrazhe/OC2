TITLE Na current for [Spencer et al., 2012]'s octopus cell model initial segment. 

NEURON {
    SUFFIX NaSp
    USEION na READ ena WRITE ina
    RANGE gnaspbar, gnasp, ina
    GLOBAL minf, mtau, hinf, htau
}

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
}

PARAMETER {
    celsius = 33 (degC) : for qt = q10^((celsius-22)/10)
    ena = 55 (mV)
    gnaspbar = 4.2441 (mho/cm2)
    q10 = 3
}
ASSIGNED {
    v (mV)
    ina (mA/cm2)
    gnasp (mho/cm2)
    minf
    hinf
    mtau (ms)
    htau (ms)
}

STATE {
    m h
}


BREAKPOINT {
    SOLVE states METHOD cnexp
    gnaps = gnaspbar*(m^3)*h
    ina = gnasp*(v-ena)
}

INITIAL {
    h = hinf
    m = mimnf
}
DERIVATIVE states {
    params(v)
    m' = qt*(minf-m)/mtau
    h' = qt*(hinf-h)/htau
}

UNITSOFF
PROCEDURE params(v) {
    
    LOCAL hlp
    TABLE minf, hinf, mtau, htau FROM -100 TO 100 WITH 200
    
    q10 = 3^((celsius - 22)/10)
    
    minf = 1/(1-(1.11*(v+58)/(v+49))*(exp(-(v+49)/3)-1)/(exp((v+58)/20)-1)) 
    mtau = 1/(0.4*((v+58)/(exp((v+58)/20)-1)) - 0.36*((v+49)/(exp(-(v+49)/3)-1))
    
    hlp = 2.4/(1+exp((v+68)/3))  + 0.8/(1+exp(v+61.3))
    hinf = hlp/(hlp + 3.6/(1+exp(-(v+21)/10)))
    htau = 1/(hlp + 3.6/(1+exp(-(v+21)/10)))
}
UNITSON


