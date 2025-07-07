clear all;
close all;
clc;

%% === STEP 0: MANUALLY DEFINE TRIAL DATA (dBm) ===


data = xlsread('trial25.xlsx');  % Format: Column 1 = Delay, Columns 2-4 = PDP trials

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
