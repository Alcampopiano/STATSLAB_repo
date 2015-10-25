function [chanchoices]=chanpick_topo(condfiles_subs,pathtofiles,numconds)

% grid size
tabsize=max(cell2mat(cellfun(@length,condfiles_subs,'un',0)));

chanchoices=cell(tabsize,numconds*2);
j=1;
for i=1:numconds;
    [rowfname colfname]=size(condfiles_subs{i});
    for q=1:rowfname
        chanchoices{q,j}=condfiles_subs{i}{q};
        chanchoices{q,j+1}='';
    end
    j=j+2;
end

%create a figure to house the GUI
f = figure('units','normalized','position',[.25 .25 .5 .65]);

% initialize linked data
data.chanarray=chanchoices;
data.condind=1;
data.subind=1;
data.button='edit'; % just a place holder
guidata(gcf,data);

%create objects
uiob=uicontrol('style','edit',...
    'units', 'normalized',...
    'position', [0.45 0.01 0.1 0.05],...
    'callback', {@editfunc});

uiob = uicontrol('style', 'pushbutton',...
    'string', 'Back',...
    'units', 'normalized',...
    'position', [0.01 0.01 0.1 0.05],...
    'callback', {@backfunc});

uiob = uicontrol('style', 'pushbutton',...
    'string', 'Next',...
    'units', 'normalized',...
    'position', [0.11 0.01 0.1 0.05],...
    'callback', {@nextfunc});

uiob = uicontrol('style', 'pushbutton',...
    'string', 'Apply to all',...
    'units', 'normalized',...
    'position', [0.21 0.01 0.1 0.05],...
    'callback', {@applyfunc});

uiob = uicontrol('style', 'pushbutton',...
    'string', 'Cancel',...
    'units', 'normalized',...
    'position', [0.89 0.01 0.1 0.05],...
    'callback', {@cancelfunc});

uiob = uicontrol('style', 'pushbutton',...
    'string', 'OK',...
    'units', 'normalized',...
    'position', [0.79 0.01 0.1 0.05],...
    'callback', {@okayfunc});

uiob = uicontrol('style', 'pushbutton',...
    'string', 'Load',...
    'units', 'normalized',...
    'position', [0.01 0.94 0.1 0.05],...
    'callback', {@loadfunc});


uiob = uicontrol('style', 'pushbutton',...
    'string', 'Save',...
    'units', 'normalized',...
    'position', [0.89 0.94 0.1 0.05],...
    'callback', {@savefunc});



sel=true;
while sel
    
    % invoke data link
    data=guidata(gcf);
    
    % don't reload unless scrolling through
    if strcmp(data.button, 'next') || strcmp(data.button, 'back') || strcmp(data.button, 'edit')
        
        % get string of current subject
        cursub=condfiles_subs{data.condind}{data.subind};
        tmpEEG = pop_loadset('filename',cursub,'filepath',pathtofiles{data.condind});
        tmpEEG = eeg_checkset(tmpEEG);
    end
    
    % call topoplot for 2D locations
    statslab_topoplot([],tmpEEG.chanlocs, 'style', 'blank', 'drawaxis', 'on', 'electrodes', ...
        'labelpoint', 'plotrad', [], 'chaninfo', tmpEEG, 'nosedir' ,'+Y');
    
    % color the previous selections
    for q=1:length(data.chanarray{data.subind,data.condind*2});
        ho=findobj(gcf,'String',data.chanarray{data.subind,data.condind*2}{q});
        set(ho, 'Color', 'green', 'FontSize',13, 'FontWeight','bold');
    end
    
    disp(['working on channel selections for file: ' cursub]);
    
    % waitfor callback
    uiwait;
    
    % gather data linked to the figure
    data=guidata(gcf);
    
    % determine which button was pressed
    if strcmp(data.button, 'next')
        
        if data.subind<length(condfiles_subs{data.condind})
            data.subind=data.subind+1;
        elseif data.subind==length(condfiles_subs{data.condind})
            if data.condind<numconds
                data.condind=data.condind+1;
                data.subind=1;
            end
        end
        
    elseif strcmp(data.button, 'back')
        
        if data.subind>1;
            data.subind=data.subind-1;
        elseif data.subind==1;

            if data.condind>1
                data.subind=length(condfiles_subs{data.condind-1});
                data.condind=data.condind-1;
            end  
        end
        
    elseif strcmp(data.button, 'load')
        disp(['loading and still on' ,cursub]);
        
    elseif strcmp(data.button, 'save') 
        disp(['saving and still on' ,cursub]);
        
    elseif strcmp(data.button, 'apply') 
        disp(['applied and still on' ,cursub]);
        
    elseif strcmp(data.button, 'edit') 
        disp(['moving to' ,num2str(data.condind) num2str(data.subind)]);

    elseif strcmp(data.button, 'okay')
        
        % set main output and exit
        chanchoices=data.chanarray;
        close(f);
        return

    elseif strcmp(data.button, 'cancel')
        
        % empty main output
        chanchoices=[];
        close(f);
        return
    end
    
    disp([num2str(data.condind) num2str(data.subind)]);
    
    % overwrite linked data
    guidata(gcf,data);

    % remove topoplot objects
    delete(gca);
    delete(gca);
