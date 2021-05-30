function H = fhog( I, binSize, nOrients, clip, crop )
% Efficiently compute Felzenszwalb's HOG (FHOG) features.
%
%
% This function is essentially a wrapper for calls to gradientMag()
% and gradientHist(). Specifically, it is equivalent to the following:
%  [M,O] = gradientMag( I,0,0,0,1 ); softBin = -1; useHog = 2;
%  H = gradientHist(M,O,binSize,nOrients,softBin,useHog,clip);
% See gradientHist() for more general usage.
%
% USAGE
%  H = fhog( I, [binSize], [nOrients], [clip], [crop] )
%
% INPUTS
%  I        - [hxw] color or grayscale input image (must have type single)
%  binSize  - [8] spatial bin size
%  nOrients - [9] number of orientation bins
%  clip     - [.2] value at which to clip histogram bins
%  crop     - [0] if true crop boundaries
%
% OUTPUTS
%  H        - [h/binSize w/binSize nOrients*3+5] computed hog features


if( nargin<2 ), binSize=8; end
if( nargin<3 ), nOrients=9; end
if( nargin<4 ), clip=.2; end
if( nargin<5 ), crop=0; end

softBin = -1; useHog = 2; b = binSize;

[M,O]=gradientMex('gradientMag',I,0,1);

H = gradientMex('gradientHist',M,O,binSize,nOrients,softBin,useHog,clip);

if( crop ), e=mod(size(I),b)<b/2; H=H(2:end-e(1),2:end-e(2),:); end

end
