% Load the data
filename = 'traffic.csv';
dataTable = readtable(filename);

% Convert DateTime to a numeric format
dataTable.DateTime = posixtime(datetime(dataTable.DateTime));

% Split the data into input (DateTime and Junction) and output (Vehicles)
input = [dataTable.DateTime, dataTable.Junction];
output = dataTable.Vehicles;

% Normalize the input data
input = normalize(input);

% Split the data into training (80%) and validation (20%) sets
splitIndex = floor(0.8 * size(input, 1));
inputTrain = input(1:splitIndex, :);
outputTrain = output(1:splitIndex, :);
inputValidation = input(splitIndex+1:end, :);
outputValidation = output(splitIndex+1:end, :);
% Define the layers
inputSize = size(inputTrain, 2);
hiddenLayerSize = 50;
layers = [
    featureInputLayer(inputSize)
    fullyConnectedLayer(hiddenLayerSize)
    reluLayer
    fullyConnectedLayer(1)
    regressionLayer];

% Define the training options
options = trainingOptions('adam', ...
    'MaxEpochs', 100, ...
    'InitialLearnRate', 0.001, ...
    'ValidationData', {inputValidation, outputValidation}, ...
    'ValidationFrequency', 30, ...
    'Verbose', false, ...
    'Plots', 'training-progress');
% Train the network 2017-07-01 08:00:00
net = trainNetwork(inputTrain, outputTrain, layers, options);
% Example data
Date = '2017-07-01 08:00:00';
DateTimeValue = posixtime(datetime(Date));
JunctionValue = 2;

% Test on new data
newData = [DateTimeValue, JunctionValue];
newData = normalize(newData);
predictedVehicles = predict(net, newData);

% Display the results
disp(['Predicted number of vehicles: ', num2str(predictedVehicles), ' at junction ', num2str(JunctionValue), ': ', Date]);
