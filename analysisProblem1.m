close all;
clear;
clc;

% Read from file
filename = 'problems/problem1.txt';
[n, m, k, cm, cs, Am, bm, As, bs, p] = read_from_file(filename);
% n = number of x_i
% m = number of constraints
lb = zeros(n, 1);
x0 = zeros(n, 1);

% Do analysis
prange = 0.1:0.01:0.99;
% Check sensitivity to P3
xv = zeros(length(prange), n);
obj = zeros(length(prange), 1);
for i = 1:length(prange),
    p(1) = prange(i);
    p(2) = prange(i);    
    p(3) = prange(i);
    fprintf('Solving for p3 = %f\n', prange(i));
    [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p));
    xv(i, :) = x + 0;
    obj(i, :) = fval;
end

figure;
plot(log(-obj), '-');
title('log Objective function v/s p');

figure;
plot(xv(:, 1));
hold on;
plot(xv(:, 2));
title('Coordinates v/s p');