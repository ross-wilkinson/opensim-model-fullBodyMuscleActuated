function editSetupScaleXml(datDir,modDir,resDir,setDir,name,mass,ht,age,filename,startTime,endTime)
%EDITSETUPSCALEXML Summary of this function goes here
%   Author(s): Ross Wilkinson, Ph.D.
%
% Inputs:
% * datDir: directory containing marker file (.trc)
% * modDir: directory containing model file (.osim)
% * resDir: directory for saving scaling result files
% * setDir: directory for saving new setup file (.xml)
% * name: name for scaled model
% * mass: mass of subject
% * ht: height of subject
% * age: age of subject
% * filename: filename of marker file
% * startTime: start time of static trial
% * endTime: end time of static trial

% Load structure of generic scale file
load([modDir '/structureScale.mat'],'Tree')

% Edit ScaleTool -> subject info
Tree.ScaleTool.ATTRIBUTE.name = name;
Tree.ScaleTool.mass = mass;
Tree.ScaleTool.height = ht;
Tree.ScaleTool.age = age;

% Edit ScaleTool -> GenericModelMaker
Tree.ScaleTool.GenericModelMaker.ATTRIBUTE.name = name;

% Edit ScaleTool -> ModelScaler
Tree.ScaleTool.ModelScaler.ATTRIBUTE.name = name;
Tree.ScaleTool.ModelScaler.marker_file = [datDir '/' filename '.trc'];
Tree.ScaleTool.ModelScaler.time_range = [startTime endTime];

% ScaleTool -> MarkerPlacer
Tree.ScaleTool.MarkerPlacer.ATTRIBUTE.name = name;
Tree.ScaleTool.MarkerPlacer.marker_file = [datDir '/' filename '.trc'];
Tree.ScaleTool.MarkerPlacer.output_model_file = ...
    [resDir '/' name 'modelScaled.osim'];
Tree.ScaleTool.MarkerPlacer.output_motion_file = ...
    [resDir '/' filename '.mot'];
Tree.ScaleTool.MarkerPlacer.output_marker_file = ...
    [resDir '/' name 'markersScaled.xml'];
Tree.ScaleTool.MarkerPlacer.time_range = [startTime endTime];

% Set inputs for xml_write
rootName = 'OpenSimDocument';                                               
Pref.StructItem = false;

% Write .xml file
cd(setDir)
xml_write([name 'setupScale.xml'],Tree,rootName,Pref);                           

% Save structure
save([name 'structureScale.mat'],'Tree')

end

