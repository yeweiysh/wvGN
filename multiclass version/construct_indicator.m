function [indicator] = construct_indicator(index, numlabel)
% [indicator] = construct_indicator(index, numlabel)
% construct an indicator according to the sorted index 
% Each row only assign 1 to the top ranking indicators
%
% This function is used when evaluating the prediction output by instance
  