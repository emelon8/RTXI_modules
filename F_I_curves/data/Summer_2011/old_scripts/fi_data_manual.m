my_file='fi_curves_Jul_08_11_A1';
cols=3;

importfile([my_file,'.txt']);

eval(['my_data=' my_file '(1:end-1,2:3);'])
eval([my_file '=ctranspose(reshape(ctranspose(my_data),cols,[]));'])

clear my_data

% my_file='fi_curves_Aug_05_11_A5';
% cols=3;
% 
% importfile([my_file,'.txt']);
% 
% eval(['my_data=' my_file '(1:end-1,2:3);'])
% my_data2=reshape(my_data',cols,[])';
% 
% clear my_data
% 
% eval([my_file '= my_data2;'])
% 
% clear my_data2