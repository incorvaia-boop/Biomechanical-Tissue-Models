function [E_data,eta,l,h_el,section_data,eps_l_data,dt,t_final,toll_vett,savefile]=NLVE_input_transv(curve_id)

% NONLINEAR VISCOELASTIC PARAMETERS FOR DIAPHRAGM

label_E=11;

switch curve_id

    case 1   % DN1 T1
        E0_EQ = 0.018;
        k_EQ  = 24.8;

    case 2   % DN1 T2 
         E0_EQ = 0.001;
        k_EQ  = 40;

    case 3   % DN1 T3
        E0_EQ = 0.0028;
        k_EQ  = 38.3;

    case 4   % DN2 T1
        E0_EQ = 0.002;
        k_EQ  = 37.4;

    case 5   % DN2 T2 
        E0_EQ = 0.0009;
        k_EQ  = 35.2;

    case 6   % DN2 T3 
        E0_EQ = 0.008;
        k_EQ  = 31;

    case 7   % DN2 T4 
        E0_EQ = 0.003;
        k_EQ  = 29.7;
end

% contributo viscoso quasi nullo
E0_NEQ = 0.5 * E0_EQ;
k_NEQ  = k_EQ;

E_data=[label_E,E0_EQ,k_EQ,E0_NEQ,k_NEQ];

eta = 250;
% GEOMETRY
l=1;
h_el=0.01;

label_section=1;
A=1;
section_data=[label_section,A];

% strain loading
label_eps_l=1;
Deps_l=0.02;
eps_final=0.2;
t_final=eps_final/Deps_l;

eps_l_data=[label_eps_l,Deps_l];

% TIME
dt=0.01;

tollerance_u=1e-8;
toll_vett=[tollerance_u];

savefile='resulttrasv.mat';

end