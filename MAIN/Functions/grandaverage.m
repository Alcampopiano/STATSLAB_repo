function [alldatacell] = grandaverage(STATS,nboot,numpnts,condfiles_subs)

% creates grand averages that can be used for robust group stats
% like in Rousselet 2008, and Desjardins 2013 (percentile bootstrap tests).

% It will stack subjects along the 3rd dimension (e.g., 1000 surrogates X time X subjects)
% and then average across subjects so the resulting array is for example 1000 X TFs.

%{
    Inputs:
    nboot = number of bootstrapps that are in the incoming subject files
    numpnts = TFs
    numsubs = Number of subjects
    condfiles_subs=cell array of strings (indicating a subjects surrogates X TF) for each condition separated by cell
%}

% preallocate
[rowfile colfile]=size(condfiles_subs);
alldatacell=cell(1,colfile);


if any(strcmp({'chanclust' 'gfa'},STATS.measure));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %datacellind=randi(rowfile,1000,rowfile); % jun4th/15, remove after testing
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i=1:colfile;
        [subrow subcol]=size(condfiles_subs{i});
        subdata=zeros(nboot,numpnts,subrow);
        
        for j=1:subrow;
            tempload=load(condfiles_subs{1,i}{j,:});
            subdata(:,:,j)=tempload.data;
            clear tempload
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % TESTING resampling procedure, remove or incorporate this after testing jun4th/15
        % resample in a different way from Datacell, the result of
        % GroupFigure_sample & GroupStatistics_sample will now be a resampling, NOT
        % simply including all subjects as this function should normally do
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %     for q=1:1000;
        %         alldatacell{1,i}(q,:)=trimmean(subdata(q,:,datacellind(q,:)),40,3);
        %     end
        
        % this line SHOULD be here but was commented out due to testing on
        % jun4th/15
        % create grand avergae surrogates
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        alldatacell{1,i}=mean(subdata,3);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
elseif any(strcmp({'ersp' 'itc'},STATS.measure));
    
    
    
    
    for i=1:colfile;
        [subrow subcol]=size(condfiles_subs{i});
        
        
        
        
        for j=1:subrow;
            
            % memory map load
            datamap=mapread(condfiles_subs{1,i}{j,:},'dat','datsize',[STATS.freqbins,STATS.timesout,STATS.nboot]);
            
            % write the condition waveforms for each subject to disk
            condition=mean(datamap.Data.dat,3);
            save([condfiles_subs{1,i}{j,:}(1:end-4),'_TF_waves.mat'],'condition');
            clear condition
            
            if j==1;
                
                dat_avg=datamap;
                
                % create a temp file name to store large freq surrogates
                [~,tmpfname]=fileparts(tempname);
                
            elseif j>1;
                
                if j>2;
                    oldtmpfname=tmpfname;
                end
                % create a temp file name to store large freq surrogates
                [~,tmpfname]=fileparts(tempname);
                mapwrite((dat_avg.Data.dat+datamap.Data.dat)/2,[tmpfname,'.map'],'datsize',[STATS.freqbins STATS.timesout,STATS.nboot]);
                dat_avg=mapread([tmpfname,'.map'],'dat','datsize',[STATS.freqbins,STATS.timesout,STATS.nboot]);
                
                try
                    warning off
                    delete([oldtmpfname,'.map']);
                    warning on
                catch
                end
                
                
            end
            clear datamap
        end
        
        % try to delete previous mapped files;
        warning off
        delete(['groupboots_',STATS.savestring, '_', STATS.condnames{i},'.map']);
        warning on
        
        % save full surrogate arrays X condition
        mapwrite(dat_avg.Data.dat,['groupboots_',STATS.savestring, '_', STATS.condnames{i},'.map'],'datsize',[STATS.freqbins STATS.timesout STATS.nboot]);
        
        % save mean TF waveforms
        condition=mean(dat_avg.Data.dat,3);
        save(['group_TFwaves_',STATS.savestring, '_', STATS.condnames{i},'.mat'],'condition');
        clear condition
        %mapwrite(mean(dat_avg.Data.dat,3),['group_TFwaves_',STATS.savestring, '_', STATS.condnames{i},'.map'],'datsize',[STATS.freqbins STATS.timesout]);
        
        % fill up datacell with the full TF surrogates to be used in statistics.
        alldatacell{1,i}=mapread(['groupboots_',STATS.savestring, '_', STATS.condnames{i},'.map'], 'dat','datsize',[STATS.freqbins,STATS.timesout,STATS.nboot]);
        delete([tmpfname,'.map']);
        clear dat_avg
        
    end
    
end





