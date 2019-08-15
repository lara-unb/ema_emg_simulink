%% NEW WAY
n_expected = 0;
n_right_ch1 = [0,0]; n_wrong_ch1 = [0,0]; n_right_ch2 = [0,0]; n_wrong_ch2 = [0,0];
i_incorrect_ch1_3 = zeros(1,size(FES_ch1_,2)); i_incorrect_ch2_3 = zeros(1,size(FES_ch1_,2));
i_incorrect_ch1_10 = zeros(1,size(FES_ch1_,2)); i_incorrect_ch2_10 = zeros(1,size(FES_ch1_,2));
last_stim = 0;
for i = 1:size(FES_ch1_,2)
    if (FES_ch1_(2,i) || FES_ch2_(2,i)) %is there stim now?
        if last_stim % only consider if last stim was 1
            
            n_expected = n_expected+1; % pulses expected
                
            % delete NaN
            ind_del = isnan(EMG_vec_ch1_(2:end,i));
            vec_emg1 = abs(EMG_vec_ch1_(2:end,i));
            vec_emg1(ind_del) = [];

            ind_del = isnan(EMG_vec_ch2_(2:end,i));    
            vec_emg2 = abs(EMG_vec_ch2_(2:end,i));
            vec_emg2(ind_del) = [];

            % find max_emg_vec (exclude the 5 last points)
            if length(vec_emg1) > 5
                max_EMG_vec1 = max(vec_emg1(1:end-5));
                max_p1 = find( vec_emg1(1:end-5) >= max_EMG_vec1, 1);
            else
                max_p1 = 1;
                n_right_ch1(1) = n_right_ch1(1) -1;
            end
            std_p1 = std(vec_emg1);

            if length(vec_emg1) > 5
                max_EMG_vec2 = max(vec_emg2(1:end-5));
                max_p2 = find( vec_emg2(1:end-5) >= max_EMG_vec2, 1);
            else
                max_p2 = 1;
                n_right_ch2(1) = n_right_ch2(1) -1;
            end
            std_p2 = std(vec_emg2);

            % if in the begining ..... 3 samples
            if max_p1 <= 4 % maximum in the begining AND last_stim = 1
                n_right_ch1(1) = n_right_ch1(1) + 1;
            elseif max_EMG_vec1 < (mean(vec_emg1)+5*std_p1)
                n_right_ch1(1) = n_right_ch1(1) + 1;
            else
                n_wrong_ch1(1) = n_wrong_ch1(1) + 1;
                i_incorrect_ch1_3(n_wrong_ch1(1)) = i;
            end
            if max_p2 <= 4
                n_right_ch2(1) = n_right_ch2(1) + 1;
            elseif max_EMG_vec2 < (mean(vec_emg2)+5*std_p2)
                n_right_ch2(1) = n_right_ch2(1) + 1;
            else
                n_wrong_ch2(1) = n_wrong_ch2(1) + 1;
                i_incorrect_ch2_3(n_wrong_ch2(1)) = i;
            end
            
            % if in the begining ..... 10 samples
            if max_p1 <= 11 % maximum in the begining AND last_stim = 1
                n_right_ch1(2) = n_right_ch1(2) + 1;
            elseif max_EMG_vec1 < (mean(vec_emg1)+5*std_p1)
                n_right_ch1(2) = n_right_ch1(2) + 1;
            else
                n_wrong_ch1(2) = n_wrong_ch1(2) + 1;
                i_incorrect_ch1_10(n_wrong_ch1(2)) = i;
            end
            if max_p2 <= 11
                n_right_ch2(2) = n_right_ch2(2) + 1;
            elseif max_EMG_vec2 < (mean(vec_emg2)+5*std_p2)
                n_right_ch2(2) = n_right_ch2(2) + 1;
            else
                n_wrong_ch2(2) = n_wrong_ch2(2) + 1;
                i_incorrect_ch2_10(n_wrong_ch2(2)) = i;
            end
        end
        
        last_stim = 1; %update last stim
    else
        last_stim = 0; %update last stim
    end
end
load('alpha.mat');

rights_ch1 = [100*n_right_ch1(1)/n_expected,100*n_right_ch1(2)/n_expected];
rights_ch2 = [100*n_right_ch2(1)/n_expected,100*n_right_ch2(2)/n_expected];
alpha_avg = mean(alpha(2,:));

info_eval.file = file;
info_eval.method = maskStr_peak;
info_eval.complete = lastIPIcomplete;
info_eval.alpha_auto = maskAlpha_auto;
info_eval.alpha_init = maskAlpha_init;

if strcmp(file,'Meas_gait_calibrated_cut_musclelab')
    txt = [num2str(rights_ch1(1)),'\% \\ ',num2str(rights_ch2(1)),'\%'];
    disp(txt);
else
    txt = [num2str(rights_ch1(2)),'\% \\ ',num2str(rights_ch2(2)),'\%'];
    disp(txt);
end

disp(['Alpha average: ',num2str(alpha_avg)]);

% % plot incorrect both channels, 3 samples
% i_incorrect_ch1_3 = i_incorrect_ch1_3(1:n_right_ch1(1));
% i_incorrect_ch2_3 = i_incorrect_ch2_3(1:n_right_ch2(1));
% figure();
% for i = 1:length(i_incorrect_ch1_3)
%     hold on;
%     if i_incorrect_ch1_3(i) > 0
%         plot(EMG_vec_ch1_(2:L+1,i_incorrect_ch1_3(i)));
%     end
%     hold off;
% end
% figure();
% for i = 1:length(i_incorrect_ch2_3)
%     hold on;
%     if i_incorrect_ch2_3(i) > 0
%         plot(EMG_vec_ch2_(2:L+1,i_incorrect_ch2_3(i)));
%     end
%     hold off;
% end

% %% plot incorrect both channels, 10 samples
% % i_incorrect_ch1_10 = i_incorrect_ch1_10(1:n_right_ch1(2));
% i_incorrect_ch2_10 = i_incorrect_ch2_10(1:n_right_ch2(2));
% figure();
% for i = 1:length(i_incorrect_ch1_10)
%     hold on;
%     if i_incorrect_ch1_10(i) > 0
%         plot(EMG_vec_ch1__(2:L+1,i_incorrect_ch1_10(i)));
%     end
%     hold off;
% end
% figure();
% for i = 1:length(i_incorrect_ch2_10)-1
%     hold on;
%     if i_incorrect_ch2_10(i) > 0
%         plot(EMG_vec_ch2__(2:L+1,i_incorrect_ch2_10(i)));
%     end
%     hold off;
% end