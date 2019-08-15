addpath('eval_functions'); clear;

%% change here 
flag_evaluation = true;
flag_plot1 = false;
flag_plot2 = false;
flag_plotFILTER = false;

%% load data saved from the simulink block
load('EMG.mat');
load('EMG_vec_ch1.mat');
load('IPIs.mat');
load('status.mat');
load('FES_ch1.mat');
load('vEMG.mat');
load('eEMG.mat');

%% prepare
emg_f = 4000; stim_f = 25; L = ceil(emg_f/stim_f); %<<<---- change here
maskStr_peak = '1';
peak_popup = '1';
peak_filter = '1';

prepare;

%% do things
if flag_evaluation % evaluation of data
    evaluation;
end

if flag_plot1  % plot raw emg data
    plot1;
end

if flag_plot2  % plot emg vecs aligned (with and without stim)
    plot2;
end

if flag_plotFILTER
    plot4
end