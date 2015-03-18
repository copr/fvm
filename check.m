function [] = check(r, message)
if nargin == 1
    message = '';
end

if isnan(r)
    error('Cislo je NaN %s', message)
end

if isinf(r)
    error('Cislo je Inf %s', message)
end


end

