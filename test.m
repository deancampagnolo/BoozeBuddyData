close all; clear; clc;

Tmax = randi([25 30], 1, 10);                       % Create Data
Tmin = randi([15 20], 1, 10);                       % Create Data
days = 1:10;                                        % Create Data
figure
hold on
plot(days, Tmin)
plot(days, Tmax)
%plot([days; days], [Tmin; Tmax], 'LineWidth',5)
xlabel('Day')
ylabel('Temperature Range (°C)')
ylim([10 40])
xlim([0 11])
%grid