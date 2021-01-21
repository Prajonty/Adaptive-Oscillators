%% Hopf Oscillator (Simple learning example).

% This matlab script shows an example in which the adaptive oscillator
% learns the angular frequency of the given input signal.


% Praveen Kumar Pakkirisamy 
% s2108305
% Systems and Control (Biomechatronics)
% University of Twente.
clc; clear;
%% Convergance of Angular velocity for different values of Epsilon.


mu = 1; % Considered for simplicity.
epsilon = [0.4,0.6,0.8,1]; 

for i = epsilon
    hopf_oscillator = sim('HopfOscillator_Simplelearning.slx');
    plot(hopf_oscillator.omega)
    hold on
end
opengl software
l = legend({'${\epsilon}=0.4$','${\epsilon}=0.6$','${\epsilon}=0.8$','${\epsilon}=1$'}); 
set(l,'interpreter','latex')
title('Learning angular frequency using Hopf Oscillator')
xlabel('Time')
ylabel('Angular Frequency')