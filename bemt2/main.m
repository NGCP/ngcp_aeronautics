clear all
close all

%% Run parameters
globalconfig.file_import = true;
%File import params
importconfig.inputDir            = 'InputFiles\prop_geom';
importconfig.inertia_header      = '       ----- INERTIA AND AREA DATA -----';
importconfig.airfoil_header      = '       ----- AIRFOIL SECTIONS -----';
importconfig.geom_header         = '      STATION     CHORD       PITCH       PITCH        PITCH       SWEEP    THICKNESS      TWIST      MAX-THICK  CROSS-SECTION ZHIGH       CGY          CGZ                        ';
importconfig.struct_field_string = 'R C P1 P2 P3 SWEEP TH TWIST MTH CSECTION ZHIGH CGY CGZ';

%% Import data
if globalconfig.file_import
    prop = import_props_from_directory(importconfig);
    %import airfoil data
else
    %load matlab structure, should contain airfoil and prop data
end

%% Do bemt stuff