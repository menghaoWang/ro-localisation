function h= setup_animations(bec,wp)
figure
plot(bec(1,:),bec(2,:),'g*')
hold on, axis equal

wp = [wp wp(:,1)];
plot(wp(1,:),wp(2,:), wp(1,:),wp(2,:),'ro')

h.xt= patch(0,0,'g','erasemode','xor'); % vehicle true
h.xm= patch(0,0,'r','erasemode','xor'); % mean vehicle estimate
h.obs= plot(0,0,'y','erasemode','xor'); % observations
h.xfp= plot(0,0,'r.','erasemode','background'); % estimated features (particle means)
h.xvp= plot(0,0,'r.','erasemode','xor'); % estimated vehicle (particles)
h.cov= plot(0,0,'erasemode','xor'); % covariances of max weight particle
n = size(bec,2);
r = 0.1;
for i=1:n
    h.bec(i) = rectangle('Position',[bec(1,i)-r,bec(2,i)-r,r*2,r*2],'Curvature',[1,1])%plot(0,0,'k','erasemode','xor');
end


