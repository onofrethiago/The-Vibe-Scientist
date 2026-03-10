Sub GenerateSalesAnalysis()
    Dim ws As Worksheet
    Dim i As Integer
    Dim chartObj As ChartObject

    ' Clear memory
    Set ws = ActiveSheet
    ws.Cells.Clear

    ' Generate synthetic dataset (100 rows)
    ws.Cells(1, 1).Value = "Date"
    ws.Cells(1, 2).Value = "Sales"
    ws.Cells(1, 3).Value = "3-Month Moving Average"

    ' Set random seed (simulated)
    Randomize 42

    ' Populate dataset
    For i = 2 To 101
        ws.Cells(i, 1).Value = DateSerial(2018, 1 + (i - 2), 1)
        ws.Cells(i, 2).Value = Int((500 - 100 + 1) * Rnd + 100) + (i - 2) * 2
        
        ' Calculate 3-month moving average
        If i >= 4 Then
            ws.Cells(i, 3).Value = Application.WorksheetFunction.Average(ws.Range(ws.Cells(i - 2, 2), ws.Cells(i, 2)))
        End If
    Next i

    ' Visualization
    Set chartObj = ws.ChartObjects.Add(Left:=300, Width:=600, Top:=10, Height:=300)
    With chartObj.Chart
        ' Clear default series
        Do While .SeriesCollection.Count > 0: .SeriesCollection(1).Delete: Loop
        
        ' Add scatter plot for sales
        With .SeriesCollection.NewSeries
            .Name = "Monthly Sales"
            .XValues = ws.Range(ws.Cells(2, 1), ws.Cells(101, 1))
            .Values = ws.Range(ws.Cells(2, 2), ws.Cells(101, 2))
            .ChartType = xlXYScatter
            .MarkerBackgroundColor = RGB(0, 119, 182)
            .MarkerForegroundColor = RGB(0, 119, 182)
            .MarkerSize = 5
        End With
        
        ' Add line series for moving average
        With .SeriesCollection.NewSeries
            .Name = "3-Month Moving Average"
            .XValues = ws.Range(ws.Cells(4, 1), ws.Cells(101, 1))
            .Values = ws.Range(ws.Cells(4, 3), ws.Cells(101, 3))
            .ChartType = xlXYScatterSmoothNoMarkers
            With .Format.Line
                .ForeColor.RGB = RGB(214, 40, 40)
                .Weight = 2.5
            End With
        End With
        
        ' Aesthetic styling
        .HasTitle = True
        .ChartTitle.Text = "Monthly Sales Analysis"
        .Axes(xlValue).HasMajorGridlines = False
        .Axes(xlCategory).HasMajorGridlines = False
        .PlotArea.Format.Fill.Transparency = 1
        .ChartArea.Border.LineStyle = xlNone
        .Legend.Position = xlLegendPositionBottom
        .Legend.Format.Line.Visible = msoFalse
    End With
End Sub
