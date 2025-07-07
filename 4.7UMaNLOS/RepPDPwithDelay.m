clear all;
close all;
clc;

% === Load Data ===
data = xlsread('trial25.xlsx');  % Format: Column 1 = Delay (ns), Columns 2-26 = PDP trials

ABS_Delays = data(:, 1);  % Absolute delays in ns
PDP_trials = data(:, 2:end);
[K_bins, K_trials] = size(PDP_trials);

% === Step 1: Parameters ===
K = K_trials;               % Number of trials
N = K_bins;                 % Length of each trial
alpha = 40;                 % Grouping index
L = floor(N / alpha);       % Number of grouped bins
threshold_dBm = -150;       % Device sensitivity threshold (in dBm)

% === Step 2: Convert to Cell Format (optional but useful for processing) ===
PDPs_dBm = cell(1, K);
for i = 1:K
    PDPs_dBm{i} = PDP_trials(:, i);
end

% === Step 3: Plot Original PDPs (dBm) ===
figure; hold on;
for i = 1:K
    stem(ABS_Delays, PDPs_dBm{i}, 'filled');
end
title('Original PDPs (dBm)');
xlabel('Absolute Delay (ns)'); ylabel('Power (dBm)');
legend(arrayfun(@(i) sprintf('Trial %d', i), 1:K, 'UniformOutput', false));
grid on;

% === Step 4: Convert to Linear (mW) ===
PDPs_lin = cellfun(@(x) 10.^(x/10), PDPs_dBm, 'UniformOutput', false);

% === Step 5: Group Every alpha Delay Taps ===
grouped_PDPs = zeros(K, L);
grouped_delay_vals = zeros(1, L);  % Store average delay per bin

for i = 1:K
    for l = 1:L
        idx = (l-1)*alpha + 1 : l*alpha;
        grouped_PDPs(i, l) = mean(PDPs_lin{i}(idx));
        
        if i == 1  % Delay values are same across trials
            grouped_delay_vals(l) = mean(ABS_Delays(idx));
        end
    end
end

% === Step 6: Plot Grouped PDPs (Linear) ===
figure; hold on;
for i = 1:K
    stem(grouped_delay_vals, grouped_PDPs(i,:), 'filled');
end
title('Grouped PDPs (Linear)');
xlabel('Absolute Delay (ns)'); ylabel('Average Power (mW)');
legend(arrayfun(@(i) sprintf('Trial %d', i), 1:K, 'UniformOutput', false));
grid on;

% === Step 7: Representative PDP via 90th Percentile ===
rep_PDP_lin = prctile(grouped_PDPs, 90, 1);
rep_PDP_dBm = 10 * log10(rep_PDP_lin);
rep_PDP_dBm(rep_PDP_dBm < threshold_dBm) = threshold_dBm;

% === Step 8: Plot Representative PDP (in delay index) ===
figure;
stem(1:L, rep_PDP_dBm, 'filled');
title('Representative PDP (90th Percentile, Delay Index)');
xlabel('Grouped Delay Index'); ylabel('Power (dBm)');
grid on;

% === Step 9: Plot Representative PDP (with Relative Delay in ns) ===
rel_grouped_delays = grouped_delay_vals - grouped_delay_vals(1);
figure;
stem(rel_grouped_delays, rep_PDP_dBm, 'filled');
title('Representative PDP (90th Percentile, Relative Delay)');
xlabel('Relative Delay (ns)'); ylabel('Power (dBm)');
grid on;

