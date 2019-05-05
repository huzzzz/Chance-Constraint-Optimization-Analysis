close all;
clear;
clc;

load('results/problem1.mat');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot
fig = figure;
plot(prange, log(-obj), '-o');
xlabel('p');
ylabel('log(-f(x))');
title('log Objective function v/s p');
saveas(fig, 'log Objective function vp.png');
close(fig);

% P2 v/s P3
fig = figure;
surf(ppx, ppy, log(-objP2P3));
xlabel('p2');
ylabel('p3');
zlabel('log(-f(x))');
title('Objective v/s p2 and p3');
saveas(fig, 'Objective v p2 and p3.png');
close(fig);

% P1 v/s P3
fig = figure;
surf(ppx, ppy, log(-objP1P3));
xlabel('p1');
ylabel('p3');
zlabel('log(-f(x))');
title('Objective v/s p1 and p3');
saveas(fig, 'Objective v p1 and p3.png');
close(fig);

% Objective v/s Variances of coefficients of x1, x2
fig = figure;
surf(scales, scales, log(-objscale));
xlabel('\sigma_1');
ylabel('\sigma_2');
zlabel('log(-f(x))');
title('Objective v/s \sigma of x_1, x_2');
saveas(fig, 'Objective v sigma of x_1, x_2.png');
close(fig);

% Variance of x1, x2 w.r.t. change in 1
fig = figure;
hold on;
plot(scales, x_var(:, 10, 1), '-o');
plot(scales, x_var(:, 10, 2), '-o');
legend('x_1', 'x_2');
hold off;
xlabel('Scale (s_1)');
ylabel('Coordinates (x_1, x_2)');
title('Coordinates v/s scale 1');
saveas(fig, 'Coordinates v scale 1.png');
close(fig);
    
% Variance of x1, x2 w.r.t. change in 2
fig = figure;
hold on;
plot(scales, x_var(10, :, 1), '-o');
plot(scales, x_var(10, :, 2), '-o');
legend('x_1', 'x_2');
hold off;
xlabel('Scale (s_2)');
ylabel('Coordinates (x_1, x_2)');
title('Coordinates v/s scale 2');
saveas(fig, 'Coordinates v scale 2.png');

toc;

