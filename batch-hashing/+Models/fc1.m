function [net, imageSize] = fc1(opts)

imageSize = 0;
if opts.normalize
    lr = [1 0.1] ;
else
    lr = [1 1];
end
net.layers = {} ;

% FC layer
net.layers{end+1} = struct('type', 'conv', ...
    'name'         , 'fc1'           , ...
    'weights'      , {Models.init_weights(1, 4096, opts.nbits)} , ...
    'learningRate' , lr              , ...
    'stride'       , 1               , ...
    'pad'          , 0 ) ;

% loss layer
net.layers{end+1} = struct('type', 'custom', ...
    'name'     , 'loss'         , ...
    'weights'  , []             , ...
    'precious' , false          , ...
    'opts'     , opts           , ...
    'forward'  , @mi_forward    , ...
    'backward' , @mi_backward );

% Meta parameters
net.meta.inputSize = [1 1 4096] ;

% Fill in default values
net = vl_simplenn_tidy(net) ;

end