// Background subtraction

File.openSequence("path/to/input/");
run("Subtract Background...", "rolling=10 stack");
//run("Brightness/Contrast...");
setMinAndMax(0, 1500);
run("Image Sequence... ", "select=path/to/output/ dir=path/to/output/RB_file/ format=TIFF");
close;

// Particle analysis

File.openSequence("path/to/input/RB_file/");
setAutoThreshold("Default dark");
//run("Threshold...");
setThreshold(75, 65535, "raw");
run("Set Measurements...", "area centroid limit redirect=None decimal=3");
run("Analyze Particles...", "size=5-Infinity display clear stack");
saveAs("Results", "path/to/output/Results_file.csv");
close();