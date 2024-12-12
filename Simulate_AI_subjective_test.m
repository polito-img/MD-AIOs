
imgfolder='Test_folder'; % insert the name of the folder containing the images.


% inserting the image in an imageDatastore
image_ds = imageDatastore(imgfolder);

% Resizing the images to match the model input layer size
inputSize = [ 224   224     3 ];
Resized_image_ds= augmentedImageDatastore(inputSize(1:2),image_ds);

% Simulating the subjective experiment
fprintf('Compiuting the AIOs opinion scores.....\n')
[MOS_AI,Opinion_score_AI,Choice_probabilities_AI]=get_predictions_from_AOIs(Resized_image_ds);

%% writing the output on csv files 
Image_name=extractAfter(image_ds.Files,strcat(image_ds.Folders{1},'/'));
T=table(Image_name,MOS_AI);
writetable(T,'MOS_AI.csv');

T=array2table(Opinion_score_AI);
T.Properties.VariableNames={'OS_1','OS_2','OS_3','OS_4','OS_5','OS_6','OS_7','OS_8','OS_9','OS_10','OS_11','OS_12','OS_13','OS_14','OS_15','OS_16','OS_17','OS_18','OS_19'};
T = addvars(T,Image_name,'Before','OS_1');
writetable(T,'AI_opinin_scores.csv');
T

for i=1:19
    T=array2table(Choice_probabilities_AI(:,:,i));
    T.Properties.VariableNames={'p_Bad','p_Poor','p_Fair','p_Good','p_Excellent'};
    T = addvars(T,Image_name,'Before','p_Bad');
    file_name=strcat('Choice_probabilities_AIO_',num2str(i),'.csv');
    writetable(T,file_name);
end

fprintf('All done!!!.....\n')
T

%%

function [MOS_AI,Opinions_AI,probability_AI]=get_predictions_from_AOIs(Resized_image_ds)

% the  function receives an image or a set of images  an image imageDatastore
% as input and computes the mean of AIOs' opinions, their individual
% opinions and finally the probability that each AIO will choose any of the
% five possibile opinions on the ACR scale. 

         for i=1:19
            file_name=strcat('AIO_',num2str(i),'.mat');
            N=load(file_name);
            netTransfer=N.TrainedNet;
            [YPred,probability_AI(:,:,i)] = classify(netTransfer,Resized_image_ds); 
            
            % fix the fact that the classes are ordered as 
            %"Bad", "Excellent", "Fair", "Good" and finally "Poor"
            
            probability_AI(:,:,i)=probability_AI(:,[1 5 3 4 2],i);
            pred=get_numeric_labels(YPred);
            Opinions_AI(:,i)=pred;
            
         end 
       MOS_AI=mean(Opinions_AI,2);
end


function opinion=get_numeric_labels(Y)
         opinion=zeros(length(Y),1);
         for i=1:length(Y)
             
             if Y(i)=='Bad'
                opinion(i)=1;
             end
             
             if Y(i)=='Poor'
                opinion(i)=2;
             end
             
             if Y(i)=='Fair'
                opinion(i)=3;
             end
             
             if Y(i)=='Good'
                opinion(i)=4;
             end
             
             if Y(i)=='Excellent'
                opinion(i)=5;
             end
             
         end
end