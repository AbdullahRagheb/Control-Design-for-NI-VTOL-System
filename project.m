% System transfer function
s = tf('s');
G = 0.79 / (0.222*s^2 + 0.34*s + 1);

% Initial guesses for lead and lag compensator parameters
K_lead_initial = 1; % Initial lead compensator gain
tau = 1; % Time constant for both compensators
beta = 0.1; % Beta for lead compensator
K_lag = 1; % Lag compensator gain
mu = 10; % Mu for lag compensator

% Define lead and lag compensators
C_lead = K_lead_initial * (tau*s + 1) / (beta*tau*s + 1);
C_lag = K_lag * (mu*tau*s + 1) / (mu*tau*s + 1);

% Calculate K_lead(0) for use in feedback adjustment or elsewhere
K_lead = 5;
alpha = 0.4;
K_lead_0 = K_lead / alpha;

% Calculate G(0) for the plant G(s)
G_0 = 0.79; % As calculated from G(s) at s = 0

% Calculate the feed-forward gain
feed_forward_gain = 1 / G_0;

% Combine lead and lag compensators in series with the plant
G_open_loop = series(series(C_lead, C_lag), G);

% Create closed-loop transfer function from open-loop transfer function
G_closed_loop = feedback(G_open_loop, 1);

% Plot the margin of the open-loop transfer function
figure;
margin(G_open_loop); % For phase margin and crossover frequency analysis

% Plot the step response of the closed-loop transfer function
figure;
step(G_closed_loop); % For analyzing settling time and steady-state error

