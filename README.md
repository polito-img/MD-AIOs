# Multi-Distortion Artificial Intelligence-based Observers (MD-AIOs)

This software includes the AI Observers models (trained Matlab NNs) presented in the paper   

**Multiple Image Distortion DNN Modeling Individual Subject Quality Assessment**   

by Lohic Fotio Tiotsop, Antonio Servetti, Marcus Barkowsky, Peter Pocta, Glenn Van Wallendael, Enrico Masala,  
to ACM Transactions on Multimedia Computing, Communications, and Applications, 2024

The software is provided free of charge, see [LICENSE.txt](./LICENSE.txt) file for further conditions. 
We kindly ask anyone using the software to cite the previous paper.

**NOTE**: Due to its large size (1.5+ GB), the full set of data files (.mat files) must be downloaded from [https://media.polito.it/MD-AIOs](https://media.polito.it/MD-AIOs)

## How to run the code 

May 2, 2024  

The present instructions are provided with the software in order to explain how to run it. 

Please note that to run the provided software, it is recommended  to have installed MATLAB R2019b or later Versions.

The folder contains: 

- 20 .mat files containing the weights and the architecture of the trained Deep Neural Networks (DNNs) i.e., the JPEGResNet50 and the 19 AIOs. 

- the MATLAB ```Simulate_AI_subjective_test.m``` that provides the software for simulating a subjective experiment with the AIOs. 

- the MATLAB script ```get_quality_MDResNet50.m``` that provides the software for computing the Visual quality of an images impaired by Gaussian Noise, Gaussian blur, JPEG and JPG2000 compression artefacts using the MDResNet50.

- a folder called ```Test_folder``` containing few images on which the software can be tested.
  
To run ```Simulate_AI_subjective_test.m``` or ```get_quality_MDResNet50.m``` on a set of images, first prepare a folder containing the Images whose quality should be evaluated, then insert it in the folder that contains the 19 DNNs modeling the AIOs, the MDResNet50, ```Simulate_AI_subjective_test.m``` and ```get_quality_MDResNet50.m```. Open the script Simulate_AI_subjective_test.m or get_quality_MDResNet50.m depending on what you want to do, update the variable named "imgfolder" by inserting the name of the folder containing the images whose quality should be evaluated, then simply run the script.

In case of ```get_quality_MDResNet50.m```, a csv file named ```MDResNet50_MOS.csv``` reporting the estimation of the MOS of each image will be generated and saved in the folder that contains the scripts. 

In case of Simulate_AI_subjective_test.m, 21 csv files are generated in the folder that contains the scripts: The file ```MOS_AI.csv``` that reports the MOS computed from the AIOs opinion scores; the file ```AI_opinin_scores.csv``` containing the AIOs opinion Scores; and 19 other files, one for each AIOs, reporting the probability of choosing each of the five possible opinion scores i.e., "Bad", "Poor", "Fair", "Good" and "Excellent" for every evaluated image.

Please send an email to ```lohic.fotiotiotsop@polito.it``` for any further questions.
