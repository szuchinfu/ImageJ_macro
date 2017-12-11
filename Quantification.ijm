macro "MIP_4slices [F1]"{
 Dialog.create("Merge Channels");
 Dialog.addString("Bottom stack:", "16");
 Dialog.show();
 BottomStack = parseInt(Dialog.getString())
 TopStack =  BottomStack+3
 // 
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
 //
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 run("Z Project...", "start=BottomStack stop=TopStack projection=[Average Intensity]"); 
}

macro "Get_slices [F3]"{

 Dialog.create("Merge Channels");
 Dialog.addString("Bottom stack:", "16");
 Dialog.addString("Top stack:", "32");
 Dialog.show();
 BottomStack = Dialog.getString();
 TopStack = Dialog.getString();
 
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 run("Slice Keeper", "first=BottomStack last=TopStack increment=1");
 close();
}

macro "Get_MIP [F4]"{
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 run("Z Project...", "projection=[Max Intensity]");
 close();
}

macro "Get_ROI [F5]"{
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 run("ROI Manager...");
 run("Gaussian Blur...", "sigma=3");
 setAutoThreshold("Default dark");
 //run("Threshold..."); 
 setAutoThreshold("Default dark");
 setOption("BlackBackground", false);
 run("Convert to Mask");
 run("Watershed");
 //run("Analyze Particles...", "size=30-Infinity circularity=0-1.00 show=Outlines display exclude clear summarize record add");
 run("Analyze Particles...", "size=30-Infinity circularity=0-1.00 show=Outlines exclude clear record add");
 roiManager("Show All with labels");
 roiManager("Show All");
 close();
}
 
macro "EnlargeROI [F6]"{
 run("Set Scale...", "distance=4.935834155972359 known=1 pixel=1 unit=micorn global");
 counts=roiManager("count");
 for(i=0; i<counts; i++) {

    roiManager("Select", i);
    run("Enlarge...", "enlarge=0.47");
    //run("Enlarge...", "enlarge=0.05");
    roiManager("Add");
    roiManager("Select", i);
    run("Enlarge...", "enlarge=0.62");
    //run("Enlarge...", "enlarge=0.07");
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

 //roiManager("Deselect");
 //roiManager("Measure");
}


