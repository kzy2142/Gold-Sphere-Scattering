% Optimization the parameters for pHd using non-linear fitting 
% 2 fitting parameters: coating thickness and the refractive index of it

%% creating a fitting model for the pHd particles

% par(1) complex refractive index of the coating
% par(2) thickness of the coating
% x: wavelength

m1 = 1.59;  % core refractive index
a = 220;
nor = 1;
modelfun = @(par, x)My_plot_Q_over_lambda(m1, par(1), a, par(2), x, nor);  

%% reading data (pH=7 normalized spectrum)
filename = 'pHd_scs_pH7.csv';
Wave_Spec = dlmread(filename,' ',1,0);
Wave_Spec = Wave_Spec(1:400,:);
wavelength = Wave_Spec(:,1);
spectrum = Wave_Spec(:,2);

%% fitting 
beta0 = [1.5279, 9.5273];  % initializing pars [m2(real), core radius, coating thickness]
[beta,R,~,~,~,~] = nlinfit(wavelength,spectrum,modelfun,beta0);

%% plotting
m2 = beta(1);
c = beta(2);

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

