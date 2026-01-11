% Ae 121 Set 4 Code

%% Problem 1 Part C: Plot thrust and ISP vs rocket altitude for Viking 5C and 4B rockets (based on nozzle parameters)

%Define static variables
g_0 = 9.81; % gravity in m/s^2
gamma = 1.2; 
R = 361.48; % This R value is in J/kg*K given that the fuel's molar mass is 0.023 kg/mol
%R = 8.314; % This R value is in J/mol*K

% Define variables specific to Viking 5C and 4B
mdot_5c = 275.2;
mdot_4b = 278;
Ae_5c = 0.84;
Ae_4b = 2.45;
pe_5c = 68170;
pe_4b = 17036;
Me_5c = 3.31236;
Me_4b = 4.05738;
Te_5c = 1597.39;
Te_4b = 1265.95;
ve_5c = Me_5c*sqrt(gamma*R*Te_5c);
ve_4b = Me_4b*sqrt(gamma*R*Te_4b);
% These variables were solved for by hand in the "Defined Variable
% Calculations for Viking 5C and 4B" pdf


% Solve for thrust and Isp below

% First define the altitudes and the atmospheric pressure that will be
% used in the Thrust/Isp plots wrt altitude
alt = [0 1 2 5 10 12 15 20 25 30 40 50 60 70 80 90 100];
p_a = [101300 89900 79500 54000 26500 19400 12100 5500 2500 1200 300 80 20 6 1 0.2 0.03];


% Initialize thrust and Isp arrays 
Thrust_5c = zeros(length(alt), 1);
Thrust_4b = zeros(length(alt), 1);
Isp_5c = zeros(length(alt), 1);
Isp_4b = zeros(length(alt), 1);

% Solve for Thrust and Isp for both Viking 5C and Viking 4B rockets for
% each given altitude. 

for h = 1:length(alt)
    Thrust_5c(h) = mdot_5c*ve_5c + (pe_5c - p_a(h))*Ae_5c;
    Isp_5c(h) = Thrust_5c(h)/(mdot_5c*g_0);

    Thrust_4b(h) = mdot_4b*ve_4b + (pe_4b - p_a(h))*Ae_4b;
    Isp_4b(h) = Thrust_4b(h)/(mdot_4b*g_0);  
end

% Plot the Thrust of Viking 5C and 4B vs the altitude
figure;
hold on;
plot(alt, Thrust_5c);
plot(alt, Thrust_4b);
hold off;
xlabel("Altitude (km)");
ylabel("Thrust (N)");
title("The Thrust of Viking 5c and 4b Engines wrt Rocket Altitude");
legend("5c","4b");

% Plot the Isp of Viking 5C and 4B vs the altitude
figure;
hold on;
plot(alt, Isp_5c);
plot(alt, Isp_4b);
hold off;
xlabel("Altitude (km)");
ylabel("Isp (s)");
title("The Isp of Viking 5c and 4b Engines wrt Rocket Altitude");
legend("5c","4b");
%% Problem 1 Part D: Plot thrust and ISP vs rocket altitude with ideal nozzle expansion

% Part D
% Initialize other variables
p0_5c = 5800*10^3;
p0_4b = 5850*10^3;
T0 = 3350;

% Solve for thrust and Isp below

% First define the altitudes and the atmospheric pressure that will be
% used in the Thrust/Isp plots wrt altitude
alt = [0 1 2 5 10 12 15 20 25 30 40 50 60 70 80 90 100];
p_a = [101300 89900 79500 54000 26500 19400 12100 5500 2500 1200 300 80 20 6 1 0.2 0.03];

% Initialize thrust and Isp arrays 
Thrust_5c_2 = zeros(length(alt), 1);
Thrust_4b_2 = zeros(length(alt), 1);
Isp_5c_2 = zeros(length(alt), 1);
Isp_4b_2 = zeros(length(alt), 1);

% Initialize exit velocity, exit Mach number, and exit temperature as these
% change with the atmospheric pressure in an ideal nozzle expansion
ve_5c = zeros(length(alt), 1);
ve_4b = zeros(length(alt), 1);
Me_5c = zeros(length(alt), 1);
Me_4b = zeros(length(alt), 1);
Te_5c = zeros(length(alt), 1);
Te_4b = zeros(length(alt), 1);

% Solve for exit Mach number then exit temperature and velocity using 
% isentropic flow equations (Mach number relations), then solve for Thrust and Isp for 
% both Viking 5C and Viking 4B rockets at each given altitude. 

