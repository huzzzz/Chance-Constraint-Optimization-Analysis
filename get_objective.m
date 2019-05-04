function [f] = get_objective(x, cm, cs, k)
    f = k(1).*(cm'*x) + k(2).*(sqrt(x'*diag(cs.^2)*x));
end