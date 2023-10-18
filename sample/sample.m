

opts = tiff2mp4Options();

% Dir with images
[currDir] = fileparts(mfilename("fullpath"));
opts.inputPath = fullfile(currDir,'tiffs');
% Image name with * as wildcard
opts.inputFileName = '%06d.tif';

% Dir for output 
opts.outputPath = currDir;
% Output file name, with extension
opts.outputFileName = 'output.mp4';

% Compression factor, see tiff2mp4Options for more detail
opts.crf=0;

% Framerate
opts.framerateInput = 10;

% Auto overwrite existing video file
opts.overwrite = true;

% Convert.
tiff2mp4(opts)

% If ffmpeg, the program that creates the videos from images, is on your
% system path, use the following command instead
% tiff2mp4(opts, 'path2ffmpeg');