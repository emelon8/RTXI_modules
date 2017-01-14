clear;clc;close all
tic

Ttot=25;
current=[-220 -20];
subtractionsize=[-50];
stepsizei=[20];
gLL=[0 7.5 15];
slp=[5 10 15];
gBmax=[0 50 500];

%preallocating vectors
time=cell(numel(gLL),numel(slp),numel(gBmax));
voltage=cell(numel(gLL),numel(slp),numel(gBmax));
currents=cell(numel(gLL),numel(slp),numel(gBmax));
fi=cell(numel(gLL),numel(slp),numel(gBmax));
fifits=cell(numel(gLL),numel(slp),numel(gBmax));

itworked=1;

for k=1:numel(gLL)
    for m=1:numel(slp)
        for n=1:numel(gBmax)
            for o=1:numel(current)
                [t,v,currentstep,firate,fifit]=msmodel_exif_function(Ttot,current(o),subtractionsize,stepsizei,gLL(k),slp(m),gBmax(n));
                
                time{k,m,n,o}=t;
                voltage{k,m,n,o}=v;
                currents{k,m,n,o}=currentstep;
                fi{k,m,n,o}=firate;
                fifits{k,m,n,o}=fifit;
            end
            if fifits{k,m,n,2}(1)/fifits{k,m,n,1}(1)>1
                works{itworked,:}={current subtractionsize stepsizei gLL(k) slp(m) gBmax(n)};
                itworked=itworked+1;
            end
        end
    end
end