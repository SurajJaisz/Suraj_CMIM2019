function [PE, KE] = osc_energy(u, v, omega)
% Function for returing the potential and kinetic energy of an oscillating system
% Created by:   Suraj Jaiswal
% Date:         15.03.2019
% Course:       BK70A0600_07.01.2019 Computational Methods in Mechanics
% Exercise:     4.10: Compute the energy in oscillations

PE = (1/2)*omega^2*u^2;
KE = (1/2)*v^2;
end