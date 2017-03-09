function sol = GaussianElimination(A, B)
    [~, h] = size(B);
    
    % Initialize our output variable
    sol = zeros(1);

    % Loop through each column in our solution matrix
    for c=1:h
        % Get our solution matrix
        b = B(:,c);
        % Augment the matrix
        augmat = zeros(size(A, 1), length(A) + 1);
        
        for g=1:size(A, 1)
            augmat(g, :) = [A(g, :), b(g)];
        end 
    
        % Get some useful dimensions
        height = size(augmat, 1);
        width = length(augmat);
        
        % Make sure there aren't any zeros to begin with    
        % Loop through each row
        for y=1:height
            % If there's a zero, add some row to it on the condition all 
            % values in that row are nonzero
            if any(augmat(y, :))
              % Find another one
              for a=1:height
                if a==y
                  continue;
                end
                
                % Selects a row which will be added to the one with the zeros
                k = augmat(a, :);
                
                % Add em up
                product = k + augmat(y, :);
                
                % If there are no zeros left, great success!
                if any(product(:) ~= 0)
                  augmat(y, :) = product;
                  continue;
                end
              end
            end
        end

        % We need to create a triangle in the lower right corner. 
        % For a 3x3 coefficient matrix, this would be done by coding this:
        %
        %   augmat(2,:) = augmat(2,:) - augmat(2,1)/augmat(1,1) * augmat(1,:);
        %   augmat(3,:) = augmat(3,:) - augmat(3,1)/augmat(1,1) * augmat(1,:);
        %   augmat(3,:) = augmat(3,:) - augmat(3,2)/augmat(2,2) * augmat(2,:);
        %
        % The general rule is such that looping r from 2 to height and c from 1 to r - 1,
        %
        %   augmat(r, :) = augmat(r, :) - augmat(r, c)/augmat(c, c) * augmat(c, :);
        %
        % So we do this.
        
        for r=2:height 
          for cc=1:r-1
            augmat(r, :) = augmat(r, :) - augmat(r, cc)/augmat(cc, cc) * augmat(cc, :);
          end
        end

        % Back substitution is achieved by looking at a 3x3 case again:
        % 
        %   vars(3) = (augmat(3,4)                                          ) / augmat(3,3);
        %   vars(2) = (augmat(2,4)                     -  augmat(2,3) * zzz ) / augmat(2,2);
        %   vars(1) = (augmat(1,4) - augmat(1,2) * yyy -  augmat(1,3) * zzz ) / augmat(1,1);
        % 
        % Looping s from height - 1 to 1, the general rule is
        %            
        %   k = -sum(n=width, n>s) { augmat(s, n) * vars(n) }
        %   vars(s) = (augmat(s, width) + k) / augmat(s, s)
        
        vars = zeros(width - 1, 1);
        
        for s=width-1:-1:1
          k = 0;
          for n=width-1:-1:s+1
              k = k - augmat(s, n) * vars(n);
          end
          vars(s) = (augmat(s, width) + k) / augmat(s, s);
        end
        
        % This is a very ugly solution. Redo
        for v = 1:height
            sol(v, c) = vars(v);
        end
    end
end