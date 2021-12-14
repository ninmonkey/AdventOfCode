let
    List.Summarize = lib[List.Summarize],

    Depths = List.Buffer({
        199, 200, 208, 210, 200, 207, 240, 269, 260, 263
    }),

    accum = (state, next) =>
        let
            isIncreasing = state[Previous] < next,
            newTotal =
                if isIncreasing then state[Total] + 1 else state[Total],
            result = [
                Total = newTotal,
                Previous = next
            ]
        in
            result,
            // result,

    changedCount = List.Accumulate(
        List.Range(Depths, 1),
        [
            Previous = Depths{0},
            Total = 0
        ], accum
    ),



    Results = [
        Original = List.Summarize( Depths ),
        TimesChanged = changedCount[Total]
    ]
in
    Results