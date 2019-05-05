close all;
clear;
clc;

% Read from file

filename = input('Enter filename ', 's');
[n, m, k, cm, cs, Am, bm, As, bs, p] = read_from_file(filename);
% n = number of x_i
% m = number of constraints
lb = zeros(n, 1);
x0 = zeros(n, 1);

tic;

option = optimoptions('fmincon', 'Algorithm', 'interior-point', 'Display', 'Off'); 
% [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p));
% [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p));
f = @()fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p), option);
disp('interior-point')
timeit(f)

option = optimoptions('fmincon', 'Algorithm', 'sqp', 'Display', 'Off'); 
% [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p));
f = @()fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p), option);
disp('sqp')
timeit(f)

option = optimoptions('fmincon', 'Algorithm', 'active-set', 'Display', 'Off'); 
% [x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p));
f = @()fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p), option);
disp('active-set')
timeit(f)

toc;
