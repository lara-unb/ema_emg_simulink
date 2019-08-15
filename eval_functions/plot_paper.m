figure();
%% change names to make it easier to identify vectors after
emgTA = emgIPI1; emgGAS = emgIPI2;
volTA = vIPI1;volGAS = vIPI2;
evoTA = eIPI1;evoGAS = eIPI2;

    disp('...plot paper');
    
    %% plot raw emg and artifacts
    fig1(1)=subplot(4,1,1);    
    txt = strcat('Raw EMG signal of GAS and TA with arrtifact detection');
    title(txt);
    
    hold on;
        plot(time_IPI, emgTA,'Color',[0.1,0.1,1.0]);
        plot(time_IPI, emgGAS,'Color',[1.0,0.1,0.1]);
    hold off; 
    
    legend('GAS','TA');
    xlim([0,Tfinal]);
    ylabel('Raw emg');
    xlabel('Time [s]');
    
    %% plot vol, evo and gait phase
    fig1(2)=subplot(4,1,2);    
    txt = strcat('Volitional estimation of GAS and TA');
    title(txt);
    
    hold on;
        plot(time_IPI, volTA,'Color',[0.1,0.1,1.0]);
        plot(time_IPI, volGAS,'Color',[1.0,0.1,0.1]);
    hold off; 
    legend('GAS','TA');
    xlim([0,Tfinal]);
    ylabel('Volitional EMG');
    xlabel('Time [s]');

    fig1(3)=subplot(4,1,3);    
    txt = strcat('Evoked estimation of GAS and TA');
    title(txt);
    
    hold on;
        plot(time_IPI, evoGAS,'Color',[0.1,0.1,1.0]);
        plot(time_IPI, evoTA,'Color',[1.0,0.1,0.1]);
    hold off; 
    legend('GAS','TA');
    xlim([0,Tfinal]);
    ylabel('Evoked EMG');
    xlabel('Time [s]');
    
    fig1(4)=subplot(4,1,4);    
    txt = strcat('GPD');
    title(txt);
    
    hold on;
        plot(time_IPI, gpd);
    hold off; 
    
    xlim([0,Tfinal]);
    ylabel('phase');
    xlabel('Time [s]');
    
    linkaxes(fig1, 'x');