function do_plot(h, particles,GT,obs,veh,bec)

max_show = 1000;
if (size(particles,2) > max_show)
    xp = [particles(1:max_show).xp];
else
    xp = [particles.xp];
end
set(h.xvp, 'xdata', xp(1,:), 'ydata', xp(2,:));
xt= transformtoglobal(veh,GT);
set(h.xt, 'xdata', xt(1,:), 'ydata', xt(2,:));
n = size(bec,2);
for i=1:n
    set(h.bec(i),'Position',[bec(1,i)-obs(i),bec(2,i)-obs(i),obs(i)*2,obs(i)*2]);
end

drawnow
