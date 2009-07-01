function TempCompensateRawData (data, plotData)
%% Temperature Compensation for Main Sensors
figct = 100;

% If plotting only raw make this 15, otherwise make it 0;
onlyRaw = 15;

% set an initial and final offset if one is required
ini = 1;
%fin = size(data,1)-3000;
fin = size(data,1);

% set the indexes of the data
% Raw Data
% ========
rawGxIdx        = 29 - onlyRaw;
rawGyIdx        = 30 - onlyRaw;
rawGzIdx        = 31 - onlyRaw;
rawAxIdx        = 32 - onlyRaw;
rawAyIdx        = 33 - onlyRaw;
rawAzIdx        = 34 - onlyRaw;
rawMxIdx        = 35 - onlyRaw;
rawMyIdx        = 36 - onlyRaw;
rawMzIdx        = 37 - onlyRaw;
rawBarIdx       = 38 - onlyRaw;
rawPitIdx       = 39 - onlyRaw;
rawPwrIdx       = 40 - onlyRaw;
rawTheIdx       = 41 - onlyRaw;

% Produce the Time vector
time = 0:0.01:(size(data(ini:fin,1))*.01 - 0.01);

% Produce the Temperature vector
temp = data(ini:fin,rawTheIdx);


%% Start computing the offsets

% ======= GYROS ============
fit_data =  polyfit(temp, data(ini:fin, rawGxIdx),1);
gxTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawGyIdx),1);
gyTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawGzIdx),1);
gzTGain = fit_data(1);

% ======= ACCEL ============
fit_data =  polyfit(temp, data(ini:fin, rawAxIdx),1);
axTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawAyIdx),1);
ayTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawAzIdx),1);
azTGain = fit_data(1);

% ======= MAGS ============
fit_data =  polyfit(temp, data(ini:fin, rawMxIdx),1);
mxTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawMyIdx),1);
myTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawMzIdx),1);
mzTGain = fit_data(1);

% ======= EXTRA SENSORS ============
fit_data =  polyfit(temp, data(ini:fin, rawBarIdx),1);
barTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawPitIdx),1);
pitTGain = fit_data(1);

fit_data =  polyfit(temp, data(ini:fin, rawPwrIdx),1);
pwrTGain = fit_data(1);



%% If asked for plot the data
if plotData == 1
    figure(figct);
        plot(time,temp);
        title('Temperature Run');
        xlabel('Time (s)');
        ylabel('Count (12bits)');   
    eval(['print -depsc  '  num2str(figct)]);
    figct= figct+1; 

    % Temperature Dependence for each sensor
    figure(figct);
        subplot(3,3,1)
            plot(temp,data(ini:fin, rawGxIdx));
            title('Gyro X');
            legend(num2str(gxTGain));
            ylabel('Gyro counts');
        subplot(3,3,2)
            plot(temp,data(ini:fin, rawGyIdx));
            title('Gyro Y');
            legend(num2str(gyTGain));
         subplot(3,3,3)
            plot(temp,data(ini:fin, rawGzIdx));
            title('Gyro Z');
            legend(num2str(gzTGain));

        subplot(3,3,4)
            plot(temp,data(ini:fin, rawAxIdx));
            title('Accel X');
            legend(num2str(axTGain));
            ylabel('Accel counts');
        subplot(3,3,5)
            plot(temp,data(ini:fin, rawAyIdx));
            title('Accel Y');
            legend(num2str(ayTGain));
         subplot(3,3,6)
            plot(temp,data(ini:fin, rawAzIdx));
            title('Accel Z');
            legend(num2str(azTGain));

        subplot(3,3,7)
            plot(temp,data(ini:fin, rawMxIdx));
            title('Mag X');
            legend(num2str(mxTGain));
            ylabel('Magn counts');
            xlabel ('Temp counts');
        subplot(3,3,8)
            plot(temp,data(ini:fin, rawMyIdx));
            title('Mag Y');
            legend(num2str(myTGain));
            xlabel ('Temp counts');
         subplot(3,3,9)
            plot(temp,data(ini:fin, rawMzIdx));
            title('Mag Z');
            legend(num2str(mzTGain));
            xlabel ('Temp counts');
        
    eval(['print -depsc  '  num2str(figct)]);
    figct= figct+1;    

    figure(figct)
        subplot(3,1,1);
            plot(temp,data(ini:fin, rawBarIdx));            
            title('Barometer');
            legend(num2str(barTGain));
            ylabel('Barometer counts');
        subplot(3,1,2);
            plot(temp,data(ini:fin, rawPitIdx));            
            title('Differential Pressure');
            legend(num2str(pitTGain));
            ylabel('Differential counts');
        subplot(3,1,3);
            plot(temp,data(ini:fin, rawPwrIdx));            
            title('Power');
            legend(num2str(pwrTGain));
            ylabel('Power counts');
            xlabel ('Temp counts');         
            
    eval(['print -depsc  '  num2str(figct)]);
    figct= figct+1;    
           
