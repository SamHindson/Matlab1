function sol = GaussianElimination(A, B)
    [w, h] = size(B);
    
    % Initialize our output variable
    sol = zeros(1);

    % Loop through each column in our solution matrix
    for c=1:h
        b = B(:,c);
        % Augment the matrix
        augmat = [
            A(1,:),b(1);
            A(2,:),b(2);
            A(3,:),b(3)];
        
        % Make sure there aren't any zeros to begin with    
        % Loop through each row
        for y=1:size(augmat,1)
            % If there's a zero, add some row to it on the condition all 
            % values in that row are nonzero
            if any(augmat(y, :))
              % Find another one
              for a=1:size(augmat, 1)
                if a==y
                  continue;
                end
                
                k = augmat(a, :);
                product = k + augmat(y, :);
                
                if any(product(:) ~= 0)
                  augmat(y, :) = product;
                  continue;
                end
              end
            end
        end

        % Get A(2,1) to 0
        augmat(2,:) = augmat(2,:) - augmat(2,1)/augmat(3,1) * augmat(3,:);

        % Get A(3,1) to 0
        augmat(3,:) = augmat(3,:) - augmat(3,1)/augmat(1,1) * augmat(1,:);

        % Get A(3,2) to 0
        augmat(3,:) = augmat(3,:) - augmat(3,2)/augmat(2,2) * augmat(2,:);

        % Back substitution
        zzz = augmat(3,4)/augmat(3,3);
        yyy = (augmat(2,4) - augmat(2,3) * zzz) / augmat(2,2);
        xxx = (augmat(1,4) - augmat(1,2) * yyy - augmat(1,3) * zzz) / augmat(1,1);

        % Stick it in the ouput matrix
        sol(1,c) = xxx;
        sol(2,c) = yyy;
        sol(3,c) = zzz;
    end
end