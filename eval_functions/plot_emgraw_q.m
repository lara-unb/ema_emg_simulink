function plot_emgraw_q( emgData )

    emg1 = zeros(1,sum(emgData.status(1,:)));
    emg2 = zeros(1,sum(emgData.status(1,:)));
    fes1 = zeros(1,sum(emgData.status(1,:)));
    fes2 = zeros(1,sum(emgData.status(1,:)));
    
    gpd1 = zeros(1,sum(emgData.status(1,:)));
    gpd2 = zeros(1,sum(emgData.status(1,:)));
    
    h = 0;
    for ii = 1:size(emgData.status(1,:),2)-1
        for j=1:emgData.status(1,ii)
            emg1(j+h) = emgData.rawCh1(j,ii);
            fes1(j+h) = emgData.fes.q(1,ii);
            emg2(j+h) = emgData.rawCh2(j,ii);
            fes2(j+h) = emgData.fes.q(2,ii);
%             gpd1(j+h) = emgData.GPD.left(2,ii);
%             gpd2(j+h) = emgData.GPD.right(2,ii);
        end
        h = h+emgData.status(1,ii);
    end
    
    figure();
    fig1(1)=subplot(3,1,1);
        hold on;
            plot(emg1);
            plot(emg2);
        hold off;
        
    legend('GAS','TA');
    
    fig1(2)=subplot(3,1,2);
        hold on;
            plot(fes1);
            plot(fes2);
        hold off;
    
%         ylim([0,1]);
        legend('GAS','TA');
        
%     fig1(3)=subplot(3,1,3);
%         hold on;
%             plot(gpd1);
%             plot(gpd2);
%         hold off;
%     
%         ylim([0,3.1]);
    
    linkaxes(fig1, 'x');

end