end


% %% Plot the Temperature Compensated Air Data
% figure(figct);
% 
% subplot(3,1,1)
%     [t_St_comp, temp, tmeanSt] =  cTemp(t_St, t_Te, stTGain, 0, 0, 0);
%     plot(t_Ti(500:end),t_St(500:end), 'b');
%     hold on
%     plot(t_Ti(500:end),t_St_comp(500:end), 'r');
%     title ('Temperature Compensated Static Pressure')
%     hold off
%     ylabel ('Static (Pa)');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% subplot(3,1,2)
%     [t_Dy_comp, temp, tmeanDy] =  cTemp(t_Dy, t_Te, dyTGain, 0,0,0);
%     plot(t_Ti(500:end),t_Dy(500:end), 'b');
%     hold on
%     plot(t_Ti(500:end),t_Dy_comp(500:end), 'r');
%     title ('Temperature Compensated Dynamic Pressure')
%     hold off
%     ylabel ('Dynamic (Raw)');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% subplot(3,1,3)
%     [t_Vl_comp, temp, tmeanVl] =  cTemp(t_Vl, t_Te, vlTGain, 0,0,0);
%     plot(t_Ti(500:end),t_Vl(500:end), 'b');
%     hold on
%     plot(t_Ti(500:end),t_Vl_comp(500:end), 'r');
%     title ('Temperature Compensated Voltage Sensor')
%     hold off
%     ylabel ('Dynamic (Raw)');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% %% Gyro Calibration
% figure(figct);
% 
% subplot(3,1,1)
%     c_SLU_x_comp =  cTemp(c_SLU_x, c_Tem_x, gxTGain,1,0,0);
%     plot(c_Ti_x,c_SLU_x, 'b');
%     hold on
%     plot(c_Ti_x,c_SLU_x_comp, 'r');
%     title ('Temperature Compensated Gyro X')
%     hold off
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% subplot(3,1,2)
%     c_SLU_y_comp =  cTemp(c_SLU_y, c_Tem_y, gyTGain,1,0,0);
%     plot(c_Ti_y,c_SLU_y, 'b');
%     hold on
%     plot(c_Ti_y,c_SLU_y_comp, 'r');
%     title ('Temperature Compensated Gyro Y')
%     hold off
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% subplot(3,1,3)
%     c_SLU_z_comp =  cTemp(c_SLU_z, c_Tem_z, gzTGain,1,0,0);
%     plot(c_Ti_z,c_SLU_z, 'b');
%     hold on
%     plot(c_Ti_z,c_SLU_z_comp, 'r');
%     title ('Temperature Compensated Gyro Z')
%     hold off
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% %% Plot the Comparison for the Blog Post
% 
% [t_Gy_comp, temp, tmeanSt] =  cTemp(t_Gy, t_Te, gyTGain, 1, 1, 0);
% 
% figure(figct);
% subplot (3,1,1)
%     plot(t_Ti(500:end),t_Te(500:end));
%     title('Temperature Run');
%     xlabel('Time (s)');
%     ylabel('Count (12bits)');
% subplot(3,1,2)
%     plot(t_Ti(500:end),t_Gy(500:end));
%     title('Gyro Y');
%     xlabel('Time (s)');
%     ylabel('Count (12bits)');
%     hold on
%     plot(t_Ti(500:end),t_Gy_comp(500:end)+1500, 'r');
%     legend ('Raw Data','Temp Comp');
%     hold off
% subplot(3,1,3)
%     plot(t_Ti(500:end),t_St(500:end));
%     title('Static');
%     xlabel('Time (s)');
%     ylabel('Pressure (Pa)');  
%     hold on
%     plot(t_Ti(500:end),t_St_comp(500:end), 'r');
%     legend ('Raw Data','Temp Comp');
%     hold off
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% 
% 
% 
% 
% %% Compute the Gyro Calibration
% if (sw_calibrateGyro)
%     % get Gyro Gains from turntable experiment
%     figure(figct);
%     [gxGain, gxOffset] = getGain(c_KVH_x, c_SLU_x_comp);
%     figct= figct+1;    
%     eval(['print -depsc  '  num2str(figct)]);
% 
%     figure(figct);
%     [gyGain, gyOffset] = getGain(c_KVH_y, c_SLU_y_comp);
%     figct= figct+1;    
%     eval(['print -depsc  '  num2str(figct)]);
% 
% 
%     figure(figct);
%     [gzGain, gzOffset] = getGain(c_KVH_z, c_SLU_z_comp);
%     figct= figct+1;    
%     eval(['print -depsc  '  num2str(figct)]);
% else
%     figct = figct+3;
% end
% %% Accelerometer Gains from Tumble Experiment
% 
% figure(figct);
% 
% subplot(3,1,1)
%     [tu_Ax_comp, biaTemp, tmeanAx] = cTemp(tu_Ax, tu_Te, axTGain,0,0,0);
%     plot(tu_Ti,tu_Ax, 'b');
%     hold on
%     plot(tu_Ti,tu_Ax_comp, 'r');
%     title ('Temperature Compensated Accelerometer X')
%     hold off
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% subplot(3,1,2)
%     [tu_Ay_comp, biaTemp, tmeanAy] = cTemp(tu_Ay, tu_Te, ayTGain,0,0,0);
%     plot(tu_Ti,tu_Ay, 'b');
%     hold on
%     plot(tu_Ti,tu_Ay_comp, 'r');
%     title ('Temperature Compensated Acceleromter Y')
%     hold off
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
%     
% subplot(3,1,3)
%     [tu_Az_comp, biaTemp, tmeanAz] = cTemp(tu_Az, tu_Te, azTGain,0,0,0);
%     plot(tu_Ti,tu_Az, 'b');
%     hold on
%     plot(tu_Ti,tu_Az_comp, 'r');
%     title ('Temperature Compensated Accel Z')
%     hold off
%      ylabel ('Accel counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
%  AccelParam = extractParameters3D (tu_Ax_comp, tu_Ay_comp, tu_Az_comp, 9.80665);
%  
% figure(figct);
% 
% subplot (1,2,1)
%     [X, Y, Z] = correctSensors3D(tu_Ax_comp, tu_Ay_comp, tu_Az_comp, AccelParam);
%     plot3(X,Y,Z, '.')
%     title ('Corrected Accelerometer Readings');
%     xlabel('X Measured (m/s^2)');
%     ylabel('Y Measured (m/s^2)');
%     zlabel('Z Measured (m/s^2)');
%     axis equal
%     grid on
%     hold on
%     [x, y, z] = sphere(30);
%     surf(x.*9.81,y.*9.81,z.*9.81);
%     
%     clear x y z
% subplot (1,2,2)
%     plot3(tu_Ax_comp, tu_Ay_comp, tu_Az_comp, '.');
%     title ('Initial Accelerometer Readings');
%     xlabel('X Raw (counts)');
%     ylabel('Y Raw (counts)');
%     zlabel('Z Raw (counts)');
% 
%     axis equal
%     grid on
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% %% Magnetometer Gains from Tumble Experiment
% 
% figure(figct);
% 
% subplot(3,1,1)
%     [tu_Mx_comp, biaTemp, tmeanMx] = cTemp(tu_Mx, tu_Te, mxTGain,0,0,0);
%     plot(tu_Ti,tu_Mx, 'b');
%     hold on
%     plot(tu_Ti,tu_Mx_comp, 'r');
%     title ('Temperature Compensated Magnetometer X')
%     hold off
%      ylabel ('Mag counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% subplot(3,1,2)
%     [tu_My_comp, biaTemp, tmeanMy] = cTemp(tu_My, tu_Te, myTGain,0,0,0);
%     plot(tu_Ti,tu_My, 'b');
%     hold on
%     plot(tu_Ti,tu_My_comp, 'r');
%     title ('Temperature Compensated Magnetometer Y')
%     hold off
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% subplot(3,1,3)
%     [tu_Mz_comp, biaTemp, tmeanMz] = cTemp(tu_Mz, tu_Te, -mzTGain,0,0,0);
%     plot(tu_Ti,tu_Mz, 'b');
%     hold on
%     plot(tu_Ti,tu_Mz_comp, 'r');
%     title ('Temperature Compensated Magnetometer Z')
%     hold off
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
%     legend ('Raw Data','Temp Comp');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
%  MagParam = extractParameters3D (tu_Mx_comp, tu_My_comp, tu_Mz_comp, 1);
% 
% figure(figct);
% 
% subplot (1,2,1)
%     [X, Y, Z] = correctSensors3D(tu_Mx_comp, tu_My_comp, tu_Mz_comp, MagParam);
%     plot3(X,Y,Z, '.')
%     title ('Corrected Magnetometer Readings');
%     axis equal
%     grid on
%     hold on
%     [x, y, z] = sphere(30);
%     surf(x,y,z);
%     xlabel('X Normalized');
%     ylabel('Y Normalized)');
%     zlabel('Z Normalized');
%     
% subplot (1,2,2)
%     plot3(tu_Mx_comp, tu_My_comp, tu_Mz_comp, '.');
%     title ('Initial Magnetometer Readings');
%     axis equal
%     grid on 
%     xlabel('X Raw (counts)');
%     ylabel('Y Raw (counts)');
%     zlabel('Z Raw (counts)');
%  
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% clear X Y Z
% 
% %% Plot the static data, normal and temeprature compensated
% 
% clear tu_*
% clear c_*
% clear t_*
% 
% 
% % Gyros
% figure(figct)
% 
% subplot(2,1,1)
%     s_Gx_comp =  cTemp(s_Gx, s_Te, gxTGain,1);
%     plot(s_Ti(500:end),s_Gx(500:end), 'b');
%     title ('Long Term Gyro X')
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Gx_comp(500:end), 'r');
%     title ('Temperature Compensated Gyro X')
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
% 
% clear s_Gx_comp s_Gx
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% figure(figct)
% 
% subplot(2,1,1)
%     s_Gy_comp =  cTemp(s_Gy, s_Te, gyTGain,1);
%     plot(s_Ti(500:end),s_Gy(500:end), 'b');
%     title ('Long Term Gyro Y')
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Gy_comp(500:end), 'r');
%     title ('Temperature Compensated Gyro Y')
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
% 
% clear s_Gy_comp s_Gy
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% figure(figct)
% 
% subplot(2,1,1)
%     s_Gz_comp =  cTemp(s_Gz, s_Te, gzTGain,1);
%     plot(s_Ti(500:end),s_Gz(500:end), 'b');
%     title ('Long Term Gyro Z')
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Gz_comp(500:end), 'r');
%     title ('Temperature Compensated Gyro z')
%     ylabel ('Gyro counts');
%     xlabel ('Time (s)');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% clear s_Gz_comp s_Gz
% 
% % Accels
% figure (figct)
% 
% subplot(2,1,1)
%     s_Ax_comp = cTemp(s_Ax, s_Te, axTGain,0,1,tmeanAx);
%     plot(s_Ti(500:end),s_Ax(500:end), 'b');
%     title ('Long Term  Accelerometer X')
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Ax_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Accelerometer X')
%     hold off
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% clear s_Ax_comp s_Ax
% 
% figure (figct)
% 
% subplot(2,1,1)
%     s_Ay_comp = cTemp(s_Ay, s_Te, ayTGain,0,1,tmeanAy);
%     plot(s_Ti(500:end),s_Ay(500:end), 'b');
%     title ('Long Term Acceleromter Y')
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
% subplot (2,1,2)
%     plot(s_Ti(500:end),s_Ay_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Acceleromter Y')
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% clear s_Ay_comp s_Ay
% 
% figure (figct)
% 
% subplot(2,1,1)
%     s_Az_comp = cTemp(s_Az, s_Te, azTGain,0,1,tmeanAz);
%     plot(s_Ti(500:end),s_Az(500:end), 'b');
%     title ('Long Term  Accel Z')
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti,s_Az_comp, 'r');
%     title ('Long Term Temperature Compensated Accel Z')
%     ylabel ('Accel counts');
%     xlabel ('Time (s)');
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% clear s_Az_comp s_Az
% 
% % Mags
% figure (figct)
% 
% subplot(2,1,1)
%     s_Mx_comp = cTemp(s_Mx, s_Te, mxTGain,0,1,tmeanMx);
%     plot(s_Ti(500:end),s_Mx(500:end), 'b');
%     title ('Long Term  Mag X')
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Mx_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Mag X')
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
% 
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% clear s_Mx_comp s_Mx
% 
% figure (figct)
% 
% subplot(2,1,1)
%     s_My_comp = cTemp(s_My, s_Te, myTGain,0,1,tmeanMy);
%     plot(s_Ti(500:end),s_My(500:end), 'b');
%     title ('Long Term  Mag Y')
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_My_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Mag Y')
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
% 
% clear s_My_comp s_My
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% figure (figct)
% 
% subplot(2,1,1)
%     s_Mz_comp = cTemp(s_Mz, s_Te, mzTGain,0,1,tmeanMz);
%     plot(s_Ti(500:end),s_Mz(500:end), 'b');
%     title ('Long Term  Mag Z')
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Mz_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Mag z')
%     ylabel ('Mag counts');
%     xlabel ('Time (s)');
% 
% clear s_Mz_comp s_Mz
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% % Air Data
% 
% figure (figct)
% 
% subplot(2,1,1)
%     s_Dy_comp = cTemp(s_Dy, s_Te, dyTGain,0,1,tmeanDy);
%     plot(s_Ti(500:end),s_Dy(500:end), 'b');
%     title ('Long Term  Dynamic Pressure')
%     ylabel ('Dyn counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Dy_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Dynamic Pressure')
%     ylabel ('Dyn counts');
%     xlabel ('Time (s)');
% 
% clear s_Dy_comp s_Dy
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% figure (figct)
% 
% subplot(2,1,1)
%     s_St_comp = cTemp(s_St, s_Te, stTGain,0,1,tmeanSt);
%     plot(s_Ti(500:end),s_St(500:end), 'b');
%     title ('Long Term  Static Pressure (Pa)')
%     ylabel ('Pa');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_St_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Static Pressure (Pa)')
%     ylabel ('Pa');
%     xlabel ('Time (s)');
% 
% 
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% clear s_St_comp s_St
% 
% figure (figct)
% 
% subplot(2,1,1)
%     s_Vl_comp = cTemp(s_Vl, s_Te, vlTGain,0,1,tmeanVl);
%     plot(s_Ti(500:end),s_Vl(500:end), 'b');
%     title ('Long Term  Voltage')
%     ylabel ('counts');
%     xlabel ('Time (s)');
% subplot(2,1,2)
%     plot(s_Ti(500:end),s_Vl_comp(500:end), 'r');
%     title ('Long Term Temperature Compensated Voltage')
%     ylabel ('counts');
%     xlabel ('Time (s)');
% 
% clear s_Vl_comp s_Vl s_Te s_Ti
% figct= figct+1;    
% eval(['print -depsc  '  num2str(figct)]);
% 
% %% Print the complete set of Gains, Biases, Temp Coefficients, etc...
% format compact;
% format short;
% clc
% disp(' ===== Temp Coefficients =======');
% gxTGain
% gyTGain
% gzTGain
% axTGain
% ayTGain
% azTGain
% tmeanAx
% mxTGain
% myTGain
% disp(' for Z Mag negative');
% -mzTGain
% tmeanMx
% stTGain
% tmeanSt
% dyTGain
% tmeanDy
% vlTGain
% tmeanVl
% 
% disp(' ===== Gains  =======');
% gxGain
% gyGain
% gzGain
% disp(' Accel Param a');
% AccelParam.a
% disp(' Accel Param b');
% AccelParam.b
% disp(' Accel Param c');
% AccelParam.c
% disp(' Mag Param a');
% MagParam.a
% disp(' Mag Param b');
% MagParam.b
% disp(' Mag Param c');
% MagParam.c
% disp(' for Air Data use according to calibration');
% 
% disp(' ===== Bias  =======');
% disp(' for Gyros Grab 1st data Point');
% disp(' for Air Data use according to calibration');
% disp(' Accel Param x0');
% AccelParam.xo
% disp(' Accel Param y0');
% AccelParam.yo
% disp(' Accel Param z0');
% AccelParam.zo
% disp(' Mag Param x0');
% MagParam.xo
% disp(' Accel Param Y0');
% MagParam.yo
% disp(' Accel Param z0');
% MagParam.zo
% 
% format loose
% save gainsAndBiases
% 
% end