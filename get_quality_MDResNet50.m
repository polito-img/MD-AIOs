
imgfolder='Test_folder'; % insert the name of the folder containing the images.

% loading the Network
m=load('MDResNet50.mat');
net=m.trainedNet;

% read and Resizing the images to match the model input layer size
inputSize=net.Layers(1).InputSize;
image_ds = imageDatastore(imgfolder);
Resized_image_ds = augmentedImageDatastore(inputSize(1:2),image_ds);


% predict the choice probability 
fprintf('estimating the images visual quality.....\n')
pred=predict(net,Resized_image_ds);


 % fix the fact that the classes are ordered as 
 %"Bad", "Excellent", "Fair", "Good" and finally "Poor"
pred=(pred(:,[1 5 3 4 2]));

% compute predicted MOS
quality=pred*[1 2 3 4 5]';

%% writing the output on csv files 
Image_name=extractAfter(image_ds.Files,strcat(image_ds.Folders{1},'/'));
T=table(Image_name,quality);
writetable(T,'MDResNet50_MOS.csv');

fprintf('All done!!!.....\n')

