function [c, ceq] = get_constraints(x, m, Am, As, bm, bs, p)
    % Given x
    % n = number of variables
    % m = number of constraints
    % Am = mean value of a_ij
    % As = std. deviation of a_ij
    % bm = mean of b_i
    % bs = std of b_s
    % p = probability of ith constraint
    ceq = [];
    c = [];
    for i=1:m,
       % For each constraint, add the mean
       mean = Am(i, :)*x - bm(i);
       std = sqrt((As(i, :).^2) * (x.^2) + bs(i).^2);
       cdfinv = norminv(p(i));
       c = [c; mean + cdfinv*std];
    end  
end