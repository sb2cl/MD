function Density_Plot_last()
%Density_Plot Function to plot the density resulting from MD simulations.
%   This function plot the density from a gromacs density file executed
%   like this:
%        gmx density -s step7_production.tpr -f step7_production.trr 
%                    -o density_NN_Lum_out_200ns.xvg -d Z -sl 500 
%                    -b 0 -e 20000000 -xvg none -ng 3
%   where the density is calculated integrating from -b to -e (in picosec)
%   Input Arguments aare

formatSpec = '%12f%17f%15f%f%[^\n\r]';

%% Open the text file.
fileID = fopen('last.xvg','r');

%% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

opts = delimitedTextImportOptions("NumVariables",2);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = ["Molecule", "IC"];
opts.VariableTypes = ["string", "string"];
data = readtable('last_data.dat', opts);



%% Allocate imported array to column variable names
Z = dataArray{:, 1};
Molecule = dataArray{:, 4};
DOPC = dataArray{:, 3};
Water = dataArray{:, 2};
oopte = smooth(50*Molecule);
Z_centered = Z - (max(Z)-min(Z))/2;
Z = Z_centered;
plot(Z,smooth(Water,'sgolay'),'DisplayName','Water','LineWidth',2);
hold on;
plot(Z,smooth(DOPC,7,'sgolay'),'DisplayName','DOPC ','LineWidth',2);
plot(Z,oopte ,'DisplayName',data.Molecule(1),'LineWidth',2);
xlim([ min(Z) max(Z)]);
box on;
grid on;
legend 
% Create xlabel
xlabel('Z Coordinate (nm)','Interpreter','latex');
% Create ylabel
ylabel('Density ($kg \, m/{S^{-3}N}$)','Interpreter','latex');
title(data.IC);
print -dpng -painters -r300 'density.png'
end

