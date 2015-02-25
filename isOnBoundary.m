function [bool] = isOnBoundary(j, i, nx, ny)
bool = false;
if j == 1 || j == nx || i == 1 || i == ny
    bool = true;
end