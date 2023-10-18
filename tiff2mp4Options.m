classdef tiff2mp4Options
% tiff2mp4Options Options for use with tiff2mp4 and ffmpeg
%   ---
%   HINT: While advanced methods are available, simply specifing the
%   desired output framerate in the framerateInput (yup!) will allow ffmpeg
%   to automatically calculate the proper input/out rates and the
%   durationFactor. The other two variables can be left blank.
%
%   framerateInput:     the frame rate (fps) of the input images (ex 1000
%                       fps). Default 30 fps
%   framerateOutput:    the frame rate (fps) of the output video (ex 30
%                           fps). Assumes input rate if not specified.
%   durationFactor:     The duration of the video in relation to the input
%                           files.
%   ---
%   HINT: Paths are the paths to the directory holding files. FileNames are
%   the name of the files with the proper extension. No further checks are
%   performed.
%
%   inputPath:          the directory to the images.
%   inputFileName:      the name of the files with extension. wildcards and
%                           formatting characters are allowed. (ex. %05d.mp4)
%   outputPath:         same as inputPath, but for the output file
%   outputFileName:     outputfile name, with extension (ex. output.mp4)
%   startIdx:           Index of first image. If not specified, smallest index.
%   endIdx:             Index of last image. Only works with a startIdx.
%   numFrames:          Number of frames to process, starting at startIdx.
%                           This is not necessary the frames in the output 
%                           file as some may be duplicated or dropped.
%   frameSize:          Size of output frame in the format of [Width,
%                           Height]. Uses input image size as default.
%   videoCodec:         Output video codec to use for conversion. ffmpeg
%                           automatically selects a codec if not specified.
%   
%   ---
%   Quality parameters specific to encoder x264 (libx264, common for mp4):
%   overwrite:          Overwrites the output file is one exists already.
%   crf:                Constant Rate Factor. use 0 for lossless quality,
%                           and 51 for worst quality. default is 23.
%   tune:               Tuning presets for type of input. Possible values
%                           are: film, animation, grain, stillimage,
%                           fastdecode, and zerolatency.
%
%   Copyright 2020 Jason Chan, v1.0
    
    properties
        framerateInput = 30
        framerateOutput = []
        inputPath = '%HOMEPATH%'
        inputFileName = '%05d.tif'
        outputPath = ''
        outputFileName = ''
        
        startIdx = []
        endIdx = []
        numFrames = []
        frameSize = []
        overwrite = false;
        
        videoCodec = '' %'libx264'
        crf = []; % 0=loseless, 51 = max compression, 23=default
        tune = 'stillimage';  % film, animation, grain, stillimage, fastdecode, etc
        durationFactor = [];
    end
    
    methods
       
        function obj  = tiff2mp4Options()
            if ~ispc
                obj.inputPath = '';
            end
        end
    end
        
end