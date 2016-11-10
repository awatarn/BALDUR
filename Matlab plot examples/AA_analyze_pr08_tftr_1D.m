%% Initialize
clear
close all
clc
%% Input parameters
DischargeNo = '46291';
DiagnosticTime = 4.5500;
TokName = 'tftr';
DirectoryContainingData = sprintf('/Users/Apiwat/Research_plasma/4 SOL/02_Simulations/01_TFTR/%s_exp',DischargeNo);


%% Reading - AMIN -
DepVarLabel1 = ' AMIN ';
[time,AMIN,AMIN_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
AMIN_diagTimeI = AMIN(diagTimeI);

figure(); 
plot(time,AMIN,'-o');
xlabel('time (s)');
ylabel('AMIN (m)');


%% Reading - BT -
DepVarLabel1 = ' BT ';
[time,BT,BT_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
BT_diagTimeI = BT(diagTimeI);

figure(); 
plot(time,BT,'-o');
xlabel('time (s)');
ylabel('BT (T)');

%% Reading - DELTA -
DepVarLabel1 = ' DELTA ';
[time,DELTA,DELTA_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
DELTA_diagTimeI = DELTA(diagTimeI);

figure(); 
plot(time,DELTA,'-o');
xlabel('time (s)');
ylabel('DELTA');

%% Reading - IP -
DepVarLabel1 = ' IP ';
[time,IP,IP_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
IP_diagTimeI = IP(diagTimeI);

figure(); 
plot(time,IP/1e6,'-o');
xlabel('time (s)');
ylabel('IP (MA)');

%% Reading - KAPPA -
DepVarLabel1 = ' KAPPA ';
[time,KAPPA,KAPPA_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
KAPPA_diagTimeI = KAPPA(diagTimeI);

figure(); 
plot(time,KAPPA,'-o');
xlabel('time (s)');
ylabel('KAPPA');

%% Reading - PNBI -
DepVarLabel1 = ' PNBI ';
[time,PNBI,PNBI_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
PNBI_diagTimeI = PNBI(diagTimeI);

figure(); 
plot(time,PNBI,'-o');
xlabel('time (s)');
ylabel('PNBI');

%% Reading - Q95 -
DepVarLabel1 = ' Q95 ';
[time,Q95,Q95_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
Q95_diagTimeI = Q95(diagTimeI);

figure(); 
plot(time,Q95,'-o');
xlabel('time (s)');
ylabel('Q95');

%% Reading - RGEO -
DepVarLabel1 = ' RGEO ';
[time,RGEO,RGEO_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
RGEO_diagTimeI = RGEO(diagTimeI);

figure(); 
plot(time,RGEO,'-o');
xlabel('time (s)');
ylabel('RGEO');

%% Reading - ZEFF -
DepVarLabel1 = ' ZEFF ';
[time,ZEFF,ZEFF_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
ZEFF_diagTimeI = ZEFF(diagTimeI);

figure(); 
plot(time,ZEFF,'-o');
xlabel('time (s)');
ylabel('ZEFF');

%% Reading - TI0 -
DepVarLabel1 = ' TI0 ';
[time,TI0,TI0_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
TI0_diagTimeI = TI0(diagTimeI);

figure(); 
plot(time,TI0,'-o');
xlabel('time (s)');
ylabel('TI0');

%% Reading - NEL -
DepVarLabel1 = ' NEL ';
[time,NEL,NEL_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
NEL_diagTimeI = NEL(diagTimeI);

figure(); 
plot(time,NEL/1e6,'-o');
xlabel('time (s)');
ylabel('NEL');

%% Reading - TE0 -
DepVarLabel1 = ' TE0 ';
[time,TE0,TE0_AVG] = ConvertingUFile1DtoSlistFormat(DirectoryContainingData,DischargeNo,DepVarLabel1,TokName);

diagTimeI = find(time<=DiagnosticTime,1,'last');
time(diagTimeI);
TE0_diagTimeI = TE0(diagTimeI);

figure(); 
plot(time,TE0/1e3,'-o');
xlabel('time (s)');
ylabel('TE0');

%% Summary report (DATA AT T = DIAGNOSTIC TIME)
RF_diagTimeI = 0;
InputParameters = [RGEO_diagTimeI, AMIN_diagTimeI, KAPPA_diagTimeI, abs(DELTA_diagTimeI), Q95_diagTimeI/0.85, abs(BT_diagTimeI), IP_diagTimeI/1e6, NEL_diagTimeI/1e6, ZEFF_diagTimeI, PNBI_diagTimeI/1e6, RF_diagTimeI time(diagTimeI) TE0_diagTimeI/1e3 TI0_diagTimeI/1e3];
disp('============= SUMMARY (TIME = DIAGNOSTIC TIME) ==============')
temp1 = sprintf('Discharge No.: %10s',DischargeNo);
disp(temp1)
temp1 = sprintf('R_major      : %10.4f m',InputParameters(1));
disp(temp1)
temp1 = sprintf('R_minor      : %10.4f m',InputParameters(2));
disp(temp1)
temp1 = sprintf('Kappa        : %10.4f ',InputParameters(3));
disp(temp1)
temp1 = sprintf('Delta        : %10.4f ',InputParameters(4));
disp(temp1)
temp1 = sprintf('Q_X          : %10.4f ',InputParameters(5));
disp(temp1)
temp1 = sprintf('B_T          : %10.4f T',InputParameters(6));
disp(temp1)
temp1 = sprintf('I_P          : %10.4f MA',InputParameters(7));
disp(temp1)
temp1 = sprintf('n_el         : %10.4e 1/cm**3',InputParameters(8));
disp(temp1)
temp1 = sprintf('Z_eff        : %10.4f ',InputParameters(9));
disp(temp1)
temp1 = sprintf('P_NBI        : %10.4f MW',InputParameters(10));
disp(temp1)
temp1 = sprintf('P_RF         : %10.4f NW',InputParameters(11));
disp(temp1)
temp1 = sprintf('DIAGNOSTIC T : %10.4f NW',time(diagTimeI));
disp(temp1)
temp1 = sprintf('TE0          : %10.4f keV',TE0_diagTimeI/1e3);
disp(temp1)
temp1 = sprintf('TI0          : %10.4f keV',TI0_diagTimeI/1e3);
disp(temp1)

%% Some inputs for BALDUR
clc

disp(' ')
disp(' ')
disp('============= INPUT FOR BALDUR ==============')
disp(' ')
temp1 = sprintf(' %sXXX Apiwat Wisitsorasak 28 June 2016 TFTR #%s',DischargeNo,DischargeNo);
disp(temp1)
temp1 = sprintf(' Ip scan; %.2f MW NBI',InputParameters(10));
disp(temp1)
temp1 = sprintf(' MMM95 w/ NTV rotation model');
disp(temp1)
temp1 = sprintf(' nebar= %.2e, B= %.2f T, I= %.2f MA, Zeff= %.2f',InputParameters(8),InputParameters(6),InputParameters(7),InputParameters(9));
disp(temp1)
disp(' ')

temp1 = sprintf(' tinit = %.4f,       ! initial time (consistent with ti0 and hton),',time(1));
disp(temp1)
temp1 = sprintf(' tmax  = %.4f,     ! final time (for comparison with SNAP output)',time(length(time)));
disp(temp1)
disp(' ')

temp1 = sprintf(' rmajor = %6.2f,    ! variables used to initialize the 1-D BALDUR',InputParameters(1)*100);
disp(temp1) 
temp1 = sprintf(' rminor = %6.2f,',InputParameters(2)*100);
disp(temp1)
temp1 = sprintf(' curent = %.2f,    ! current in kA',InputParameters(7)*1000);
disp(temp1)
temp1 = sprintf(' bz     = %.2f,   ! toroidal field in Gauss',InputParameters(6)*1e4);
disp(temp1)

X = 6;
disp(' ');
temp1 = sprintf(' hrmaj(1)    = %d*%.2f,          ! to pivot point at R = %.2f cm',X,InputParameters(1)*100,InputParameters(1)*100);
disp(temp1)
temp1 = sprintf(' hrmin(1)    = %d*%.2f,          ! at midplane',X,InputParameters(2)*100);
disp(temp1)
disp(' ')

temp1 = sprintf(' hpowmw(1) = %d*%.2f,      ! %.2f MW total',X,InputParameters(10)/X,InputParameters(10));
disp(temp1)
disp(' ')

temp1 = sprintf(' rmajbt(1) = %d*%.4f,   ! R  m',X,InputParameters(1));
disp(temp1)
temp1 = sprintf(' rminbt(1) = %d*%.4f,  ! Minor radius %.f',X,InputParameters(2),InputParameters(2));
disp(temp1)
temp1 = sprintf(' elngbt(1) = %d*%.2f,     ! elong  = %.2f,',X,InputParameters(3),InputParameters(3));
disp(temp1)
temp1 = sprintf(' trngbt(1) = %d*%.2f,     ! triang = %.2f,',X,InputParameters(4),InputParameters(4));
disp(temp1)
temp1 = sprintf(' btort(1)  = %d*%.2f,     ! B(T) @ rtort,',X,InputParameters(6));
disp(temp1)
temp1 = sprintf(' rtort(1)  = %d*%.4f,     ! major radius in meters where btort is given,',X,InputParameters(1));
disp(temp1)
temp1 = sprintf(' curmat(1) = %d*%.4f,   !  plasma current (megamps),',X,InputParameters(7));
disp(temp1)
disp(' ')



%% Find DENMON from given gftime 0.,1.,3.,3.2,3.33,3.419,3.429,3.47,3.588,3.608,3.725,3.9,4.5,4.6,5.,
% gftime = [1.0, 2.0, 3.0, 3.1, 3.2, 3.3, 3.5, 3.9, 3.95, 99.0];
gftime = [0.,1.,3.,3.2,3.33,3.419,3.429,3.47,3.588,3.608,3.725,3.9,4.5,4.6,5.];
k=0;
line1 = ' ';
line2 = line1;
for i=1:length(gftime)
    k=k+1;
    j = max(find(time<=gftime(i)));
    if isempty(j)==1
%         disp('j is empty');
        j=1;
    end
    gftime(i);
    denmon(k) = NEL(j);
    temp1 = sprintf('gftime = %10.2f s; denmon = %10.2e ',gftime(i),denmon(k)/1e6);
%     disp(temp1);
    
    line1 = sprintf('%s%8.2f, ',line1,gftime(i));   
    line2 = sprintf('%s%2.2e, ',line2,denmon(k)/1e6);
end
line1 = sprintf(' gftime=%s',line1);
line2 = sprintf(' denmon=%s',line2);
disp(' ')
disp(line1)
disp(line2)
break
%% Summary report (USE THE AVERAGE VALUE)
% RF_AVG = 0;
% InputParameters = [RGEO_AVG, AMIN_AVG, KAPPA_AVG, abs(DELTA_AVG), Q95_AVG/0.85, abs(BT_AVG), IP_AVG/1e6, NEL_AVG/1e6, ZEFF_AVG, PNBI_AVG/1e6, RF_AVG];
% disp('============= SUMMARY (average values) ==============')
% temp1 = sprintf('Discharge No.: %10s',DischargeNo);
% disp(temp1)
% temp1 = sprintf('R_major      : %10.4f m',InputParameters(1));
% disp(temp1)
% temp1 = sprintf('R_minor      : %10.4f m',InputParameters(2));
% disp(temp1)
% temp1 = sprintf('Kappa        : %10.4f ',InputParameters(3));
% disp(temp1)
% temp1 = sprintf('Delta        : %10.4f ',InputParameters(4));
% disp(temp1)
% temp1 = sprintf('Q_X          : %10.4f ',InputParameters(5));
% disp(temp1)
% temp1 = sprintf('B_T          : %10.4f T',InputParameters(6));
% disp(temp1)
% temp1 = sprintf('I_P          : %10.4f MA',InputParameters(7));
% disp(temp1)
% temp1 = sprintf('n_el         : %10.4e 1/cm**3',InputParameters(8));
% disp(temp1)
% temp1 = sprintf('Z_eff        : %10.4f ',InputParameters(9));
% disp(temp1)
% temp1 = sprintf('P_NBI        : %10.4f MW',InputParameters(10));
% disp(temp1)
% temp1 = sprintf('P_RF         : %10.4f NW',InputParameters(11));
% disp(temp1)
% temp1 = sprintf('TE0          : %10.4f keV',TE0_AVG/1e3);
% disp(temp1)
% temp1 = sprintf('TI0          : %10.4f keV',TI0_AVG/1e3);
% disp(temp1)