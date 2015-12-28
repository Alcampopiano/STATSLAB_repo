function [properties]=propgridbuild(statslab_propgrid)


switch nargin
    case 0
        empt='';
        emptcell={''};
        
        properties = [ ...
            PropertyGridField('condnames', emptcell, ... % extract
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'condnames', ...
            'Description', propdoc('ExtractData','***condnames***','***end***')) ...
            PropertyGridField('condfiles_extract', empt, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('ExtractData','***condfiles***','***end***')) ...
            PropertyGridField('levels', 2, ...
            'Category', 'Extract Data', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'levels', ...
            'Description', propdoc('ExtractData','***levels***','***end***')) ...
            PropertyGridField('design', 'w', ...
            'Type', PropertyType('char', 'row', {'w','ww','b','bb', 'bw'}), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'design', ...
            'Description', propdoc('ExtractData','***design***','***end***')) ...
            PropertyGridField('savestring', empt, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'savestring', ...
            'Description', propdoc('ExtractData','***savestring***','***end***')) ...
            PropertyGridField('varargin_extract', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('ExtractData','***varargin***','***end***')) ...
            PropertyGridField('logical_extract', false, ...
            'Category', 'Extract Data', ...
            'DisplayName', 'Run ExtractData.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed.') ...
            PropertyGridField('condfiles_resample', empt, ... % resample
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Resample Data', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('ResampleData','***condfiles***','***end***')) ...
            PropertyGridField('nboot', 1000, ...
            'Category', 'Resample Data', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nboot', ...
            'Description', propdoc('ResampleData','***nboot***','***end***')) ...
            PropertyGridField('varargin_resample', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Resample Data', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('ResampleData','***varargin***','***end***')) ...
            PropertyGridField('logical_resample', false, ...
            'Category', 'Resample Data', ...
            'DisplayName', 'Run ResampleData.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('condfiles_group', empt, ... % group stat
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Group Statistics', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('GroupStatistics','***condfiles***','***end***')) ...
            PropertyGridField('alpha_group', 0.05, ...
            'Category', 'Group Statistics', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'alpha', ...
            'Description', propdoc('GroupStatistics','***alpha***','***end***')) ...
            PropertyGridField('nsamp', 1000, ...
            'Category', 'Group Statistics', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nsamp', ...
            'Description', propdoc('GroupStatistics','***nsamp***','***end***')) ...
            PropertyGridField('varargin_group', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Group Statistics', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('GroupStatistics','***varagin***','***end***')) ...
            PropertyGridField('logical_group', false, ...
            'Category', 'Group Statistics', ...
            'DisplayName', 'Run GroupStatistics.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('condfiles_subject', empt, ... % sub stat
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Subject Statistics', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('SubjectStatistics','***condfiles***','***end***')) ...
            PropertyGridField('alpha_subject', 0.05, ...
            'Category', 'Subject Statistics', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'alpha', ...
            'Description', propdoc('SubjectStatistics','***alpha***','***end***')) ...
            PropertyGridField('varargin_subject', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Subject Statistics', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('SubjectStatistics','***varargin***','***end***')) ...
            PropertyGridField('logical_subject', false, ...
            'Category', 'Subject Statistics', ...
            'DisplayName', 'Run SubjectStatistics.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('infodisplay_group', true, ... % group fig
            'Category', 'Group Figure', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('GroupFigure','***infodisplay***','***end***')) ...
            PropertyGridField('varargin_groupfig', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Group Figure', ...
            'DisplayName', 'varargin', ...
            'Description',propdoc('GroupFigure','***varargin***','***end***')) ...
            PropertyGridField('logical_groupfig', false, ...
            'Category', 'Group Figure', ...
            'DisplayName', 'Run GroupFigure.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('infodisplay_sub', true, ... % sub fig
            'Category', 'Subject Figure', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('SubjectFigure','***infodisplay***','***end***')) ...
            PropertyGridField('varargin_subjectfig', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Subject Figure', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('SubjectFigure','***varargin***','***end***')) ...
            PropertyGridField('logical_subjectfig', false, ...
            'Category', 'Subject Figure', ...
            'DisplayName', 'Run SubjectFigure.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('infodisplay_cor', true, ... % winbootcor
            'Category', 'Robust Correlations', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('WinBootCor','***infodisplay***','***end***')) ...
            PropertyGridField('nboot_cor', 1000, ...
            'Category', 'Robust Correlations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nboot', ...
            'Description', propdoc('WinBootCor','***nboot***','***end***')) ...
            PropertyGridField('tr', .2, ...
            'Category', 'Robust Correlations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'trim', ...
            'Description', propdoc('WinBootCor','***tr***','***end***')) ...
            PropertyGridField('Ylabel_cor', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Robust Correlations', ...
            'DisplayName', 'Ylabel', ...
            'Description', propdoc('WinBootCor','***Ylabel***','***end***')) ...
            PropertyGridField('varargin_cor', emptcell, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Robust Correlations', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('WinBootCor','***varargin***','***end***')) ...
            PropertyGridField('logical_cor', false, ...
            'Category', 'Robust Correlations', ...
            'DisplayName', 'Run WinBootCor.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed.') ...
            PropertyGridField('condition_label_rw', empt, ... % Linear & nonlinear visualizations wincorboot figure
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'condition/contrast label (X variable)', ...
            'Description', propdoc('WinBootCorFigure','***condition_label_rw***','***end***')) ...
            PropertyGridField('Ylabel_rw', empt, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Ylabel (Y variable)', ...
            'Description', propdoc('WinBootCorFigure','***Ylabel_rw***','***end***')) ...
            PropertyGridField('logical_rw', false, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Run WinBootCorFigure.m', ... 
            'Description', 'Check box to run WinBootCorFigure.m once OK is pressed.') ...
            PropertyGridField('infodisplay_slope', true, ... % slope
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('SlopeCI','***infodisplay***','***end***')) ...
            PropertyGridField('condition_label_slope', empt, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'condition/contrast label (X variable)', ...
            'Description', propdoc('SlopeCI','***Xlabel***','***end***')) ...
            PropertyGridField('Ylabel_slope', empt, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Ylabel (Y variable)', ...
            'Description', propdoc('SlopeCI','***Ylabel***','***end***')) ...
            PropertyGridField('msplot_slope', [], ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'msplot', ...
            'Description', propdoc('SlopeCI','***msplot***','***end***')) ...
            PropertyGridField('CI_color_slope', [.5 .5 .5], ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'CI_color', ...
            'Description', propdoc('SlopeCI','***CI_color***','***end***')) ...
            PropertyGridField('CI_limit_slope', [1 1 1], ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'CI_limit', ...
            'Description', propdoc('SlopeCI','***colorlimit***','***end***')) ...
            PropertyGridField('logical_slope', false, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Run SlopeCI.m', ...
            'Description', 'Check box to run SlopeCI.m once OK is pressed.') ...
            PropertyGridField('infodisplay_lowess', true, ... % LOWESS
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('LowessCI','***infodisplay***','***end***')) ...
            PropertyGridField('condition_label_lowess', empt, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'condition/contrast label (X variable)', ...
            'Description', propdoc('LowessCI','***Xlabel***','***end***')) ...
            PropertyGridField('Ylabel_lowess', empt, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Ylabel (Y variable)', ...
            'Description', propdoc('LowessCI','***Ylabel***','***end***')) ...
            PropertyGridField('msplot_lowess', [], ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'msplot', ...
            'Description', propdoc('LowessCI','***msplot***','***end***')) ...
            PropertyGridField('nboot_lowess', 1000, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nboot', ...
            'Description', propdoc('LowessCI','***nboot***','***end***')) ...
            PropertyGridField('span', .5, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'span', ...
            'Description', propdoc('LowessCI','***span***','***end***')) ...
            PropertyGridField('nbins', 1000, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nbins', ...
            'Description', propdoc('LowessCI','***nbins***','***end***')) ...
            PropertyGridField('logical_lowess', false, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Run LowessCI.m', ...
            'Description', 'Check box to run LowessCI.m once OK is pressed.') ...
            ];
        
        
    case 1
        
        
        
        properties = [ ...
            PropertyGridField('condnames', statslab_propgrid.condnames, ... % extract
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'condnames', ...
            'Description', propdoc('ExtractData','***condnames***','***end***')) ...
            PropertyGridField('condfiles_extract', statslab_propgrid.condfiles_extract, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('ExtractData','***condfiles***','***end***')) ...
            PropertyGridField('levels', statslab_propgrid.levels, ...
            'Category', 'Extract Data', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'levels', ...
            'Description', propdoc('ExtractData','***levels***','***end***')) ...
            PropertyGridField('design', statslab_propgrid.design, ...
            'Type', PropertyType('char', 'row', {'w','ww','b','bb', 'bw'}), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'design', ...
            'Description', propdoc('ExtractData','***design***','***end***')) ...
            PropertyGridField('savestring', statslab_propgrid.savestring, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'savestring', ...
            'Description', propdoc('ExtractData','***savestring***','***end***')) ...
            PropertyGridField('varargin_extract', statslab_propgrid.varargin_extract, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Extract Data', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('ExtractData','***varargin***','***end***')) ...
            PropertyGridField('logical_extract', false, ...
            'Category', 'Extract Data', ...
            'DisplayName', 'Run ExtractData.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed.') ...
            PropertyGridField('condfiles_resample', statslab_propgrid.condfiles_resample, ... % resample
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Resample Data', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('ResampleData','***condfiles***','***end***')) ...
            PropertyGridField('nboot', statslab_propgrid.nboot, ...
            'Category', 'Resample Data', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nboot', ...
            'Description', propdoc('ResampleData','***nboot***','***end***')) ...
            PropertyGridField('varargin_resample', statslab_propgrid.varargin_resample, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Resample Data', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('ResampleData','***varargin***','***end***')) ...
            PropertyGridField('logical_resample', false, ...
            'Category', 'Resample Data', ...
            'DisplayName', 'Run ResampleData.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('condfiles_group', statslab_propgrid.condfiles_group, ... % group stat
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Group Statistics', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('GroupStatistics','***condfiles***','***end***')) ...
            PropertyGridField('alpha_group', statslab_propgrid.alpha_group, ...
            'Category', 'Group Statistics', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'alpha', ...
            'Description', propdoc('GroupStatistics','***alpha***','***end***')) ...
            PropertyGridField('nsamp', statslab_propgrid.nsamp, ...
            'Category', 'Group Statistics', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nsamp', ...
            'Description', propdoc('GroupStatistics','***nsamp***','***end***')) ...
            PropertyGridField('varargin_group', statslab_propgrid.varargin_group, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Group Statistics', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('GroupStatistics','***varagin***','***end***')) ...
            PropertyGridField('logical_group', false, ...
            'Category', 'Group Statistics', ...
            'DisplayName', 'Run GroupStatistics.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('condfiles_subject', statslab_propgrid.condfiles_subject, ... % sub stat
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Subject Statistics', ...
            'DisplayName', 'condfiles', ...
            'Description', propdoc('SubjectStatistics','***condfiles***','***end***')) ...
            PropertyGridField('alpha_subject', statslab_propgrid.alpha_subject, ...
            'Category', 'Subject Statistics', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'alpha', ...
            'Description', propdoc('SubjectStatistics','***alpha***','***end***')) ...
            PropertyGridField('varargin_subject', statslab_propgrid.varargin_subject, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Subject Statistics', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('SubjectStatistics','***varargin***','***end***')) ...
            PropertyGridField('logical_subject', false, ...
            'Category', 'Subject Statistics', ...
            'DisplayName', 'Run SubjectStatistics.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('infodisplay_group', true, ... % group fig
            'Category', 'Group Figure', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('GroupFigure','***infodisplay***','***end***')) ...
            PropertyGridField('varargin_groupfig', statslab_propgrid.varargin_groupfig, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Group Figure', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('GroupFigure','***varargin***','***end***')) ...
            PropertyGridField('logical_groupfig', false, ...
            'Category', 'Group Figure', ...
            'DisplayName', 'Run GroupFigure.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('infodisplay_sub', true, ... % sub fig
            'Category', 'Subject Figure', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('SubjectFigure','***infodisplay***','***end***')) ...
            PropertyGridField('varargin_subjectfig', statslab_propgrid.varargin_subjectfig, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Subject Figure', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('SubjectFigure','***varargin***','***end***')) ...
            PropertyGridField('logical_subjectfig', false, ...
            'Category', 'Subject Figure', ...
            'DisplayName', 'Run SubjectFigure.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed. Will run after completion of subsequent module.') ...
            PropertyGridField('infodisplay_cor', true, ... % winbootcor
            'Category', 'Robust Correlations', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('WinBootCor','***infodisplay***','***end***')) ...
            PropertyGridField('nboot_cor', statslab_propgrid.nboot_cor, ...
            'Category', 'Robust Correlations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nboot', ...
            'Description', propdoc('WinBootCor','***nboot***','***end***')) ...
            PropertyGridField('tr', statslab_propgrid.tr, ...
            'Category', 'Robust Correlations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'trim', ...
            'Description', propdoc('WinBootCor','***tr***','***end***')) ...
            PropertyGridField('Ylabel_cor', statslab_propgrid.Ylabel_cor, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Robust Correlations', ...
            'DisplayName', 'Ylabel', ...
            'Description', propdoc('WinBootCor','***Ylabel***','***end***')) ...
            PropertyGridField('varargin_cor', statslab_propgrid.varargin_cor, ...
            'Type', PropertyType('cellstr', 'row'), ...
            'Category', 'Robust Correlations', ...
            'DisplayName', 'varargin', ...
            'Description', propdoc('WinBootCor','***varargin***','***end***')) ...
            PropertyGridField('logical_cor', false, ...
            'Category', 'Robust Correlations', ...
            'DisplayName', 'Run WinBootCor.m', ...
            'Description', 'Check box to run current STATSLAB module once OK is pressed.') ...
            PropertyGridField('condition_label_rw', statslab_propgrid.condition_label_rw, ... % Linear & nonlinear visualizations wincorboot figure
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'condition/contrast label (X variable)', ...
            'Description', propdoc('WinBootCorFigure','***condition_label_rw***','***end***')) ...
            PropertyGridField('Ylabel_rw', statslab_propgrid.Ylabel_rw, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Ylabel (Y variable)', ...
            'Description', propdoc('WinBootCorFigure','***Ylabel_rw***','***end***')) ...
            PropertyGridField('logical_rw', false, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Run WinBootCorFigure.m', ... % does not exist yet
            'Description', 'Check box to run WinBootCorFigure.m once OK is pressed.') ...
            PropertyGridField('infodisplay_slope', true, ... % slope
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('SlopeCI','***infodisplay***','***end***')) ...
            PropertyGridField('condition_label_slope', statslab_propgrid.condition_label_slope, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'condition/contrast label (X variable)', ...
            'Description', propdoc('SlopeCI','***Xlabel***','***end***')) ...
            PropertyGridField('Ylabel_slope', statslab_propgrid.Ylabel_slope, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Ylabel (Y variable)', ...
            'Description', propdoc('SlopeCI','***Ylabel***','***end***')) ...
            PropertyGridField('msplot_slope', statslab_propgrid.msplot_slope, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'msplot', ...
            'Description', propdoc('SlopeCI','***msplot***','***end***')) ...
            PropertyGridField('CI_color_slope', [.5 .5 .5], ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'CI_color', ...
            'Description', propdoc('SlopeCI','***CI_color***','***end***')) ...
            PropertyGridField('CI_limit_slope', [1 1 1], ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'CI_limit', ...
            'Description', ' The color that the CI will fade to as it increases in width.') ...
            PropertyGridField('logical_slope', false, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Run SlopeCI.m', ...
            'Description', 'Check box to run SlopeCI.m once OK is pressed.') ...
            PropertyGridField('infodisplay_lowess', true, ... % LOWESS
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'infodisplay', ...
            'Description', propdoc('LowessCI','***infodisplay***','***end***')) ...
            PropertyGridField('condition_label_lowess', statslab_propgrid.condition_label_lowess, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'condition/contrast label (X variable)', ...
            'Description', propdoc('LowessCI','***Xlabel***','***end***')) ...
            PropertyGridField('Ylabel_lowess', statslab_propgrid.Ylabel_lowess, ...
            'Type', PropertyType('char', 'row'), ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Ylabel (Y variable)', ...
            'Description', propdoc('LowessCI','***Ylabel***','***end***')) ...
            PropertyGridField('msplot_lowess', statslab_propgrid.msplot_lowess, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'msplot', ...
            'Description', propdoc('LowessCI','***msplot***','***end***')) ...
            PropertyGridField('nboot_lowess', statslab_propgrid.nboot_lowess, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nboot', ...
            'Description', propdoc('LowessCI','***nboot***','***end***')) ...
            PropertyGridField('span', statslab_propgrid.span, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'span', ...
            'Description', propdoc('LowessCI','***span***','***end***')) ...
            PropertyGridField('nbins', statslab_propgrid.nbins, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'Type', PropertyType('denserealdouble', 'matrix'), ...
            'DisplayName', 'nbins', ...
            'Description', propdoc('LowessCI','***nbins***','***end***')) ...
            PropertyGridField('logical_lowess', false, ...
            'Category', 'Linear & nonlinear visualizations', ...
            'DisplayName', 'Run LowessCI.m', ...
            'Description', 'Check box to run LowessCI.m once OK is pressed.') ...
            ];
        
end

































