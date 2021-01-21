%% Input signal 
clc;
clear;

% Signal 1 (Narrow Frequency Spectrum)

T = 1.25;                   % Time period
tsamp = T/200;              % Sampling rate
N = 20;                     % Number of cycles
t = 0:tsamp:N*T;
t_sim = t(end);             % Time length for Simulink
alpha_r = 0.35;             % Amplitude
omega_r = 2*pi/T;           % rad/s

 theta_fourier = alpha_r * (sin(omega_r*t)+ sin(omega_r*t*2)/2+ sin(omega_r*t*3)/3);

theta_fourier_sim = timeseries(theta_fourier',t);

%%Plot
plot (t,theta_fourier)
title('Input Signal')
xlabel('Time')
ylabel('Amplitude')

%% Adaptive Oscillator

% Initial values
% These values have a larger influence on the reconstruction of the signal.
alpha_0_init = 0.01;
phi_init = 0;          %1;
omega_init =0;         % 1e-4;
alpha_init = 0;

% Tuning Parameters (Assumption based on Literature)
eta     = 1;         %1.6;
v_omega = 2;         %8.8;
v_phi = v_omega;
% Number of Oscillators (Minimum 1, Maximum 8)

N_osc = 3;
%Selection of Oscillators in Simulink
i = zeros(1,3); i(1:N_osc) = 1;


% Simulink Model
load_system('PoolofAdaptiveoscillatorsThree.slx')
SimOut = sim('PoolofAdaptiveoscillatorsThree.slx');

theta = SimOut.theta(:,1);
theta_estimated = SimOut.theta_estimated(:,1);

figure
plot(theta_estimated,'--','Linewidth',0.1)
hold on
plot(theta,'-')

opengl software
l = legend({'$\hat{\theta}(t)$','${\theta}(t)$'}); 
set(l,'interpreter','latex')
title('Estimated Signal using Adaptive Oscillators')
xlabel('Time')
ylabel('Amplitude')

% Verifying the Angular velocity
omega = SimOut.omega.signals.values;
% omega1 = SimOut.omega1.signals.values;
% omega2 = SimOut.omega2.signals.values;
time_sim = SimOut.omega.time;
figure()
plot (time_sim,omega,time_sim,ones(length(omega),1)*omega_r, 'LineWidth',2);
legend('{\omega}_{estimated}','\omega_{given}')