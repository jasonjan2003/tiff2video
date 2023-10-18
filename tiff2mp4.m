function tiff2mp4(options, ffmpegPath)
%   tiff2mp4 A function that converts input images to an output video using ffmpeg.
%   options:    an tiff2mp4Options object. Required.
%   ffmpegPath: the path the the ffmpeg executable. If not specified, the
%               function assumes one is available in the system path.
%               Visit http://ffmpeg.org/download.html to download and
%               install.
%
%   Copyright 2020 Jason Chan, v1.0
    
    % require passing options
    if nargin == 0
        error('Options are required.');
    end
    
    % Pick the ffmpeg path to use
    if nargin >= 2
        command = ffmpegPath;
    else
        % check if ffmpeg is on system path
        [stat,~]=system('ffmpeg -version');
        if stat == 0
            command = 'ffmpeg';
        elseif ispc()
            command = ['"' fullfile(mfilename('fullpath'),'..','ffmpeg_bin','WIN','ffmpeg.exe') '"'];
        elseif ismac()
            command = ['"' fullfile(mfilename('fullpath'),'..','ffmpeg_bin','MACOS','ffmpeg') '"'];
        else
            error('Please supply appropriate FFMPEG version for Linux/Unix systems.');
        end
    end
    
    % Check if ffmpeg is working properly
    [v, ~] = system( sprintf('%s -version', command) );
    if v
        error('Something wrong happened to the executable!')
    end

    % input framerate
    if ~isempty(options.framerateInput)
        add_flag('framerate', '%d', options.framerateInput);
    end
    
    % start idx
    if ~isempty(options.startIdx)
        add_flag('start_number', '%d', options.startIdx);
        
        % end idx, sort of
        if ~isempty(options.endIdx)
        	add_flag('frames:v', '%d', options.endIdx - options.startIdx + 1);
        end
    end
    
    % number of frames
    if ~isempty(options.numFrames)
        add_flag('frames:v', '%d', options.numFrames);
    end
    
    % input files
    if ~isempty( options.inputPath ) && ~isempty( options.inputFileName )
        fullFilePathName = fullfile(options.inputPath, options.inputFileName);
        add_flag('i', '"%s"', fullFilePathName);
    else
        error('Input file path and name needed');
    end
    
    % video codec
    if ~isempty( options.videoCodec )
        add_flag('c:v', '%s', options.videoCodec);
    end
    
    % frame size
    if ~isempty( options.frameSize )
        frameSize = options.frameSize;
        add_flag('s', '%s', frameSize(0) + "x" + frameSize(1));
    end
    
    % CRF (Constant Rate Factor)
    if ~isempty( options.crf )
        add_flag('crf', '%d', options.crf);
    end
    
    % output framerate
    if ~isempty(options.framerateOutput)
        add_flag('r', '%d', options.framerateOutput);
    end
    
    % video filter
    if ~isempty( options.durationFactor )
        add_flag('filter:v', '%s', ...
            sprintf('"setpts=%.1f*PTS"',options.durationFactor) );
    end
    
    % tune
    if ~isempty(options.tune)
        add_flag('tune', '%s', options.tune);
    end
    
    % overwrite outputfile?
    if options.overwrite
        add_flag('y', '%c', '');
    end
    
    % output file
    if ~isempty( options.outputFileName )
        fullFilePathName = fullfile(options.outputPath, options.outputFileName);
        add_flag('', '"%s"', fullFilePathName);
    else
        error('Output file path and name needed');
    end

    system( command );
    
    function add_flag(flag, fmt, val)
        if isempty(flag)
            command = sprintf(char("%s " + fmt), command, val);
        else
            command = sprintf(char("%s -" + flag + " " + fmt), command, val);
        end
    end
    
end
