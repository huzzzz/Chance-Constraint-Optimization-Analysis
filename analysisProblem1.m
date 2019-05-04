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
PR = length(prange);
% Check sensitivity to all P
xv = zeros(length(prange), n);
obj = zeros(length(prange), 1);
options = optimoptions('fmincon', 'Display', 'off');
for i = 1:length(prange),
    p(1) = prange(i);
    p(2) = prange(i);    
    p(3) = prange(i);
    fprintf('Solving for p3 = %f\n', prange(i));
    [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p), options);
    xv(i, :) = x + 0;
    obj(i, :) = fval;
end

% Check sensitivity to P2 and P3
prange = 0.1:0.01:0.99;
[ppx, ppy] = meshgrid(prange, prange);
PR = length(prange);
%
p(1) = 0.9;
objP2P3 = zeros(PR, PR);
for i = 1:PR,
    for j = 1:PR,
        p(2) = prange(i);
        p(3) = prange(j);
        fprintf('Solving for p1 = %f, p2 = %f\n', prange(i), prange(j));    
        [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p), options);
        objP2P3(i, j) = fval;
    end
end

% Check sensitivity to P1 and P3
prange = 0.1:0.01:0.99;
[ppx, ppy] = meshgrid(prange, prange);
PR = length(prange);
%
p(2) = 0.9;
objP1P3 = zeros(PR, PR);
for i = 1:PR,
    for j = 1:PR,
        p(1) = prange(i);
        p(3) = prange(j);
        fprintf('Solving for p1 = %f, p2 = %f\n', prange(i), prange(j));    
        [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p), options);
        objP1P3(i, j) = fval;
    end
end


%% Check sensitivity to variances of x1
p = p*0 + 0.9;
scales = 0:0.5:20;
S = length(scales);
objscale = zeros(S, S);
% x1, x2 stores
x_var = zeros(S, S, 2);
% Run for some scales
for i = 1:length(scales),
    for j = 1:length(scales),
        As_tmp = As;
        As_tmp(:, 1) = As(:, 1)*scales(i);
        As_tmp(:, 2) = As(:, 2)*scales(j);
        [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As_tmp, bm, bs, p), options);
        objscale(i, j) = fval;
        x_var(i, j, :) = x;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot

figure;
plot(log(-obj), '-');
title('log Objective function v/s p');

figure;
surf(ppx, ppy, log(-objP2P3));

title('Objective v/s p2 and p3');