clc;
clear;
close all;
%%

for curve_id = 1:6

[E_data,eta,l,h_el,section_data,eps_l_data,dt,t_final,toll_vett,savefile]...
= NLVE_input_longit(curve_id);

Deps_l = eps_l_data(2);

[xp,e,Co,n_xp] = mesh_1D(l,h_el);

num_int = 1;
[zeta_vett,W_vett,xp_Gauss] = Gauss_1D(num_int,xp);

Area_vett = NLVE_section(xp,section_data);

[bc_u,A_u,B_u] = LinViscEla_bc_u0(xp,Co);

t = 0;
eps_l = 0;

u = zeros(size(xp,2),1);
eps_v = zeros(size(e,1),1);

eps_plot = [];
force_plot = [];

while t <= t_final

    delta_u_l = Deps_l * dt;

    bc_u(end,2) = delta_u_l;

    [u,eps,eps_v] = NLVE_solution(E_data,eta,dt,xp,e,Co,Area_vett,...
    zeta_vett,W_vett,toll_vett,bc_u,A_u,B_u,u,eps_v);

    [sigma_EQ,sigma_NEQ,force] = NLVE_sigma(E_data,xp,e,Area_vett,eps,eps_v);

    eps_l = eps_l + delta_u_l/l;

    eps_plot = [eps_plot eps_l];
    force_plot = [force_plot mean(force)*1000];

    t = t + dt;

end

RESULT(curve_id).eps = eps_plot;
RESULT(curve_id).force = force_plot;

end