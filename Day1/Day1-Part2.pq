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



    src = Depths,
    GenerateSegments = (source as any) as any =>
        // inner
        let
            len = List.Count(src),
            offsetList = {0..(len-1)},

            segmentPos = List.Transform(
                offsetList,
                (i) =>
                    [
                        Pos = i,
                        Segment = List.Range( src, i, 3)
                    ]),
            generateSegments = Table.FromRecords( segmentPos,
                type table[ Pos = Int64.Type, Segment = List.Type ] ),
            typing = Table.TransformColumnTypes(generateSegments,{{"Pos", Int64.Type}}),
            segmentSummary = Table.AddColumn(
                typing, "Summary", (_) as text => List.Summarize(_[Segment])
            ),
            sumSegments = Table.AddColumn(segmentSummary, "SumSegment", (_) as number => List.Sum( [Segment] ), Int64.Type)
        in
            sumSegments,

    z = GenerateSegments(Depths),


    #"part2-finalCount" = CountIncreasingValues( sumSegments[SumSegment] ),

        // t0 = Table.FromList(segmentPos),

    countSample = CountIncreasingValues( Depths ),
    input1Count = CountIncreasingValues( day1_input1[Number] ),


    Results = [
        Original = List.Summarize( Depths ),
        countInc_Sample = countSample,
        isValid = Assert.Equal(countSample, 7),
        countInc_full = input1Count,


        Original2 = List.Summarize( day1_input1[Number] ),

        Part2_isValid = Assert.Equal( #"part2-finalCount", 5)
    ]
in
    Results