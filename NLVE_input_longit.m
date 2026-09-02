function [E_data,eta,l,h_el,section_data,eps_l_data,dt,t_final,toll_vett,savefile]=NLVE_input_longit(curve_id)

% NONLINEAR VISCOELASTIC PARAMETERS FOR DIAPHRAGM

label_E=11;

switch curve_id

    case 6   % DN2 L3 (più alta)
        E0_EQ = 0.0015;
        k_EQ  = 37.7;

    case 1   % DN1 L1
        E0_EQ = 0.0075;
        k_EQ  = 26.2;

    case 3   % DN1 L3
        E0_EQ = 0.0078;
        k_EQ  = 26.2;

    case 2   % DN1 L2 (sale più tardi)
        E0_EQ = 0.0005;
        k_EQ  = 42;

    case 4   % DN2 L1
        E0_EQ = 0.0003;
        k_EQ  = 41.5;

    case 5   % DN2 L2 (sale più tardi)
        E0_EQ = 0.0001;
        k_EQ  = 47.5;

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

savefile='result.mat';

end