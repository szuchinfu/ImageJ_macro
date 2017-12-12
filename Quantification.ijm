macro "MIP_4slices [F1]"{
 Dialog.create("Merge Channels");
 Dialog.addString("Bottom stack:", "16");
 Dialog.show();
 BottomStack = parseInt(Dialog.getString())
 TopStack =  BottomStack+3
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 run("Z Project...", "start=BottomStack stop=TopStack projection=[Max Intensity]"); 
}

macro "AIP_4slices [F2]"{
 Dialog.create("Merge Channels");
 Dialog.addString("Bottom stack:", "16");
 Dialog.show();
 BottomStack = parseInt(Dialog.getString())
 TopStack =  BottomStack+3
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 run("Z Project...", "start=BottomStack stop=TopStack projection=[Average Intensity]"); 
}

macro "Get_ROI [F3]"{
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 run("Duplicate...", "title=[duplicate.TIF]");
 run("ROI Manager...");
 run("Gaussian Blur...", "sigma=3");
 setAutoThreshold("Default dark");

 setAutoThreshold("Default dark");
 setOption("BlackBackground", false);
 run("Convert to Mask");
 run("Watershed");
 run("Analyze Particles...", "size=30-Infinity circularity=0-1.00 show=Outlines exclude clear record add");
 selectWindow("duplicate.TIF");
 close();
 selectWindow("Drawing of duplicate.TIF");
 close();
 selectImage(id);
 roiManager("Show All with labels");
 roiManager("Show All");
}
 
macro "EnlargeROI [F4]"{
 run("Set Scale...", "distance=4.935834155972359 known=1 pixel=1 unit=micorn global");
 counts=roiManager("count");
 for(i=0; i<counts; i++) {
    roiManager("Select", i);
    run("Enlarge...", "enlarge=0.47");
    roiManager("Add");
    roiManager("Select", i);
    run("Enlarge...", "enlarge=0.62");
    roiManager("Add");

    inner=i+counts;
    outter=inner+1;

    roiManager("Select", newArray(inner,outter));
    roiManager("XOR");
    roiManager("Add");

    roiManager("Select", newArray(inner,outter));
    roiManager("Delete");

    roiManager("Select", i);
    name = "N"+i+1;
    roiManager("Rename", name);

    ROI_jump=i+counts;

    roiManager("Select", ROI_jump);
    name = "C"+i+1;
    roiManager("Rename", name);
 }
}
