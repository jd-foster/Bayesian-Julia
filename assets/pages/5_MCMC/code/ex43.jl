# This file was generated, do not modify it. # hide
model = dice_throw(data_dice)
chain = sample(model, NUTS(), 2_000);
summarystats(chain)