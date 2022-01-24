// To make this script run in Fiji, please activate 
// the clij and clij2 update sites in your Fiji 
// installation. Read more: https://clij.github.io

// Generator version: 2.5.1.4
// MWE to replicate the errors detailed in
// https://forum.image.sc/t/problems-with-clij-assistant-on-medium-size-images/  

// The error can be replicated creating a white image:
//1GB 8-bit | newImage("test", "8-bit white", 1500, 1500, 512); works
//3GB 8-bit | newImage("test", "8-bit white", 2500, 2500, 512); don't work
//4GB 32-bit| newImage("test", "32-bit white", 1450, 1450, 512); works

newImage("test", "8-bit white", 1500, 1500, 512);

// Init GPU
run("CLIJ2 Macro Extensions", "cl_device=");

Ext.CLIJ2_startTimeTracing();

// Load image
image_1 = getTitle();
Ext.CLIJ2_pushCurrentZStack(image_1);

// Copy
Ext.CLIJ2_copy(image_1, image_2);
Ext.CLIJ2_release(image_1);

Ext.CLIJ2_pull(image_2);

// Gaussian Blur3D
sigma_x = 2.0;
sigma_y = 2.0;
sigma_z = 2.0;
Ext.CLIJ2_gaussianBlur3D(image_2, image_3, sigma_x, sigma_y, sigma_z);
Ext.CLIJ2_release(image_2);

Ext.CLIJ2_pull(image_3);

// Binary Fill Holes
Ext.CLIJ2_binaryFillHoles(image_3, image_4);
Ext.CLIJ2_release(image_3);

Ext.CLIJ2_pull(image_4);
Ext.CLIJ2_release(image_4);

// print memory usage
Ext.CLIJ2_stopTimeTracing();
Ext.CLIJ2_getTimeTracing(time_traces);
print(time_traces);

Ext.CLIJ2_reportMemory();