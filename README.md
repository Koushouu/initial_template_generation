# Initial template generation

Initial template generation scripts. 

## What you need

* Particle coordinates files in *.cmm format, generated via volume tracer tool on Chimera. 
  * File name format: {cmm_prefix}{tomoID_number}.cmm. e.g. HIV_12.cmm
  * All cmm files should be in the same folder
* Tomogram files. 
  * File name format: {tomogram_prefix}{tomoID_number}.mrc. e.g. HIVtomo_12.mrc. 
  * All tomograms should be in the same folder

####Generate *.cmm files: Pick particles manually on Chimera GUI

1. Open Chimera, load the tomogram

2. Change the coordinates of the tomogram on the volume viewer tool:

   - Change the voxel size to 1: in dynamo coordinates data is in pixels

   - Change the origin index to 0

3. Open the volume tracer tool

   - Middle click on the spikes: look through the slices of tomogram on chimera. Click first on the top tip of the spike, then do the second click on the bottom tip of the spike. Then repeat. So in the end in the marker file you will have:

     - Coordinate 1: spike 1 head

     - Coordinate 2: spike 1 toe

     - Coordinate 3: spike 2 head

     - Coordinate 4: spike 2 toe

       ……

4. Save markers. Save as *.cmm file. Name the cmm file as the same name as the tomogram 

5. Repeat this for other tomograms. The general advice here is to only choose the particles that you are sure they are the sample of interest. Good particles will generate good structures.
