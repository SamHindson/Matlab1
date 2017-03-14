function [p,i] = jacobi(A,b,x0,tol)

n = length(x0);
x = [x0];

disp(x);

[w, h] = size(A);

i = 0;

while i < 500000
    i = i + 1;
    % Loop through rows
    for r = 1:h
        sigma = 0;
        for c = 1:w
            for k = 1:w
                if(c ~= k)
                    sigma = sigma + A(r,c) * x(c, i);
                end
            end
        end
        x(r, i+1) = (b(r) - sigma) / A(r,r);
    end
end

disp(x(:, i + 1));

end