for h = 1:length(alt)
    Me_5c(h) = sqrt(((p_a(h)/(p0_5c))^((gamma-1)/-gamma)-1)*(2/(gamma-1)));
    Te_5c(h) = ((1+(((gamma-1)/2)*Me_5c(h)^2))^(-1)*T0);
    ve_5c(h) = Me_5c(h)*sqrt(gamma*R*Te_5c(h));
    Thrust_5c_2(h) = mdot_5c*ve_5c(h);
    Isp_5c_2(h) = Thrust_5c_2(h)/(mdot_5c*g_0);

    Me_4b(h) = sqrt(((p_a(h)/(p0_4b))^((gamma-1)/-gamma)-1)*(2/(gamma-1)));
    Te_4b(h) = ((1+(((gamma-1)/2)*Me_4b(h)^2))^(-1)*T0);
    ve_4b(h) = Me_4b(h)*sqrt(gamma*R*Te_4b(h));
    Thrust_4b_2(h) = mdot_4b*ve_4b(h);
    Isp_4b_2(h) = Thrust_4b_2(h)/(mdot_4b*g_0);  

end

% Plot the Thrust of Viking 5C and 4B vs the altitude
figure;
hold on;
plot(alt, Thrust_5c);
plot(alt, Thrust_4b);
plot(alt, Thrust_5c_2);
plot(alt, Thrust_4b_2);
hold off;
xlabel("Altitude (km)");
ylabel("Thrust (N)");
title("Thrust of Viking 5c and 4b Engines wrt Rocket Altitude (ideal expansion)");
legend("5c actual","4b actual","5c ideal","4b ideal");

% Plot the Isp of Viking 5C and 4B vs the altitude
figure;
hold on;
plot(alt, Isp_5c, 'Marker','*');
plot(alt, Isp_4b, 'Marker','o');
plot(alt, Isp_5c_2, 'Marker','+');
plot(alt, Isp_4b_2, 'Marker','x');
hold off;
xlabel("Altitude (km)");
ylabel("Isp (s)");
title("The Isp of Viking 5c and 4b Engines wrt Rocket Altitude (ideal expansion)");
legend("5c actual","4b actual","5c ideal","4b ideal");

% Plot altitude vs pressure to see a general trend in atmospheric pressure
% for Earth farther away from its surface. 
figure;
plot(alt,p_a)
xlabel("Altitude");
ylabel("Pressure");
title("Altitude versus Pa");


%% Problem 4, Rayleigh and Fanno lines (Plotting Normal Shock Relations)

% Set initial variables (variable right before normal shock)
M1 = 2.5;
p1 = 1.5*10^6;
T1 = 300;

% Set constant variables
gamma = 1.4;
R = 8.314;

% Plot the Rayleigh and Fanno lines

% The range of Mach numbers used for each line (or curve)
M = linspace(0.3, 3, 70);

% % Initializing temperature, pressure, and entropy ratio arrays for 
% pressure and temperature ratios derived from isentropic flow relations and 
% the entropy equation (specifically the one derived from the second law of 
% thermo, with subsitutions using the first law of thermo, enthalpy 
% equation for an ideal gas, and the ideal gas law) for both Rayleigh and 
% Fanno lines.

Tratio_R = zeros(1, length(M));
Pratio_R = zeros(1, length(M));
Sratio_R = zeros(1, length(M));

Tratio_F = zeros(1, length(M));
Pratio_F = zeros(1, length(M));
Sratio_F = zeros(1, length(M));

% Calculating temperature (T/T1), pressure (P/P1), and entropy (S/R) ratios
% for Rayleigh and Fanno lines for each Mach number in the Mach number
% range M made earlier (line 172)

for h = 1:length(M)
    % Rayleigh Calculations 
    Pratio_R(h) = (1 + (gamma*M1^2))/(1 + (gamma*M(h)^2));
    Tratio_R(h) = (Pratio_R(h)^2)*((M(h)/M1)^2);
    Sratio_R(h) = ((gamma/(gamma-1))*log(Tratio_R(h))) - log(Pratio_R(h));
    
    % Fanno Calculations
    Tratio_F(h) = (2+((gamma-1)*M1^2))/(2+((gamma-1)*M(h)^2));
    Pratio_F(h) = ((Tratio_F(h))^(0.5))*(M1/M(h));
    Sratio_F(h) = ((gamma/(gamma-1))*log(Tratio_R(h))) - log(Pratio_R(h));
end

% Plotting both Rayleigh and Fanno lines 
figure;
hold on;
plot(Sratio_R, Tratio_R);
plot(Sratio_F,Tratio_F);
xlim([0 2.5]);
ylabel("T/T1");
xlabel("S/R");
title("Rayleigh and Fanno Lines");
legend ("Rayleigh","Fanno");

