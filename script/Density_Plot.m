function [outputArg1,outputArg2] = Density_Plot(filname,molec_name,time)
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
fileID = fopen(filname,'r');

%% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

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
plot(Z,oopte ,'DisplayName',[molec_name '@Time:' time],'LineWidth',2);
xlim([ min(Z) max(Z)]);
box on;
grid on;
out = gcf;
end

