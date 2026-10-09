//  Input image directory
basePath = "/path/to/input/";

// Output directory for results
saveBasePath = "/path/to/output/";

for (n = 1; n <= 12; n++) {
if (n < 10) {
    fileNum = "0" + n;
} else {
    fileNum = "" + n;
}
    fileName = "sample_" + fileNum + ".ome.tif";
    fullPath = basePath + fileName;

    open(fullPath);
    selectImage(fileName);

// Clear Results and ROI Manager and set the threshold
    run("Clear Results");
    roiManager("Reset");

    run("8-bit");
    getStatistics(area, mean, min, max, std, histogram);

    totalPixels = 0;
    sumHist = 0;
    targetPercentile = 0.9 * getWidth() * getHeight();

    for (i = 0; i < 256; i++) {
        sumHist += histogram[i];
        if (sumHist >= targetPercentile) {
            percentile90 = i;
            break;
        }
    }

    setAutoThreshold("Default");
    setThreshold(percentile90, 255);

// Extract ROIs and measure
    run("Analyze Particles...", "size=1-Infinity show=Nothing add");

    roiCount = roiManager("count");

    if (roiCount > 0) {
        for (r = 0; r < roiCount; r++) {
            roiManager("Select", r);
            run("Measure");
        }

// Save the result
        savePath = saveBasePath + "sample_" + fileNum + "_results.csv";
        saveAs("Results", savePath);
        print("CSV saved to: " + savePath);
    } else {
        print("No ROI in the ROI Manager for file: " + fileName);
    }
    close();
}
