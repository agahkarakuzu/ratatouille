classdef  ratAtlasStat < handle 
    
    
    
    
    
    properties 
        
        SourceDir
        TargetDir 
        
    end
    
    
    
    
    methods (Access = public)
        
        function obj = ratAtlasStat()
        
            
        end
        
        
        function setSourceDir()
            
            obj.sourceDir  = uigetdir();

        end
        
        function getFileList()
            if not(isempty(obj.SourceDir))
            obj.FileList = dir(fullfile(obj.SourceDir, '*.xxx'));
            else
            error('Source directory is empty');
            end
        
        end
        
        
        
        
        
        
    end
    
    
    
    
    
    
    
    
    
end