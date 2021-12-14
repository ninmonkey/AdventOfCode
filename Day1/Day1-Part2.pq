let
    List.Summarize = lib[List.Summarize],

    Depths = List.Buffer({199, 200, 208, 210, 200, 207, 240, 269, 260, 263}),

    AccumulateStep  = (state, next) as record =>
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


    z = List.Range(Depths, 0, 3),
    src = Depths,
    len = List.Count(src),
    offsetList = {0..(len-1)},

    segmentPos = List.Transform(
        offsetList,
        (i) =>
            [
                Pos = i,
                Segment = List.Range( src, i, 3)
            ]
    ),

    t0 = Table.FromList(segmentPos),


    CountIncreasingValues = (source as list) as number =>
        // How many times does the depth increase?
        let
            changedCount = List.Accumulate(
                List.Range(source, 1),
                [
                    Previous = source{0}, Total = 0
                ], AccumulateStep
            )
        in
            changedCount[Total],

    Assert.Equal = (actual as any, expected as any) as any =>
        let
            areEqual = actual = expected,
            result =
                if areEqual then true
                else error Error.Record("AssertEqualValue", "Values are not equal",
                    [
                        expected = expected,
                        actual = actual
                    ]
                )
        in
            result,

    countSample = CountIncreasingValues( Depths ),
    input1Count = CountIncreasingValues( day1_input1[Number] ),
    Custom1 = Table.FromRecords( segmentPos,
        type table[ Pos = Int64.Type, Segment = List.Type ] ),
    #"Changed Type" = Table.TransformColumnTypes(Custom1,{{"Pos", Int64.Type}}),
    t = Table.AddColumn(
        #"Changed Type", "Summary", (_) as text => List.Summarize(_[Segment])
    ),
    #"Added Custom" = Table.AddColumn(t, "SumSegment", (_) as number => List.Sum( [Segment] ), Int64.Type),

    inputPart2Count = CountIncreasingValues( #"Added Custom"[SumSegment] ),
    Results = [
        Original = List.Summarize( Depths ),
        countInc_Sample = countSample,
        isValid = Assert.Equal(countSample, 7),
        countInc_full = input1Count,


        Original2 = List.Summarize( day1_input1[Number] ),

        Part2_isValid = Assert.Equal( inputPart2Count, 5)
    ]
in
    Results