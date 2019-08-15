figure();

    disp('...plot1');

    %% plot raw emg
    fig1(1)=subplot(2,1,1);
    txt = strcat('Raw data; Algorithm: ',maskStr_peak);
    title(txt);
    
    hold on;
        plot(time_ch1, emg1,'r');
        plot(time_ch2, emg2, 'b');
    hold off;
    legend('ch1','ch2');
    xlim([0,time_ch1(end)]);
    ylabel('raw emg');
    xlabel('time');
    sigma = 0.1;
    
    %% mark all IPIs
    hold on;
    bb = 1; BB = ceil(b*L);
    last_dt = 0;
    for i = 1:length(all_IPIs)-1
        bb = bb + EMGstatus_(2,i);
        
        if EMGstatus_(2,i)
            
            dt = all_IPIs(i) - (BB - bb); %
            
            if last_dt
                diff_dt = abs(last_dt - dt);
                if (diff_dt > L*(1+sigma))||(diff_dt < L*(1-sigma))
                    if dt > 0
                        plot(time_ch1(dt),0,'rs','MarkerSize',6,'MarkerFaceColor','y');
                    end
                end
                last_dt = dt;
            else
                last_dt = dt;
            end
%             if dt > 0
%                 plot(time_ch1(dt),0,'k*','MarkerSize',3);
%             end
        end
        
    end
    hold off;
        
    %% plot stim raw
    fig1(2)=subplot(2,1,2);
    hold on;
        plot(time_ch1, stim1,'r','LineWidth',2);
        plot(time_ch2, stim2, 'b');
    hold off;
    legend('ch1','ch2');
    ylim([0,1.1]);
    ylabel('stim');
    xlabel('time');

    linkaxes(fig1, 'x');