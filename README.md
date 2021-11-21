# MD
MD simulations of lipid bilayers and photosensible molecules

# Procedure to obtain the CHARMM files

# Minimization
# In the case that there is a problem during minimization using a single precision of GROMACS, please try to use
# a double precision of GROMACS only for the minimization step.
gmx grompp -f step6.0_minimization.mdp -o step6.0_minimization.tpr -c step5_input.gro -r step5_input.gro -p topol.top -n index.ndx
gmx mdrun -v -deffnm step6.0_minimization


# Equilibration
gmx grompp -f step6.1_equilibration.mdp -o step6.1_equilibration.tpr -c step6.0_minimization.gro -r step5_input.gro -p topol.top -n index.ndx
gmx mdrun -v -deffnm step6.1_equilibration

gmx grompp -f step6.2_equilibration.mdp -o step6.2_equilibration.tpr -c step6.1_equilibration.gro -r step5_input.gro -p topol.top -n index.ndx
gmx mdrun -v -deffnm step6.2_equilibration

gmx grompp -f step6.3_equilibration.mdp -o step6.3_equilibration.tpr -c step6.2_equilibration.gro -r step5_input.gro -p topol.top -n index.ndx
gmx mdrun -v -deffnm step6.3_equilibration