end



%Slider object to control ellipse size
% uicontrol('style','Slider',...
%             'Min',0.5,'Max',2,'Value',1,...
%             'units','normalized',...
%             'position',[0.1    0.2    0.08    0.25],...
%             'callback',{@change_size,ellipse_h,ellipse_position });
%
% uicontrol('Style','text',...
%             'units','normalized',...
%             'position',[0    0.45    0.2    0.1],...
%             'String','Ellipse Size')

end



%%
function savefunc(object_handle,event)

% update latest state of GUI
h=findobj(gcf,'Color','g');
labs=get(h,'String');
if ~iscell(labs)
    labs={labs};
end

% invoke data link
data=guidata(gcf);

% set chanarray to current state when callback was executed
data.chanarray{data.subind,data.condind*2}=labs;

[ParamName, ParamPath]=uiputfile('*.*','channel selection file');
save(fullfile(ParamPath, ParamName),'data');

data.button='save';
guidata(gcf,data);
uiresume(gcbf)
end

%%
function loadfunc(object_handle,event)

[ParamName ParamPath]=uigetfile('*.mat','choose channel selection file:','*.mat','multiselect','off');
tmp=load(fullfile(ParamPath, ParamName), '-mat');
field=fieldnames(tmp);
chanarray=tmp.(field{1}).chanarray;

% invoke data link to maintain current sub/cond indices
data=guidata(gcf);

% set only chanarray field to loaded state
data.chanarray=chanarray;
data.button='load';
guidata(gcf,data);
uiresume(gcbf)
end

%%
function okayfunc(object_handle,event)

h=findobj(gcf,'Color','g');
labs=get(h,'String');
if ~iscell(labs)
    labs={labs};
end

% invoke data link
data=guidata(gcf);

% set chanarray to current state when callback was executed
data.chanarray{data.subind,data.condind*2}=labs;

data.button='okay';
guidata(gcf,data);
uiresume(gcbf)
end

%%
function cancelfunc(object_handle,event)

% invoke data link
data=guidata(gcf);
data.button='cancel';
guidata(gcf,data);
uiresume(gcbf)
end

%%
function nextfunc(object_handle,event)

h=findobj(gcf,'Color','g');
labs=get(h,'String');
if ~iscell(labs) && ~isempty(labs)
    labs={labs};
end

% invoke data link
data=guidata(gcf);

% set chanarray to current state when callback was executed
data.chanarray{data.subind,data.condind*2}=labs;

data.button='next';
guidata(gcf,data);
uiresume(gcbf)
end

%%
function backfunc(object_handle,event)

% handles and labels to green objects
h=findobj(gcf,'Color','g');
labs=get(h,'String');
if ~iscell(labs) && ~isempty(labs)
    labs={labs};
end

% invoke data link
data=guidata(gcf);

% set chanarray to current state when callback was executed
data.chanarray{data.subind,data.condind*2}=labs;

data.button='back';
guidata(gcf,data);
uiresume(gcbf)
end

%%
function applyfunc(object_handle,event)

% handles and labels to green objects
h=findobj(gcf,'Color','g');
labs=get(h,'String');
if ~iscell(labs) && ~isempty(labs)
    labs={labs};
end

% invoke data link
data=guidata(gcf);

% copy all current info into chanarray

% every other col, which hold the subject filenames
for j=1:2:size(data.chanarray,2);
    
    % numsubs + padded cells
    rowdat=length(data.chanarray(:,j));
    
    for i=1:rowdat;
        
        % if not padded
        if ~isempty(data.chanarray{i,j});
            data.chanarray{i,j+1}=labs;
            
        else % break if you hit the padded cells
            break
        end
    end
    
end

data.button='apply';
guidata(gcf,data);
uiresume(gcbf)
end

%%
function editfunc(object_handle,event)

% handles and labels to green objects
h=findobj(gcf,'Color','g');
labs=get(h,'String');
if ~iscell(labs) && ~isempty(labs)
    labs={labs};
end

% invoke data link
data=guidata(gcf);

% set chanarray to current state when callback was executed
data.chanarray{data.subind,data.condind*2}=labs;

% gather edit box entry and set new inds in data struct
newinds = str2double(get(object_handle, 'string'));

% clear box
set(object_handle, 'string', '')

if ~isempty(newinds);
    data.subind=newinds(2);
    data.condind=newinds(1);
    data.button='edit';
    
else
    data.button='stay';  
end

guidata(gcf,data);
uiresume(gcbf)
end
