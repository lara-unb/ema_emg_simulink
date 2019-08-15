figure();
    disp('...plot2');

    % plot emg vecs STIM
    fig2(1)=subplot(4,1,1);
    txt = strcat('Stimulated; Algorithm: ',maskStr_peak);
    title(txt);
    
    hold on; 
        for i = 1:size1
           if (FES_ch1_(2,i) || FES_ch2_(2,i)) %stim
               plot(EMG_vec_ch1_(1:L,i)); 
           end
        end
    hold off;
    ylabel('ch1');
    xlabel('# samples');
    
    fig2(2)=subplot(4,1,2);
    hold on; 
        for i = 1:size1
           if (FES_ch1_(2,i) || FES_ch2_(2,i)) %stim
               plot(EMG_vec_ch2_(1:L,i)); 
           end
        end
    hold off;
    ylabel('ch2');
    xlabel('# samples');    
    
    % plot emg vecs NO STIM
    fig2(3)=subplot(4,1,3);
    txt = strcat('Not stimulated; Algorithm: ',maskStr_peak);
    title(txt);
    
    hold on;
        for i = 1:size1
           if ~(FES_ch1_(2,i) || FES_ch2_(2,i))
               plot(EMG_vec_ch1_(1:L,i)); 
           end
        end
    hold off;
    ylabel('ch1');
    xlabel('# samples');
    
    fig2(4)=subplot(4,1,4);
    hold on;
        for i = 1:size1
           if ~(FES_ch1_(2,i) || FES_ch2_(2,i))
               plot(EMG_vec_ch2_(1:L,i)); 
           end
        end
    hold off;
    ylabel('ch2');
    xlabel('# samples');
    
    linkaxes(fig2, 'x');