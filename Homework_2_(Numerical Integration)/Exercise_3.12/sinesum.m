function Snt = sinesum(t, b, N)
% Function to implement the sum of sines formula
%               Snt denotes the sum of sines
% Created by:   Suraj Jaiswal
% Date:         01.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics

Snt = zeros(size(t));

for ii=1:length(t)
    for n = 1: N
        Snt(ii) = Snt(ii) + b(n)*sin(n*t(ii));
    end
end

end