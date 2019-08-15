figure();

    disp('...plot4');
    
    % plot filter response for both channels
    fig4(1)=subplot(3,1,1);
    txt = strcat('Filter algorithm: ',num2str(peak_filter));
    title(txt);
    
    %% vol
        hold on;
            plot(vEMG(2,:),'r','LineWidth',2); 
            plot(vEMG(3,:),'b','LineWidth',2); 
        hold off;
        legend('ch1','ch2');
        ylabel('vEMG');
        xlabel('# iterations'); 
        xlim([0 length(vEMG(1,:))]);
        
    %% evo
        fig4(2)=subplot(3,1,2);
        hold on;
            plot(eEMG(2,:),'r','LineWidth',2); 
            plot(eEMG(3,:),'b','LineWidth',2); 
        hold off;
        legend('ch1','ch2');
        ylabel('eEMG');
        xlabel('# iterations');  
        xlim([0 length(eEMG(1,:))]);    
        
    %% stim
        fig4(3)=subplot(3,1,3);
        hold on;
            plot(FES_ch1_(2,:),'r','LineWidth',2);
            plot(FES_ch2_(2,:),'b','LineWidth',2);
        hold off;
        legend('ch1','ch2');
        ylim([0,1.1]);
        xlim([0 length(FES_ch1_(2,:))]); 
        ylabel('stim');
        xlabel('# iterations');
        
    linkaxes(fig4, 'x');
    