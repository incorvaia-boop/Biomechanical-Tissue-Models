clear;
clc; 
close all;

%% Tempo
t_end = 600;
n_t = 20000;
time = linspace(0,t_end,n_t);

% Step strain
eps0 = 0.20;
eps = eps0*ones(size(time));

tau = [0.05 1 10 80 300];
epsv0 = zeros(length(tau),1);


% Modelli

models = {
    'Nativo',       'k', 0.3977 , [0.13 0.09 0.065 0.030 0.015];
    'Protocollo 3', 'r', 0.124, [0.14 0.065 0.05 0.03 0.01];
    'Protocollo 2', [0.0 0.5 0.0], 0.31 , [0.061 0.12 0.10 0.03 0.01];
    'Protocollo 1', [0.0 0.4 1.0], 0.15 , [0.12 0.065 0.045 0.03 0.02];
    'Protocollo 4', [1.0 0.41 0.71], 0.4 , [0.12 0.09 0.065 0.030 0.015];
};


%% Simulazione


figure;
hold on;
grid on;

for m = 1:size(models,1)


    name = models{m,1};
    color = models{m,2};
    Eeq = models{m,3};
    E = models{m,4};

    [t,epsv] = ode45(@(t,y) maxwell_model(t,y,time,eps,tau), time, epsv0);
    epsv = epsv';

    sigma = compute_stress(eps0,epsv,Eeq,E);
    sigma_norm = sigma / sigma(1);

    plot(t,sigma_norm,'Color',color,'LineWidth',3)
    ylim([0 1])
    yticks(0:0.2:1)

end

xlabel('t [s]')
ylabel('P_{norm}')
title('Curve di relax trasversali')
legend(models(:,1))

function dydt = maxwell_model(t,y,time,eps,tau)

eps_t = interp1(time,eps,t);
n = length(tau);
dydt = zeros(n,1);

for i=1:n
    dydt(i) = (1/tau(i))*(eps_t - y(i));
end

end

function sigma = compute_stress(eps0,epsv,Eeq,E)

n_ramo = length(E);
sigma = zeros(1,size(epsv,2));

for k=1:length(sigma)
    sigma(k) = Eeq*eps0;
    for i=1:n_ramo
        sigma(k) = sigma(k) + E(i)*(eps0 - epsv(i,k));
    end
end

end