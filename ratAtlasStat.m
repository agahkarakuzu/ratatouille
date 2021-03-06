classdef  ratAtlasStat < handle 
    
    
    
    
    
    properties 
        
        SourceDir
        TargetDir 
        FileList 
        NumberofSamples 
        NumberofLevels 
        Names
        Sample
        Level
        Rat 
        
        
    end
    
    
    
    
    methods (Access = public)
        
        function obj = ratAtlasStat()
        
            
        end
        
        
        function obj = setSourceDir(obj)
            
            obj.SourceDir  = uigetdir();

        end
        
        function obj = getFileList(obj)
            if not(isempty(obj.SourceDir))
            obj.FileList = dir(fullfile(obj.SourceDir, '*.mat'));
            else
            error('Source directory is empty');
            end
        
        end
        
        
        
        
        function obj = inspectData(obj)
           
            obj.getFileList;
            obj.Sample = cell(length(obj.FileList),1);
            obj.Level = cell(length(obj.FileList),1);
            
            for ii = 1:length(obj.FileList)
            
            curname = obj.FileList(ii).name;
            loc = strfind(curname,'_');
            locp = strfind(curname,'.');
            obj.Sample{ii} = curname(loc(2)+1:loc(3)-1);
            obj.Level{ii} = curname(loc(3)+1:locp-1);
            
            end
            
            obj.Sample = unique(obj.Sample);
            obj.Level = unique(obj.Level);
            obj.NumberofSamples = length(obj.Sample);
            obj.NumberofLevels = length(obj.Level);
            
        end
        
        function obj = parseData(obj)
            
            obj.inspectData;
            obj.Rat = struct('AD',[],'AED',[],'AVF',[],'GR',[],'MT',[],'MVF',[]);
            
            
            for ii = 1:obj.NumberofSamples
               
                
                dat = ratAtlasStat.loadData(obj,obj.Sample{ii});
                
                obj.Rat(ii).AD = squeeze(dat(1,:,:));
                obj.Rat(ii).AED = squeeze(dat(2,:,:));
                obj.Rat(ii).AVF = squeeze(dat(3,:,:));
                obj.Rat(ii).GR = squeeze(dat(4,:,:));
                obj.Rat(ii).MT = squeeze(dat(5,:,:));
                obj.Rat(ii).MVF = squeeze(dat(6,:,:));
              
                
            end
            
            
        end
        
        
        
        
    end
    
    
    methods (Static) 
        
        function dat = loadData(obj,sampleName)
           
            dat = zeros(6,16,obj.NumberofLevels);
            for ii = 1:obj.NumberofLevels
            
               tmp  = [obj.SourceDir filesep 'tract_averages_' sampleName '_' obj.Level{ii} '.mat'];
               nm = load(tmp);
               nms = fieldnames(nm);
               dato = nm.(nms{1}); 
               dato = table2array(dato);
               dat(:,:,ii) = dato;
               
            end
            
        end
        
    end
    
    
    
    
    
    
end