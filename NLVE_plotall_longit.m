clear
clc
close all

figure
hold on
grid on
box on

% LOOP su tutte le curve sperimentali
for curve_id=1:6

    % CARICA PARAMETRI MATERIALI CORRETTI
    [E_data,eta,l,h_el,section_data,eps_l_data,dt,t_final,toll_vett,savefile]...
    = NLVE_input_longit(curve_id);

    % MESH
    [xp,e,Co,n_xp]=mesh_1D(l,h_el);

    num_int=1;
    [zeta_vett,W_vett,xp_Gauss]=Gauss_1D(num_int,xp);

    Area_vett=NLVE_section(xp,section_data);

    % CONDIZIONI INIZIALI
    [bc_u,A_u,B_u]=LinViscEla_bc_u0(xp,Co);

    t=0;
    eps_l=0;

    u=zeros(size(xp,2),1);
    eps_v=zeros(size(e,1),1);

    eps_plot=[];
    stress_plot=[];

    % LOOP TEMPORALE
    while t<=t_final

        Deps_l = eps_l_data(2);

        delta_u_l = Deps_l*dt;

        bc_u(end,2)=delta_u_l;

        [u,eps,eps_v]=NLVE_solution(E_data,eta,dt,xp,e,Co,...
        Area_vett,zeta_vett,W_vett,toll_vett,bc_u,A_u,B_u,u,eps_v);

        [sigma_EQ,sigma_NEQ,force]=NLVE_sigma(E_data,xp,e,Area_vett,eps,eps_v);

        eps_l = eps_l + delta_u_l/l;

        eps_plot = [eps_plot eps_l];

        % conversione in kPa
        stress_plot = [stress_plot mean(force)*1000];

        t=t+dt;

    end

    % STILE IDENTICO ALLA FIGURA
    switch curve_id

        case 1
            plot(eps_plot,stress_plot,'Color',[0 0 0.4],'LineWidth',2)

        case 2
            plot(eps_plot,stress_plot,'Color',[0.3 0.5 0.8],'LineWidth',2,'LineStyle','--')

        case 3
            plot(eps_plot,stress_plot,'Color',[0.5 0.7 0.9],'LineWidth',2)

        case 4
            plot(eps_plot,stress_plot,'Color',[0.7 0 0],'LineWidth',2)

        case 5
            plot(eps_plot,stress_plot,'Color',[0.9 0.2 0.2],'LineWidth',2,'LineStyle','--')

        case 6
            plot(eps_plot,stress_plot,'Color',[1 0.4 0.4],'LineWidth',2)

    end

end

% ASSI IDENTICI
xlabel('\epsilon')
ylabel('P [kPa]')

xlim([0 0.2])
ylim([0 250])

xticks(0:0.04:0.2)

legend('DN1 L1','DN1 L2','DN1 L3','DN2 L1','DN2 L2','DN2 L3','Location','northwest')

set(gca,'FontSize',12)