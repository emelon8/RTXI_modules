function cell_txt_data(recdate,cellnum,module,trials)

for k=1:trials
    data_name=[module '_' recdate '_' cellnum num2str(k)];
    data_individual(data_name);
end

function data_individual(my_file)
% example: fi_data('fi_curves_Jul_20_11_A9') will pull the text file of
% that name and output the matlab variable of that name.
cols=3;
importfile([my_file,'.txt']);

evalin('base',['my_data=' my_file '(1:end-1,2:3);'])
evalin('base',[my_file '=ctranspose(reshape(ctranspose(my_data),' num2str(cols)...
    ',[]));clear my_data'])

function importfile(fileToRead1)
%IMPORTFILE(FILETOREAD1)
%  Imports data from the specified file
%  FILETOREAD1:  file to read

%  Auto-generated by MATLAB on 27-Jun-2011 17:14:00

% Import the file
rawData1 = importdata(fileToRead1);

% For some simple files (such as a CSV or JPEG files), IMPORTDATA might
% return a simple array.  If so, generate a structure so that the output
% matches that from the Import Wizard.
[unused,name] = fileparts(fileToRead1); %#ok
newData1.(genvarname(name)) = rawData1;

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end