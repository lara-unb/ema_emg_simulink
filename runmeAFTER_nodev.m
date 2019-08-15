addpath('eval_functions'); 

flag_evaluation = true;
flag_plot_paper = false;
flag_plot1 = false;
flag_plot2 = false;
flag_plot3 = false;

%% prepare
b = 3.1;

load('EMG_vec_ch1.mat');
load('EMG_vec_ch2.mat');
load('IPIs.mat');
load('vEMG.mat');
load('eEMG.mat');

EMG_vec_ch1_ = EMG_vec_ch1;

if exist('EMG_vec_ch2','var')
    EMG_vec_ch2_ = EMG_vec_ch2;
else
    EMG_vec_ch2_ = zeros(size(EMG_vec_ch1_));
end

EMGstatus_ = double(EMGstatus.Data(:,:));
EMGraw_ch1 = double(EMGdata_ch1.Data(:,:));
EMGraw_ch2 = double(EMGdata_ch2.Data(:,:));
FES_ch1_ = double(FES_ch1.Data(:,:));
FES_ch2_ = double(FES_ch2.Data(:,:));

EMGstatus_ = [time';EMGstatus_];
EMGraw_ch1 = [time';EMGraw_ch1];
EMGraw_ch2 = [time';EMGraw_ch2];
FES_ch1_ = [time';FES_ch1_];
FES_ch2_ = [time';FES_ch2_];

size1 = size(EMG_vec_ch1_,2); size2 = size(EMG_vec_ch1_,1);
all_IPIs = IPIs(2,:);

%% create ch1 and ch2
emg1 = zeros(1,sum(EMGstatus_(2,:))); %ch1
stim1 = emg1; l = length(emg1);
time_ch1 = linspace(0,length(emg1)/emg_f,l);

h = 0;
for ii = 1:size1-1
    for j=1:EMGstatus_(2,ii)
        emg1(j+h) = EMGraw_ch1(j+1,ii);
        stim1(j+h) = FES_ch1_(2,ii);
    end
    h = h+EMGstatus_(2,ii);
end

emg2 = zeros(1,sum(EMGstatus_(2,:))); %ch2
stim2 = emg2; l = length(emg2);
time_ch2 = linspace(0,length(emg2)/emg_f,l);

h = 0;
for ii = 1:size1-1
    for j=1:EMGstatus_(2,ii)
        emg2(j+h) = EMGraw_ch2(j+1,ii);
        stim2(j+h) = FES_ch2_(2,ii);
    end
    h = h+EMGstatus_(2,ii);
end

%% create vEMG and eEMG
vEMG1_ = zeros(1,sum(EMGstatus_(2,:)));
vEMG2_ = zeros(1,sum(EMGstatus_(2,:)));

if exist('maskStr_filter','var')
    h = 0;
    for ii = 1:size1-1
        for j=1:EMGstatus_(2,ii)
            vEMG1_(j+h) = vEMG(2,ii);
            vEMG2_(j+h) = vEMG(3,ii);
        end
        h = h+EMGstatus_(2,ii);
    end
end

%% do things
if flag_evaluation
    evaluation_nodev
end

if flag_plot_paper
    plot_paper
end

if flag_plot1
    plot1_nodev
end

if flag_plot2
    plot2_nodev
end

if flag_plot3
    plot4_nodev
end

