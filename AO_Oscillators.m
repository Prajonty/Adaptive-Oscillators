%% Master Thesis 

% This matlab script plots the input sinusoidal wave and the estimated
% sinusoidal wave. The estimation of the input signal was doing using an
% adaptive oscillator and it was implemented using simulink.


% Praveen Kumar Pakkirisamy 
% s2108305
% Systems and Control (Biomechatronics)
% University of Twente.
clc; clear;
%% Benchmark Signal
clc;
clear;

% Signal 1 (Narrow Frequency Spectrum)

T = 1.25;              % Time period
tsamp = T/100;         % Sampling rate
N = 5;                 % Number of cycles
t = 0:tsamp:N*T;       % Time vector
t=[t',t'];             % This format is for inputting into the signal generator.
alpha_r = 0.35;        % Amplitude
omega_r = 2*pi/T;      % rad/s
%% Adaptive Oscillator

% Tuning Parameters (Assumption based on Literature)
eta=2;
v_omega = 13;

% Learning Gains (Equations (16),(17),(18))
tau_alpha = 2/eta;
v_phi = sqrt(24.2*v_omega);
tau_omega = sqrt(20/v_omega);

% Simulink Model
SimOut = sim('AdaptiveOscillators.slx');

theta = SimOut.theta(:,1);                     % Input Signal
theta_estimated = SimOut.theta_estimated(:,1); % Estimated Signal

figure
plot(theta_estimated,'--','Linewidth',2)
hold on
plot(theta,'-')

opengl software
l = legend({'$\hat{\theta}(t)$','${\theta}(t)$'}); 
set(l,'interpreter','latex')
title('Estimated Signal using Adaptive Oscillators')
xlabel('Time')
ylabel('Amplitude')

