clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
[E_data,eta,l,h_el,section_data,eps_l_data,dt,t_final,toll_vett,savefile]=NLVE_inputreal;
% mesh
[xp,e,Co,n_xp]=mesh_1D(l,h_el);
num_int=1;
[zeta_vett,W_vett,xp_Gauss]=Gauss_1D(num_int,xp);
Area_vett=NLVE_section(xp,section_data);

fig_label=1;
if fig_label==1
    figure(1)
    hold on
    grid on
    plot(xp, zeros(1,size(xp,2)),'ob')
    plot(xp_Gauss, zeros(1,size(xp_Gauss,2)),'or')
    plot(xp, 1/2*Area_vett, 'k')
    plot(xp, -1/2*Area_vett, 'k')
    title([' mesh and section area '])
end
%% BC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[bc_u, A_u, B_u]=LinViscEla_bc_u0(xp,Co);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Solution at t=0
t=0; eps_l=0; 
u=zeros(size(xp,2),1); eps_v=zeros(size(e,1),1);
% solution save
nt=1;
t_vett=[t]; eps_vett=[eps_l]; 
u_CELL{nt}=u; eps_v_CELL{nt}=eps_v; eps_CELL{nt}=zeros(size(e,1),1); eps_e_CELL{nt}=zeros(size(e,1),1);
sigma_EQ_CELL{nt}=zeros(size(xp_Gauss,2),1); sigma_NEQ_CELL{nt}=zeros(size(xp_Gauss,2),1); force_CELL{nt}=zeros(size(xp_Gauss,2),1);
mean_force=0; delta_u_l=1;

while t<=t_final
    % given the solution at t, determine the solution at t+dt
    delta_u_l=LinViscEla_delta_u_l(l,eps_l_data,dt,eps_l,mean_force,delta_u_l);
    bc_u(end,2)=delta_u_l;
    [u,eps,eps_v]=NLVE_solution(E_data,eta,dt,xp,e,Co,Area_vett,zeta_vett,W_vett,toll_vett,bc_u,A_u,B_u,u,eps_v);
    [sigma_EQ,sigma_NEQ,force]=NLVE_sigma(E_data,xp,e,Area_vett,eps,eps_v);
    mean_force=mean(force);
    nt=nt+1;
    t=t+dt
    eps_l=eps_l+delta_u_l/l;
    t_vett=[t_vett,t]; eps_vett=[eps_vett,eps_l];
    u_CELL{nt}=u; eps_v_CELL{nt}=eps_v; eps_CELL{nt}=eps; eps_e_CELL{nt}=eps-eps_v;
    sigma_EQ_CELL{nt}=sigma_EQ; sigma_NEQ_CELL{nt}=sigma_NEQ; force_CELL{nt}=force;
end

%
save(savefile,'E_data','eta','l','h_el','eps_l_data','dt','t_final','xp','e','Co','zeta_vett','W_vett','xp_Gauss',...
              't_vett','eps_vett','u_CELL','eps_CELL','eps_e_CELL','eps_v_CELL','sigma_EQ_CELL','sigma_NEQ_CELL','force_CELL')
