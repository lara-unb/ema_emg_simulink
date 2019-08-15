b = 4.1;

time = EMG_vec_ch1(1,:);
size_data = size(time,2);
all_IPIs = IPIs(2,:);
EMGstatus_ = status(2:3,:);
FES_ch1_ = FES_ch1;
EMG_vec_ch1_ = EMG_vec_ch1(2:end,:);
EMGraw_ch1 = EMG_vec_ch1;

if ~exist('FES_ch2_','var')
    FES_ch2 = zeros(2,size(time,2));
    FES_ch2_ = zeros(2,size(time,2));
else
    FES_ch2_ = FES_ch2;    
end

if ~exist('EMG_vec_ch2','var')
    EMG_vec_ch2 = zeros(size(EMG_vec_ch1));
    EMG_vec_ch2_ = zeros(size(EMG_vec_ch1_));
end

EMGraw_ch2 = EMG_vec_ch2;

% % create ch1
size1 = size(EMG_vec_ch1_,2); size2 = size(EMG_vec_ch1_,1);

emg1 = zeros(1,sum(EMGstatus_(2,:)));
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

% create ch2
emg2 = zeros(1,sum(EMGstatus_(2,:)));
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

% create filtering var
if flag_plotFILTER
    vEMG = vEMG(2:3,:);
    eEMG = eEMG(2:3,:);
end