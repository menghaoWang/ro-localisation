function particle = compute_likelihood(particle,obs,beacon_std)
n = size(obs,1);
new_w = 1+0.5;
new_w = 0;
for i=1:n%n obs
    beacon_pose = particle.beacons(:,i);
    robot_pose = particle.xp(1:2,1);
    expected_range = distance(robot_pose,beacon_pose);
    obs_range = obs(i)-particle.state(i);
    expected_range = expected_range + 0.1*(1.01-exp(-0.17*expected_range));
    ll = (expected_range - obs_range) / beacon_std;
    new_w = new_w + (-0.5*ll*ll);
end
particle.w = particle.w + new_w;
