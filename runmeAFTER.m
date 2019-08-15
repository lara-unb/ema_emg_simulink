addpath('eval_functions'); 

flag_evaluation = true;
flag_plot_paper = true;

%% prepare
b = 3.1;
load('EMG_vec_ch1.mat');load('EMG_vec_ch2.mat');
load('IPIs.mat');load('vEMG_ch1.mat');load('vEMG_ch2.mat');
load('eEMG_ch1.mat');load('eEMG_ch2.mat');

EMG_vec_ch1_ = EMG_vec_ch1;EMG_vec_ch2_ = EMG_vec_ch2;
EMGstatus_ = double(EMGstatus.Data(:,:));
EMGraw_ch1 = double(EMGdata_ch1.Data(:,:));EMGraw_ch2 = double(EMGdata_ch2.Data(:,:));
FES_ch1_ = double(FES_ch1.Data(:,:));FES_ch2_ = double(FES_ch2.Data(:,:));

EMGstatus_ = [time';EMGstatus_];
EMGraw_ch1 = [time';EMGraw_ch1];EMGraw_ch2 = [time';EMGraw_ch2];
FES_ch1_ = [time';FES_ch1_];FES_ch2_ = [time';FES_ch2_];

size1 = size(EMG_vec_ch1_,2); size2 = size(EMG_vec_ch1_,1);
all_IPIs = IPIs(2,:);

%% create emg and GPD signals
% emg1 = zeros(1,sum(EMGstatus_(2,:))); stim1 = emg1; %ch1
% time_ch1 = linspace(0,Tfinal,length(emg1));
% emg2 = zeros(1,sum(EMGstatus_(2,:))); stim2 = emg2; %ch2
% time_ch2 = linspace(0,Tfinal,length(emg2));

% IPIemg
emgIPI1 = zeros(1,L*size1); %emgIPI1
emgIPI2 = zeros(1,L*size1); %emgIPI2
time_IPI = linspace(0,Tfinal,length(emgIPI2));

gpd = zeros(1,L*size1);

%% create vol and evo signals
vIPI1 = zeros(1,L*size1); vIPI2 = zeros(1,L*size1);
eIPI1 = zeros(1,L*size1); eIPI2 = zeros(1,L*size1);

eEMG1_ = zeros(1,(E2-E1)*size1 ); %eEMG1 and 2
eEMG2_ = zeros(1,(E2-E1)*size1 );
time_evo = linspace(0,Tfinal,length(eEMG2_));

h = 0; hV = 0; hE = 0; hIPI = 0;
%% create vector for emg, stim and vol
for ii = 1:size1-1
%     for j=1:EMGstatus_(2,ii)
%         emg1(j+h) = EMGraw_ch1(j+1,ii);
%         stim1(j+h) = FES_ch1_(2,ii);
%         emg2(j+h) = EMGraw_ch2(j+1,ii);
%         stim2(j+h) = FES_ch2_(2,ii);
%     end
    
    emgIPI1(1+hIPI:L+hIPI) = EMG_vec_ch1(2:L+1,ii);
    emgIPI2(1+hIPI:L+hIPI) = EMG_vec_ch2(2:L+1,ii);    
    
    gpd(1+hIPI:L+hIPI)=ones(1,L)*emgData.GPD.right(2,ii);
    
    if exist('maskStr_filter','var')
        
        vIPI1(1+hIPI:V1+hIPI) = zeros(1,V1);
        vIPI1(1+V1+hIPI:V2+hIPI) = vEMG_ch1(2:V2-V1+1,ii);
        vIPI1(1+V2+hIPI:L+hIPI) = zeros(1,L-V2);
                
        vIPI2(1+hIPI:V1+hIPI) = zeros(1,V1);
        vIPI2(1+V1+hIPI:V2+hIPI) = vEMG_ch2(2:V2-V1+1,ii);
        vIPI2(1+V2+hIPI:L+hIPI) = zeros(1,L-V2);
        
        
        eIPI1(1+hIPI:E1+hIPI) = zeros(1,E1);
        eIPI1(1+E1+hIPI:E2+hIPI) = eEMG_ch1(2:E2-E1+1,ii);
        eIPI1(1+E2+hIPI:L+hIPI) = zeros(1,L-E2);
        
        eIPI2(1+hIPI:E1+hIPI) = zeros(1,E1);
        eIPI2(1+E1+hIPI:E2+hIPI) = eEMG_ch2(2:E2-E1+1,ii);
        eIPI2(1+E2+hIPI:L+hIPI) = zeros(1,L-E2);
    end
    h = h+EMGstatus_(2,ii);
    hIPI = hIPI + L;
end

%% do things
if flag_evaluation
    evaluation_paper
end

if flag_plot_paper
    plot_paper
end
