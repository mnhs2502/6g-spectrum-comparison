clear all;
close all;
clc;

%% === STEP 0: MANUALLY DEFINE YOUR TRIAL DATA (dBm) ===
% Replace these with your actual values (must be equal-length vectors)
% trial1 = -80 + 3*randn(1, 400); 
% trial2 = -82 + 3*randn(1, 400); 
% trial3 = -85 + 3*randn(1, 400); 
% trial4 = -83 + 3*randn(1, 400); 
% trial5 = -81 + 3*randn(1, 400);

% trial1 = [-12.413, -12.413, -12.413, -12.413, -12.413, 0, 0, -65.173, 0, 0, 0, 0, -58.655, 0, 0, 0, 0, -63.737, 0, 0, 0, 0, -86.305, 0, 0, 0, 0, -79.255, 0, 0, 0, 0, 0, 0, -71.165, 0, 0, 0, 0, -70.753, 0, 0, -82.21, 0, 0, 0, 0, -45.361, 0, 0, 0, 0, 0, -88.745, 0, 0, 0, 0, -62.406, 0, 0, 0, 0, -84.861, 0, 0, 0, -75.76, 0, 0, 0, 0, 0, -74.095, 0, 0, 0, 0, -62.884, 0, 0, 0, 0, -83.706, 0, 0, 0, 0, 0, 0, 0, 0, -89.668, 0, 0, 0, -73.327, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; % Replace with your own vector
% trial2 = [-8.0597, -8.0597, -8.0597, -8.0597, -8.0597, 0, 0, 0, 0, -73.894, 0, 0, 0, 0, -63.126, 0, 0, 0, 0, -78.969, 0, 0, 0, 0, 0, 0, -70.918, 0, 0, 0, 0, -51.441, 0, 0, 0, 0, 0, 0, -61.498, 0, 0, 0, 0, 0, -67.209, 0, 0, 0, 0, 0, -31.701, 0, 0, 0, 0, -86.848, 0, 0, 0, 0, 0, 0, -80.329, 0, 0, 0, 0, 0, 0, 0, -63.366, 0, 0, 0, 0, -37.271, 0, 0, 0, 0, 0, 0, -61.949, 0, 0, 0, 0, 0, 0, -67.646, 0, 0, 0, -64.463, 0, 0, 0, 0, 0, -66.389, 0, 0, 0, 0, 0, -70.659, 0, 0, 0, -82.652, 0, 0, 0, -60.41, -73.726, -88.866, -65.438, 0, 0, -95.956, -93.789, -65.885];
% trial3 = [-8.5453, -8.5453, -8.5453, -8.5453, -8.5453, 0, 0, 0, -84.208, 0, 0, 0, 0, -82.197, 0, 0, 0, 0, -88.871, 0, 0, 0, 0, 0, 0, -69.791, 0, 0, 0, 0, -96.198, 0, 0, 0, 0, 0, 0, -82.62, 0, 0, 0, 0, 0, -61.655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -91.314, 0, 0, 0, 0, 0, 0, -83.347, 0, 0, 0, 0, -40.393, 0, 0, 0, 0, 0, 0, 0, -88.561, 0, 0, 0, 0, -89.81, 0, 0, 0, 0, 0, 0, -90.625, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -88.406, 0, 0, 0, 0, 0, -88.445, 0, 0, 0, -92.542, 0, 0, 0, 0, -67.456, -96.862, 0, 0, 0];
% trial4 = [-24.262, -24.262, -24.262, -24.262, -24.262, -69.144, -69.144, 0, 0, 0, -89.745, -89.745, 0, 0, 0, -88.858, -88.858, 0, 0, 0, -85.778, -85.778, 0, -76.669, -76.669, 0, 0, 0, -84.709, -84.709, 0, 0, -57.805, -57.805, 0, -73.187, -73.187, 0, 0, 0, -92.538, -92.538, 0, 0, 0, -101.02, -101.02, 0, -101.15, -101.15, 0, -95.247, -95.247, 0, 0, 0, -86.749, -86.749, 0, -64.836, -64.836, 0, 0, 0, -95.199, -95.199, 0, 0, -49.49, -49.49, 0, -92.212, -92.212, 0, 0, 0, -87.425, -87.425, 0, 0, -76.448, -76.448, 0, 0, -85.849, -85.849, 0, -95.306, -95.306, 0, -35.07, -35.07, 0, 0, -72.889, -72.889, 0, -86.216, -86.216, 0, -109.37, -109.37, 0, -112.05, -112.05, 0, -92.33, -92.33, 0, 0, -75.746, -75.746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
% trial5 = [-24.262, -24.262, -24.262, -24.262, -24.262, -69.144, -69.144, 0, 0, 0, -89.745, -89.745, 0, 0, 0, -88.858, -88.858, 0, 0, 0, -85.778, -85.778, 0, -76.669, -76.669, 0, 0, 0, -84.709, -84.709, 0, 0, -57.805, -57.805, 0, -73.187, -73.187, 0, 0, 0, -92.538, -92.538, 0, 0, 0, -101.02, -101.02, 0, -101.15, -101.15, 0, -95.247, -95.247, 0, 0, 0, -86.749, -86.749, 0, -64.836, -64.836, 0, 0, 0, -95.199, -95.199, 0, 0, -49.49, -49.49, 0, -92.212, -92.212, 0, 0, 0, -87.425, -87.425, 0, 0, -76.448, -76.448, 0, 0, -85.849, -85.849, 0, -95.306, -95.306, 0, -35.07, -35.07, 0, 0, -72.889, -72.889, 0, -86.216, -86.216, 0, -109.37, -109.37, 0, -112.05, -112.05, 0, -92.33, -92.33, 0, 0, -75.746, -75.746, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

% ABS_Delays = [666.67, 666.67, 666.67, 666.67, 666.67, 669.24, 669.24, 669.38, 669.52, 669.53, 671.93, 671.93, 672.45, 672.97, 673.03, 674.66, 674.66, 675.67, 676.68, 676.81, 677.42, 677.42, 678.99, 680.2, 680.2, 680.59, 680.78, 682.39, 683, 683, 684.63, 684.91, 685.82, 685.82, 685.85, 688.65, 688.65, 688.8, 689.16, 689.36, 691.49, 691.49, 692.92, 693.07, 693.52, 694.34, 694.34, 696.52, 697.2, 697.2, 697.98, 700.06, 700.06, 700.16, 701.86, 702.52, 702.94, 702.94, 703.83, 705.82, 705.82, 706.36, 707.14, 707.53, 708.71, 708.71, 710.93, 711.26, 711.6, 711.6, 711.83, 714.5, 714.5, 715.01, 715.57, 716.58, 717.4, 717.4, 718.79, 720.25, 720.31, 720.31, 721.39, 722.59, 723.23, 723.23, 724.99, 726.15, 726.15, 726.25, 729.07, 729.07, 730.26, 731.17, 732, 732, 734.12, 734.93, 734.93, 736.14, 737.87, 737.87, 739.5, 740.81, 740.81, 741.16, 743.75, 743.75, 744.42, 746.22, 746.7, 746.7, 749.37, 751.32, 756.46, 761.64, 766.86, 812.55, 823.87, 828, 834.03, 837.08];
% Combine all trials into a cell array

data = xlsread('Trial25_1.xlsx');  % Format: Column 1 = Delay, Columns 2-4 = PDP trials

ABS_Delays = data(:, 1);          % Absolute delay values (ns)
trial_1 = data(:, 2);
trial_2 = data(:, 3);
trial_3 = data(:, 4);
trial_4 = data(:, 5);
trial_5 = data(:, 6);
trial_6 = data(:, 7);
trial_7 = data(:, 8);
trial_8 = data(:, 9); trial_9 = data(:, 10); trial_10 = data(:, 11);
trial_11 = data(:, 12); trial_12 = data(:, 13); trial_13 = data(:, 14);trial_14 = data(:, 15);
trial_15 = data(:, 16); trial_16 = data(:, 17); trial_17 = data(:, 18);
trial_18 = data(:, 19); trial_19 = data(:, 20); trial_20 = data(:, 21);
trial_21 = data(:, 22);trial_22 = data(:, 23);trial_23 = data(:, 24);
trial_24 = data(:, 25);trial_25 = data(:, 26);

PDPs_dBm = {trial_1, trial_2, trial_3, trial_4, trial_5, trial_6, trial_7, trial_8, trial_9, trial_10, trial_11, trial_12, trial_13, trial_14, trial_15..... 
    trial_16, trial_17, trial_18, trial_19, trial_20....
    trial_21, trial_22, trial_23, trial_24, trial_25};

%% === STEP 1: SET PARAMETERS BASED ON YOUR DATA ===
K = length(PDPs_dBm);        % Number of trials
N = length(PDPs_dBm{1});     % Length of each trial
alpha = 20;                  % Grouping index
L = floor(N / alpha);               % Number of grouped bins
threshold_dBm = -150;        % Device sensitivity threshold

%% === STEP 2: Plot Original PDPs (dBm) using STEM ===
figure; hold on;
for i = 1:K
    stem(ABS_Delays, PDPs_dBm{i}, 'filled');
end
title('Step 1: Original PDPs (dBm)');
xlabel('Delay Index'); ylabel('Power (dBm)');
legend(arrayfun(@(i) sprintf('Trial %d', i), 1:K, 'UniformOutput', false));
grid on;


%% === STEP 3: Convert PDPs to Linear (mW) ===
PDPs_lin = cellfun(@(x) 10.^(x/10), PDPs_dBm, 'UniformOutput', false);

%% === STEP 4: Group Every alpha Delay Taps ===
grouped_PDPs = zeros(K, L);
for i = 1:K
    for l = 1:L
        idx = (l-1)*alpha + 1 : l*alpha;
        grouped_PDPs(i, l) = mean(PDPs_lin{i}(idx));
    end
end

% Plot grouped PDPs
figure; hold on;
for i = 1:K
    stem(1:L, grouped_PDPs(i,:), 'filled');
end
title('Step 2: Grouped PDPs (Linear)');
xlabel('Grouped Delay Index'); ylabel('Average Power (mW)');
legend(arrayfun(@(i) sprintf('Trial %d', i), 1:K, 'UniformOutput', false));
grid on;

%% === STEP 5: Calculate Representative PDP via 90th Percentile ===
rep_PDP_lin = zeros(1, L);
for l = 1:L
    rep_PDP_lin(l) = prctile(grouped_PDPs(:, l), 90);
end

% Plot representative PDP in linear scale
figure;
stem(1:L, rep_PDP_lin, 'filled');
title('Step 3: Representative PDP (90th Percentile, Linear)');
xlabel('Grouped Delay Index'); ylabel('Power (mW)');
grid on;

% Optionally also plot in dBm
rep_PDP_dBm = 10 * log10(rep_PDP_lin);
figure;
stem(1:L, rep_PDP_dBm, 'filled');
title('Step 4: Representative PDP (90th Percentile, dBm)');
xlabel('Grouped Delay Index'); ylabel('Power (dBm)');
grid on;
