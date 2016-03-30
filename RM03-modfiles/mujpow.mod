TITLE mujpow.mod energy consumption calculator based on Moujahid & D'Anjou

UNITS {
    (mA) = (milliamp)
    (mV) = (millivolt)
    (S) = (siemens)
    (pJ) = (picojoule)
}


NEURON {
    SUFFIX mujpow
    USEION k READ ik, ek 
    USEION na READ ina, ena
    POINTER i_ih
    RANGE erate
    GLOBAL gratio
}


PARAMETER {
    ihna (mA/cm2)
    ihk (mA/cm2)
    gratio = 5
    ena (mV)
    ek (mV)
}

ASSIGNED {
    v (mV)
    ik (mA/cm2)
    ina (mA/cm2)
    erate (pJ/cm^2)
    i_ih (mA/cm2)  : How to make it read this from NEURON?     
    
}

LOCAL gnah  
LOCAL acc

BREAKPOINT {
    gnah = i_ih/(v*(gratio+1) - gratio*ek - ena)
    ihna = gnah*(v-ena)
    ihk = gratio*gnah*(v-ek)
    
    acc = (ina + ihna)*(v-ena) + (ik + ihk)*(v-ek)
    erate = (1e6)*acc
}


