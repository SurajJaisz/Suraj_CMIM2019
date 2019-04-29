function C_r_dtt = revolute_joint_dtt(i, j, s_i, s_j, q, qdot)

idx_i = body_idx(i);
r_i = q(idx_i(1:2));
phi_i = q(idx_i(3));
idx_j = body_idx(j);
r_j = q(idx_j(1:2));
phi_j = q(idx_j(3));

C_r_dtt = [rot(phi_i) * s_i * (phi_i)^2 - rot(phi_j) * s_j * (phi_j)^2];
% C_r_dtt = [rot(phi_i) * s_i * (qdot(idx_i(3)))^2 - rot(phi_j) * s_j * (qdot(idx_j(3)))^2];
