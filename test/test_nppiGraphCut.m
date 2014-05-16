function test_nppiGraphCut()
    addpath('../external_code');
    addpath('../external_code/npp');
    addpath('../external_code/CMF v1.0');
    addpath('../external_code/vlfeats/toolbox/kmeans/');
    addpath('../external_code/vlfeats/toolbox/mex/mexa64/');
    addpath('../external_code/vlfeats/toolbox/mex/mexglx/');
    
    
	%img_name = '2010_000238'; % airplane and people   
    img_name = '2007_009084'; % dogs, motorbike, chairs, people    
    %img_name = '2010_002868'; % buses   
    %img_name = '2010_003781'; % cat, bottle, potted plants

    I = imread(['../data/JPEGImages/' img_name '.jpg']);
    I = single(I)/255;

    rows = size(I, 1);
    cols = size(I, 2);

    width = 5;
    height = 5;

    foregroundSeeds = extractSeeds(I, 170, 150, width, height);

    backgroundSeeds = [];
%     backgroundSeeds = [backgroundSeeds; extractSeeds(I, 1, 1, cols, 1)];
    backgroundSeeds = [backgroundSeeds; extractSeeds(I, 1, 1, 1, rows)];
    backgroundSeeds = [backgroundSeeds; extractSeeds(I, 1, cols, 1, rows)];
%     backgroundSeeds = [backgroundSeeds; extractSeeds(I, rows, 1, cols, 1)];

%     backgroundSeeds = extractSeeds(I, 204, 420, width, height);
%     backgroundSeeds = [backgroundSeeds; extractSeeds(I, 335, 186, width, height)];
%     backgroundSeeds = [backgroundSeeds; extractSeeds(I, 300, 20, width, height)];
%     
    
%     backgroundSeeds = backgroundSeeds(randsample(size(backgroundSeeds, 1), 25), :);

    Cs = computeCapacity(I, foregroundSeeds);
    Ct = computeCapacity(I, backgroundSeeds);

%       rows = 10;
%       cols = 15;
% 
%       Cs = zeros(rows, cols);
%       Cs(3:7, 3:7) = 1;
%       
%       Ct = zeros(rows, cols);
%       Ct(:, 1) = 1;
%       Ct(:, cols) = 1;
      

%     penalty = 0.5*ones(rows,cols);

%     CG = colgrad(I);  
%     penalty = 4.0*(CG*1.0 + 1).^-1;



%     CLT = single(0.5*ones(cols, rows));
%     CLT(1, :) = 0;
%     CRT = single(0.5*ones(cols, rows));
%     CRT(cols, :) = 0;
%     CT = single(0.5*ones(rows, cols));
%     CT(1, :) = 0;
%     CB = single(0.5*ones(rows, cols));
%     CB(rows, :) = 0;

    CLT = single(zeros(cols, rows));
    CRT = single(zeros(cols, rows));
    CT = single(zeros(rows, cols));
    CB = single(zeros(rows, cols));

    CCD = single(Cs-Ct);
    
    labels = nppiGraphcut_32f8u_mex(cols, rows, CCD, CLT, CRT, CT, CB); 
    
    unique(labels)

%     uu = im2bw(uu, level);
    
    figure, imagesc(labels);

end
