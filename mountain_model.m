function height = mountain_model(h, xm, ym, xt, yt, x, y)
    height = h * exp(-(((x-xm)^2)/xt + ((y-ym)^2)/yt));
end
