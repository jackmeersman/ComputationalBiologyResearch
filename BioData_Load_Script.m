% Note - this script requires that the current directory be set to the
% directory holding the SBML files

initCobraToolbox();
sbmlFiles = dir('*.xml');
numberOfFiles = length(sbmlFiles);
BioData = cell(1, numberOfFiles);
for k=1:numberOfFiles
    BioData{k} = readCbModel(sbmlFiles(k).name);
end
