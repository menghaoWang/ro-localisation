%augmented state particle filter, used to range-only localization

clear all
close all
clc

configure;%load configure
load('barrier_2.mat');%wp means to GT and bec shows that robot know the beacons exactly location
%load('one_beac.mat');
nbeacon = size(bec,2);
nwp = size(wp,2);

ground_truth = [wp(:,1);0];
robot_pose = ground_truth;
particles = initialise_particles(nParticles,robot_pose,bec);

iwp = 1;%current reached

h= setup_animations(bec,wp,barriers);
veh= [0 -0.2 -0.2; 0 -0.2 0.2];
istep = 0;
while(1)
    [dV,dG,ground_truth,iwp] = prediction_generator(ground_truth,wp,iwp,generator,ro_model);
    for i=1:nParticles
        particles(i) = ASPF_predict(particles(i),dV,dG,generator,ro_model);
    end
    if (mod(istep,step_interval))%sensor reading
        
        obs = observation_generator(bec,ground_truth,generator,barriers);
        for i=1:nParticles
            particle = particles(i);
            particle = compute_likelihood(particle,obs,generator.beacon_std);
            particles(i) = particle;
        end 
        particles = normal_weights(particles,nParticles);
        %observe();
        beta = ESS(particles,nParticles);
        if (beta < resample_beta)
            beta;
           particles = ASPF_resample(particles,nParticles);
        end
        do_plot(h,particles,ground_truth,obs,veh,bec);
    end
    istep = istep + 1
end