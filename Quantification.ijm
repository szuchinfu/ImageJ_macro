macro "MIP3stacks [F1]"{

 Dialog.create("Merge Channels");
 Dialog.addString("Bottom stack:", "16");
 Dialog.show();
 BottomStack = parseInt(Dialog.getString())
 TopStack =  BottomStack+3
 
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 //selectImage(id);
 //run("Slice Keeper", "first=BottomStack last=TopStack increment=1");
 selectImage(id);
 run("Z Project...", "start=BottomStack stop=TopStack projection=[Max Intensity]"); 

}

macro "GetSubstack [F2]"{

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
 //run("Z Project...", "projection=[Max Intensity]");
 //close();
}

macro "GetMIP [F3]"{
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 //run("Slice Keeper", "first=19 last=38 increment=1");
 run("Z Project...", "projection=[Max Intensity]");
 //close();
}

macro "GetROI [F4]"{
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
 
macro "EnlargeROI [F5]"{
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

macro "GetMIP [F6]"{
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 //run("Slice Keeper", "first=19 last=38 increment=1");
 run("Z Project...", "projection=[Min Intensity]");
 //close();
}


macro "GetMeanIP [F7]"{
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 selectImage(id);
 //run("Slice Keeper", "first=19 last=38 increment=1");
 run("Z Project...", "projection=[Average Intensity]");
 //close();
}

macro "AIP3stacks [F8]"{

 Dialog.create("Merge Channels");
 Dialog.addString("Bottom stack:", "16");
 Dialog.show();
 BottomStack = parseInt(Dialog.getString())
 TopStack =  BottomStack+3
 
 msg = "select image, then click \"OK\".";
 waitForUser("pick", msg);
 id=getImageID();
 //selectImage(id);
 //run("Slice Keeper", "first=BottomStack last=TopStack increment=1");
 selectImage(id);
 run("Z Project...", "start=BottomStack stop=TopStack projection=[Average Intensity]"); 

}


macro "Name ROI [F9]"{
	
 counts=roiManager("count");
 
 for(i=0; i<counts; i++) {

    roiManager("Select", i);
    name = "C"+i+1;
    roiManager("Rename", name);
         
 }


 roiManager("Select", counts-1);
 name = "B";
 roiManager("Rename", name);
         
}
