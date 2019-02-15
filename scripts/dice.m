function  DiceCoef = dice(segIm, grndTruth)

DiceCoef = 2*nnz(segIm&grndTruth)/(nnz(segIm) + nnz(grndTruth));