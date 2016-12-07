function obs = observation_generator(bec,ground_truth,generator)
nbec = size(bec,2);
obs = zeros(nbec,1);
for i=1:nbec
    D2 = (bec(1,i)-ground_truth(1))*(bec(1,i)-ground_truth(1)) + (bec(2,i)-ground_truth(2))*(bec(2,i)-ground_truth(2));
    dis = sqrt(D2);
    obs(i) = dis + 0.1*(1.01-exp(-dis*generator.beacon_std)) + randn * generator.beacon_sigma; %see in paper
end
%%%