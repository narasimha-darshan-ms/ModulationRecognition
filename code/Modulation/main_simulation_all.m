
clear

% path containing the scripts to run simulations
%addpath('/ubc/ece/home/ll/grads/kenl/MSC_Project/Code/Automation')
addpath('C:/Users/Ken/Documents/GitHub/MSC_Project/code/Modulation')

% data output directory for modulation data
out_dir = 'C:/Users/Ken/Documents/GitHub/MSC_Project/data/Modulation';

% observation window size
N = 512;
% number of samples per modulation and snrdb
%P = 50; % for train data
%P = 60; % for validation data 
P = 200; % for test data
% signal-to-noise ratio
snrdB_vec = -25:1:13;
% indicate number of columns in total
nX = 140;

ook_config_wrapper(out_dir, N, P, snrdB_vec, nX);
bpsk_config_wrapper(out_dir, N, P, snrdB_vec, nX);
oqpsk_config_wrapper(out_dir, N, P, snrdB_vec, nX);
bfskA_config_wrapper(out_dir, N, P, snrdB_vec, nX);
bfskB_config_wrapper(out_dir, N, P, snrdB_vec, nX);
bfskR2_config_wrapper(out_dir, N, P, snrdB_vec, nX);





