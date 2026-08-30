function  yd = reference(n,alpha)
% %reference
% Define the fraction of n for each segment (must sum to 1)
fractions = [0.1, 0.1, 0.1, 0.1, 0.05, 0.1, 0.1, 0.1, 0.15, 0.1]; % Example fractions

% Amplitudes for each segment (adjust as needed)
amplitudes = [1, 1.2, 1.6, 0.9, 0.5, 0.8, 1, 1.8, 0.3, 1];

% Calculate cumulative segment indices
cum_indices = round(cumsum(fractions) * n);
cum_indices(end) = n; % Ensure last index is exactly n

% Initialize output
yd = zeros(1, n);
start_idx = 1;

for i = 1:length(fractions)
    end_idx = cum_indices(i);
    yd(start_idx:end_idx) = amplitudes(i);
    start_idx = end_idx + 1;
end
yd = filter([1-alpha],[1 -alpha],yd);
end