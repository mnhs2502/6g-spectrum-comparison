clear all;
close all;
clc;

% Data entries
data = [0.3
1.4
0.6
8.6
0.6
4.5
1.4
21.3
4.3
1.9
6.4
5.2
0.9
0
5.5
2.1
26
4.6
3.9
0.1
0.7
3.8
1.6
0.2
0.1
];

% Central Tendencies
mean_val = mean(data);
median_val = median(data);
mode_val = mode(data); % May return multiple values if there's more than one mode

% Measures of Dispersion
range_val = range(data);
variance_val = var(data);
std_dev_val = std(data);
iqr_val = iqr(data);

% Display results
fprintf('Central Tendencies:\n');
fprintf('Mean: %.2f\n', mean_val);
fprintf('Median: %.2f\n', median_val);
fprintf('Mode: %.2f\n', mode_val);

fprintf('\nMeasures of Dispersion:\n');
fprintf('Range: %.2f\n', range_val);
fprintf('Variance: %.2f\n', variance_val);
fprintf('Standard Deviation: %.2f\n', std_dev_val);
fprintf('Interquartile Range (IQR): %.2f\n', iqr_val);
