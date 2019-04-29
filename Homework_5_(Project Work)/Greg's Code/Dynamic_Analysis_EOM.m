function dydt = Dynamic_Analysis_EOM(t,y,inputData)
%This function is for dynamic analaysis

for ii = 1:length(y)
    q(ii,1) = y(ii); % position
end

M = mass_matrix(inputData.body);
F = force_vector(inputData.grav, inputData.body);

C_q = inputData.C_q_fun(t, q(1:12)); % Jacobian of our constraints

G = inputData.G_fun(t, q(1:12), q(13:24));
G_Stab = inputData.G_Stab_fun(t, q(1:12), q(13:24));

I = zeros(length(G_Stab));

sysM = [M,   C_q';
        C_q, I];

sysF = [F;
        G_Stab];
   
qdotdot = sysM\sysF;

dydt =[ y(13);
        y(14);
        y(15);
        y(16);
        y(17);
        y(18);
        y(19);
        y(20);
        y(21);
        y(22);
        y(23);
        y(24);
        qdotdot(1);
        qdotdot(2);
        qdotdot(3);
        qdotdot(4);
        qdotdot(5);
        qdotdot(6);
        qdotdot(7);
        qdotdot(8);
        qdotdot(9);
        qdotdot(10);
        qdotdot(11);
        qdotdot(12)];
end

