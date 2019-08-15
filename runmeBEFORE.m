clear; clear peakDetection_debug; clear runmeBEFORE; clear MATLAB Function;

%% chose dataset
path_before = '/afs/tu-berlin.de/home/a/anacsousa/Documents/Libraries-for-OpenSim/artifactDetectionSandBox/Datasets/';
% file = 'Meas_gait_with09-Mar-2018 15:39:23'; status_i = 1; %do not forget to change freq_emg = 4000!
% file = 'Meas_gait_with16-Mar-2018 16:27:12'; status_i = 1; %do not forget to change freq_emg = 4000!
% file = 'Meas_gait_without09-Mar-2018 14:50:36'; status_i = 1; %do not forget to change freq_emg = 4000!
file = 'Meas_gait_without16-Mar-2018 16:12:45'; status_i = 1; %do not forget to change freq_emg = 4000!
% file = 'Meas_gait_calibrated_cut_musclelab';  status_i = 2; %do not forget to change freq_emg = 1000!
load(strcat(path_before,file,'.mat'));

%% prepare variables workspace for simulink
time = (emgData.time(:) - emgData.time(1));
status = emgData.status;
fes_ch1 = emgData.fes.q(1,:);   fes_ch2 = emgData.fes.q(2,:);
emg_ch1 = emgData.rawCh1;       emg_ch2 = emgData.rawCh2;

Tfinal = time(end);f_emg = emgData.Fs_EMG;f_stim = emgData.Fs;

% replace NAN for 0
k = find(isnan(emg_ch1))'; emg_ch1(k) = 0; emg_ch1(isnan(emg_ch1)) = 0;
k = find(isnan(emg_ch2))'; emg_ch2(k) = 0; emg_ch2(isnan(emg_ch2)) = 0;

% create variables for workspace
EMGstatus = timeseries(int16(status(status_i,:)),time);
FES_ch1 = timeseries(fes_ch1,time);FES_ch2 = timeseries(fes_ch2,time);
EMGdata_ch1 = timeseries(emg_ch1,time);EMGdata_ch2 = timeseries(emg_ch2,time);


