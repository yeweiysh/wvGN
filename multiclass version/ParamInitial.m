classdef ParamInitial
    properties
        C
        epps
        lamda = 0.0156;
        maxIter=1000;
        D
    end
    methods
        function obj = ParamInitial(C, epps, D)
            obj.C = C;
            obj.epps = epps;
            obj.D = D;
        end
    end
end