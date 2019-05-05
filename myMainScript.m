close all;
clear;
clc;

% Structure of the problem in the file is as follows
% k1 k2
% num_vars(n) num_constraints(m)
% means({c1, c2, ... cn}) stds({c1,c2, ... cn})
% means({a11, a12, ... a1n}) stds({a11, a12, ... a1n}) mean(b1) std(b1) p1
% .
% .
% .
% means({am1, am2, ... amn}) stds({am1, am2, ... amn}) mean(bm) std(bm) pm

% Read from file
filename = input('Enter filename ', 's');
[n, m, k, cm, cs, Am, bm, As, bs, p] = read_from_file(filename);
% n = number of x_i
% m = number of constraints
lb = zeros(n, 1);
x0 = zeros(n, 1);

tic;

	[x, fval] = fmincon(@(x)get_objective(x, cm, cs, k), x0, [], [], [], [], lb, [], @(x)get_constraints(x, m, Am, As, bm, bs, p));

toc;

disp("Optimal x = ");
disp(x);

disp("Optimal objective = ");
disp(fval);
