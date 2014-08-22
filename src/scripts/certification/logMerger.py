#!/usr/bin/python
import os.path
import glob
import pprint
filesToOpen = (glob.glob("*/stress_out.log"))
print "Merging"
pprint.pprint(filesToOpen)
firstFile = True
fieldslen = 0
with open("mergedOutput.csv","w") as output:
    for file in filesToOpen:
        dir = os.path.dirname(file)
        cluster_size = dir.split("_")[0]
        test_name = "".join(dir.split("_")[1:])
        stress_size = int(cluster_size)/3
        lineNum = 0
        firstLine = True
        with open(file,"r") as input:
            for line in input:
                vals = line.rstrip().split(",")
                keepers = vals [int(stress_size):]
                if firstLine:
                    firstLine = False
                    if not firstFile:
                        continue
                    elif  firstFile:
                        output.write(",".join(keepers)+",Test,Cluster_Size,Time\n")
                        continue
                output.write(",".join(keepers)+","+test_name+","+cluster_size+","+str(lineNum)+"\n")
                lineNum+=1
            firstFile = False
