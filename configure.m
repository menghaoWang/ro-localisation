step_interval = 10;
nParticles = 3000;
resample_beta = 0.0;
%nNLOS = 0;

generator.V = 0.1;
generator.G = 0.5;
generator.sigmaV = 0.01;%Q
generator.sigmaG = 0.01;

generator.beacon_std = 0.17;
generator.beacon_sigma = 0.0119;
generator.alpha_ratio = 1;
generator.beacon_max = 20;

ro_model.prob_change_bias = 0.02;
ro_model.range_change_bias = 20;