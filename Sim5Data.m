function [p_J,q_a,q_acc,theta,x,dot_x,dot_theta,P,V,w_fw,tau_c,dPi,Qi,...
    dPo,Qo,P_acc,power,energy] = Sim5Data(t,x)

global R L V_0 gamma P_0 A_p J_fw K_p w_des C_acc sim_type Ao_nom ...
    Ai_nom rho cv_type P_acc_dm dt

p_J=x(:,1);
q_a=x(:,2);
theta=x(:,3);
if strcmp(sim_type,'pump')==1
    q_acc=x(:,4);
else
    q_acc=0.*p_J;
end

if strcmp(sim_type,'pump')==1; extras=zeros(length(t),12);
else extras=zeros(length(t),7);
end
energy=zeros(length(t)+1,1);
for i=1:length(t);
    [dx,ext]=Sim5Func(t(i),x(i,:));
    extras(i,:)=ext;
    energy(i+1)=energy(i)+dt*abs(extras(i,7)*extras(i,6));
end

x=extras(:,1);
dot_x=extras(:,2);
dot_theta=extras(:,3);
P=extras(:,4);
V=extras(:,5);
w_fw=extras(:,6);
tau_c=extras(:,7);
if strcmp(sim_type,'pump')==1
    dPi=extras(:,8);
    Qi=extras(:,9);
    dPo=extras(:,10);
    Qo=extras(:,11);
    P_acc=extras(:,12);
else
    dPi=0.*x;
    Qi=0.*x;
    dPo=0.*x;
    Qo=0.*x;
    P_acc=0.*x;
end
power=abs(tau_c).*abs(dot_theta);
energy=energy(2:length(energy));

end

