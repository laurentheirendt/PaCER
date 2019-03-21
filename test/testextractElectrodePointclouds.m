% The PaCER Toolbox: testExtractElectrodePointclouds.m
%
% Purpose:
%     - test the extractElectrodePointclouds function
%
% Author:
%     - Loic Marx, March 2019

global refDataPath
global inputDataPath

% save the current path
currentDir = pwd;

% initialize the test
fileDir = fileparts(which(mfilename));
cd(fileDir);

% load reference data
refData = load ([getenv('PACER_DATA_PATH') filesep 'ref' filesep 'refData_extractElectrodePC.mat'])

% generate new data
niiCT_new = NiftiMod([getenv('PACER_DATA_PATH') filesep 'input' filesep 'ct_post.nii.gz'])
[elecsPointcloudStruct_new, brainMask_new] = extractElectrodePointclouds(niiCT_new);

% compare the new data against the reference data 
assert(isequal(elecsPointcloudStruct_new, refData.elecsPointcloudStruct_ref))
assert(isequal(brainMask_new, refData.brainMask_ref))

% apply post CT brain mask
refData_brainMask = load ([getenv('PACER_DATA_PATH') filesep 'ref' filesep 'refData_extractElectrodePC_withBrainMask.mat'])
niiCT_brainMask_new = NiftiMod([getenv('PACER_DATA_PATH') filesep 'input' filesep 'ct_post.nii.gz'])
brainMaskPath = [getenv('PACER_DATA_PATH') filesep 'input' filesep 'ct_post_mask.nii']
[elecsPointcloudStruct_brainMask_new, brainMask_brainMask_new] = extractElectrodePointclouds(niiCT_brainMask_new, 'brainMask', brainMaskPath);

% compare the new data against the reference data using a BrainMask
assert(isequal(elecsPointcloudStruct_brainMask_new, refData_brainMask.elecsPointcloudStruct_brainMask_ref))
assert(isequal(brainMask_brainMask_new, refData_brainMask.brainMask_brainMask_ref))

