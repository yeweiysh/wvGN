classdef Problem
    properties
        l
        n
        y
        x
    end
    methods
        function obj = Problem(l,n,x,y)
            obj.l=l;
            obj.n=n;
            obj.x=x;
            obj.y=y;
        end
    end
end