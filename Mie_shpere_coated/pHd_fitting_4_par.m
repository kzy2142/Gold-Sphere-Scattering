% Optimization the parameters for pHd using non-linear fitting 
% 4 fitting parameters, see below
%% creating a fitting model for the pHd particles

% par(1) complex refractive index of the core
% par(2) complex refractive index of the coating
% par(3) core radius
% par(4) thickness of the coating
% x: wavelength

nor = 1;
modelfun = @(par, x)My_plot_Q_over_lambda(par(1), par(2), par(3), par(4), x, nor);  

%% reading data (pH=7 normalized spectrum)
filename = 'pHd_scs_pH0.csv';
Wave_Spec = dlmread(filename,' ',1,0);
Wave_Spec = Wave_Spec(1:400,:);
wavelength = Wave_Spec(:,1);
spectrum = Wave_Spec(:,2);

%% fitting 
beta0 = [1.60, 1.90, 270, 40];  % initializing pars [m2(real), core radius, coating thickness]
[beta,R,~,~,~,~] = nlinfit(wavelength,spectrum,modelfun,beta0);

%% plotting
m1 = beta(1);
m2 = beta(2);
a = beta(3);
c = beta(4);

figure()
Q = My_plot_Q_over_lambda(m1,m2,a,c,wavelength,nor);
subplot(2,1,1)
plot(wavelength,Q,'LineWidth',2)
ylabel('Normalized SCS', 'FontSize',14)
xlabel('Wavelength (nm)','FontSize',14)
hold on
plot(wavelength, spectrum,'LineWidth',2)
subplot(2,1,2)
plot(wavelength,R,'LineWidth',2)
ylabel('Residual','FontSize',14)
xlabel('Wavelength (nm)','FontSize',14)

fprintf(['m1: ',num2str(m1),'\nm2: ',num2str(m2),'\nradius: ',num2str(a),'nm','\nthickness: ',num2str(c),'nm\n'])

