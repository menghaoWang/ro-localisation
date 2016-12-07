function particle = ASPF_predict(particle,dV,dG,generator,ro_model)
%
V = dV + randn*dV*generator.sigmaV;
G = dG + randn*generator.sigmaG;

particle.xp = se2_plus(particle.xp,V,G);
n = size(particle.state,1);
for i=1:n
    particle.state(i) = offset_transition_model(particle.state(i),ro_model);
end

function state = offset_transition_model(state,ro_model)
if(rand < ro_model.prob_change_bias)
    state = (ro_model.range_change_bias + 1)*rand - ro_model.range_change_bias;
end