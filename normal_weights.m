function particles = normal_weights(particles,nParticles)
max_w = particles(1).w;
for i=1:nParticles
    max_w = max(particles(i).w,max_w);
end
for i=1:nParticles
    particles(i).w = particles(i).w - max_w;
end