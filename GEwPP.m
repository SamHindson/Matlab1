function x = GEwPP(A, B)

    aug = [A B];
    [rn cn] = size(A);
    
    % Iterate through columns
    for c = 1:cn
        % Sort each row we need to in said column
        for sr1 = c + 1:rn
            for sr2 = sr1:rn
                if(aug(c, sr1) > aug(c, sr2))
                    temp = aug(sr1, :);
                    aug(sr1, :) = aug(sr2, :);
                    aug(sr2, :) = temp;
                end
            end
        end
        
        % Get aug(r,c) to zero
        for r = c + 1:rn
           q = aug(r,c) / aug(c,c);
           aug(r, :) = aug(r, :) - q * aug(c, :);
        end
    end
            
    % Init variable output array
    v = zeros(size(B));
    vn = size(v);
    
    disp(aug);
    
    % Back substitution
    for w = vn:-1:1
        k = 0;
        for f = 1:rn - 1
            if(f ~= w)
                k = k + aug(w, f) * v(f);
            end
        end
        v(w) = (aug(w, rn) - k) / aug(w, w);
    end
    
    v
end