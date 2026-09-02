% evoluzione di u, d, eps_e, sigma

figure(5)
i_finale=size(t_vett,2); % find(t_vett>=t_finale-dt/2 & t_vett<=t_finale+dt/2);
for i=1:5:i_finale % 
    t=t_vett(i); u=u_CELL{i}; eps=eps_CELL{i}; eps_e=eps_e_CELL{i}; eps_v=eps_v_CELL{i}; 
    sigma_EQ=sigma_EQ_CELL{i}; sigma_NEQ=sigma_NEQ_CELL{i}; force=force_CELL{i};
    
    %clf
    subplot(2,2,1)
    hold on
    grid on
    plot(xp,u)
    title([' u, ','t = ',num2str(t), ', i = ',num2str(i)]);
    subplot(2,2,2)
    hold on
    grid on
    plot(xp_Gauss,eps,'k')
    plot(xp_Gauss,eps_e,'r')
    plot(xp_Gauss,eps_v,'g')
    title([' \epsilon (k), \epsilon_e (r), \epsilon_v (g) ']);
    subplot(2,2,3)
    hold on
    grid on
    plot(xp_Gauss,sigma_EQ+sigma_NEQ,'k')
    plot(xp_Gauss,sigma_EQ,'r')
    plot(xp_Gauss,sigma_NEQ,'g')
    title([' \sigma (k), \sigma_{EQ} (r), \sigma_{NEQ} (g) ']);
    subplot(2,2,4)
    hold on
    grid on
    plot(xp_Gauss,force,'k')
    title([' force (k) ']);
    pause
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
finale=size(t_vett,2);
force_vett=[]; sigma_EQ_vett=[]; sigma_NEQ_vett=[];
n_finale = length(force_CELL);
for i=1:n_finale
    force=force_CELL{i};
    force_vett=[force_vett,mean(force)];
end
figure(21)
hold on
grid on
plot(eps_vett,force_vett*1000)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Limit stress-strain curves

eps_max=0.2;
eps_tot=[0:eps_max/500:eps_max];
eps_v_fast=zeros(1,size(eps_tot,2));
eps_v_slow=eps_tot;
%sigma_tot_fast=zeros(1,size(eps_tot,2));
%sigma_tot_slow=zeros(1,size(eps_tot,2));
if E_data(1)==1
    sigma_tot_fast=E_data(2)*eps_tot+E_data(3)*eps_v_fast;
    sigma_tot_slow=E_data(2)*eps_tot+E_data(3)*eps_v_slow;
elseif E_data(1)==11
    sigma_tot_fast=(E_data(2)/E_data(3))*(exp(E_data(3)*eps_tot)-1)...
        +(E_data(4)/E_data(5))*(exp(E_data(5)*(eps_tot-eps_v_fast))-1);
    sigma_tot_slow=(E_data(2)/E_data(3))*(exp(E_data(3)*eps_tot)-1)...
        +(E_data(4)/E_data(5))*(exp(E_data(5)*(eps_tot-eps_v_slow))-1);
end

figure(21)
hold on
grid on
plot(eps_tot,sigma_tot_slow,'r')
plot(eps_tot,sigma_tot_fast,'g')
