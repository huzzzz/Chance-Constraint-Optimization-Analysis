function [n, m, k, cm, cv, Am, bm, As, bs, p] = read_from_file(filename)
    % Get number of variables and number of constraints
    fId = fopen(filename, 'r');
    vars = fscanf(fId, '%f');
    fclose(fId);
    % Get k
    k = vars(1:2);
    vars = vars(3:size(vars, 1));
    % Read from vars
    n = int32(vars(1));
    m = int32(vars(2));
    vars = vars(3:size(vars));
    % Get c
    c = vars(1:2*n);
    cm = c(1:n);
    cv = c(n+1:2*n);
    vars = vars(2*n+1:size(vars, 1));
    % Get A and b
    vars = reshape(vars, [size(vars, 1)/m, m])';
    % Order = Am, As, bm, bs, p
    Am = vars(:, 1:n);
    As = vars(:, n+1:2*n);
    bm = vars(:, 2*n+1);
    bs = vars(:, 2*n+2);
    p = vars(:, 2*n+3);
end