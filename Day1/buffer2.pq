let
    List.Summarize = lib[List.Summarize],

    Depths = List.Buffer({
        199, 200, 208, 210, 200, 207, 240, 269, 260, 263
    }),

    AccumulateStep  = (state, next) =>
        //accumulate  step
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

    CountIncreasingValues = (source as list) as any =>
        let
            changedCount = List.Accumulate(
                List.Range(source, 1),
                [
                    Previous = source{0}, Total = 0
                ], AccumulateStep
            )
        in
            changedCount,


    z = CountIncreasingValues( Depths ),



    Results = [
        z = z[Total],
        Original = List.Summarize( Depths )
        // TimesChanged = changedCount[Total]
    ]
in
    Results