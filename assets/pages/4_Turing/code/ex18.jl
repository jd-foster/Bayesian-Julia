# This file was generated, do not modify it. # hide
missing_data = Vector{Missing}(missing, length(data)) # vector of `missing`
model_missing = dice_throw(missing_data)
model_predict = DynamicPPL.Model{(:y,)}(:model_predict_missing_data,
                    model_missing.f,
                    model_missing.args,
                    model_missing.defaults) # instantiate the "predictive model"
prior_check = predict(model_predict, prior_chain);