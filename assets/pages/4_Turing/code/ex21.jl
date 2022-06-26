# This file was generated, do not modify it. # hide
posterior_check = predict(model_predict, chain);
summarystats(posterior_check[:, 1:5, :]) # just the first 5 posterior samples