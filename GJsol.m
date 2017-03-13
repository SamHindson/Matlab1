function v = GJsol(A, B)
    aug = [A B];
    [rn cn] = size(A);
    
    % Iterate through columns
    for c = 1:cn
        % Get aug(r,c) to zero
        for r = c + 1:rn
           q = aug(r,c) / aug(c,c);
           aug(r, :) = aug(r, :) - q * aug(c, :);
        end
    end
    
    % Iterate through columns backwards
    for c = cn:-1:2
        % Get aug(r,c) to zero
        for r = c - 1:-1:1
           q = aug(r,c) / aug(c,c);
           aug(r, :) = aug(r, :) - q * aug(c, :);
        end
    end
    
    v = zeros(size(B));
    vn = size(v);
    
    for i=1:vn
        v(i) = aug(i, cn + 1) * 1. / aug(i, i) * 1.;
    end
end