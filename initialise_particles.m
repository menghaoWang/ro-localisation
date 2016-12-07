function p = initialise_particles(np,start_pose,lms)
nlm = size(lms,2);

for i=1:np
    p(i).xp = start_pose;
    p(i).beacons = lms;
    p(i).w= 0;
    p(i).state = zeros(nlm,1);
end