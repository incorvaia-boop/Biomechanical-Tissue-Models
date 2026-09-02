function [E_data,eta,l,h_el,section_data,eps_l_data,dt,t_final,toll_vett,savefile]=NLVE_inputreal

% elastic coefficients %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Young modolus MPa
% label_E=1 -> linear visco-elastic pb
% label_E=11 -> non-linear viscoe-elastic pb
label_E=11;
if label_E==1
    E_EQ=0.1; % MPa
    E_NEQ=1; % MPa
    E_data=[label_E,E_EQ,E_NEQ];
elseif label_E==11
    E0_EQ=0.0001; E1_EQ=1.8;
    beta=9;
    E0_NEQ=beta*E0_EQ; E1_NEQ=beta*E1_EQ;
    eps1=0.19;
    k_EQ=(1/eps1)*log(E1_EQ/E0_EQ);
    k_NEQ=(1/eps1)*log(E1_NEQ/E0_NEQ);
    E_data=[label_E,E0_EQ,k_EQ,E0_NEQ,k_NEQ];
end
% viscous coefficient %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eta=1.2;
% GEOMETRY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% length
l=1; % mm
% finite element length
h_el=0.01; %
% fiber transverse section
% label_section==1 -> homogeneous section (A=1)
% label_section==2 -> linealy increasing toward the midpoint
% label_section==3 -> changing section with parabolic law
label_section=1;
if label_section==1
    A=1;
    section_data=[label_section,A];
elseif label_section==2
    A_endpoints=1;
    A_midpoint=2;
    section_data=[label_section,A_endpoints,A_midpoint];
elseif label_section==3
    A_endpoints=1;
    A_midpoint=2;
    section_data=[label_section,A_endpoints,A_midpoint];
end
% BC imposed strain %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% label_eps_l=1 -> linealy incrising eps_l
% label_eps_l=2 -> saw-teeth eps_l
label_eps_l=2;
if label_eps_l==1
    % stretch rate
    Deps_l=0.02; % sec^(-1)
    % final stretch
    eps_final=1;
    % final time
    t_final=eps_final/Deps_l; % 
    eps_l_data=[label_eps_l,Deps_l];
elseif label_eps_l==2
    % stretch rate
    Deps_l=0.02; % sec^(-1)
    eps_l_max=0.2;
    % number of teeth
    n_step=5;
    delta_t_step=2*eps_l_max/Deps_l;
    t_final=n_step*delta_t_step;
    eps_l_data=[label_eps_l,Deps_l,eps_l_max];
end
% TIME
% time step
dt=4*10^(-2); % sec

% TOLLERANCES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tollerance_u=10^(-2)*Deps_l*dt*h_el;
toll_vett=[tollerance_u];

% RESULTS FILE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
savefile ='Prova_2.mat'; % 