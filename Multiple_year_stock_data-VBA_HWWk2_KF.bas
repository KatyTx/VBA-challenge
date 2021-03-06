Attribute VB_Name = "Module1"
'Create a script that will loop through all the stocks for one year and output the following information.
Sub Stock()

    Dim ws As Worksheet
 
 ' loop through the sheets
    
    For Each ws In Worksheets
    
    ws.Activate
    
    'The ticker symbol location
    Dim Summary_Section As Integer
    Summary_Section = 2
    
        
     'declare data types
    Dim Ticker As String
    Dim Volume As Long
    Dim Percentage_Change As Double
    Dim Yearly_Change As Double
    Dim year_open As Double
    Dim year_close As Double
    
    
    'assign variables known
    Volumetotal = 0
   
        
        'Add Ticker to Column II
        ws.Cells(1, 9).Value = "Ticker"
        
        'Add Yearly Change to Column J1
        ws.Cells(1, 10).Value = "Yearly Change"
        
        'Add Percent Change to K1
        ws.Cells(1, 11).Value = "Percent Change"
                
                'Add Total Stock Volume to L1
        ws.Cells(1, 12).Value = "Total Stock Volume"
      
      'CHALLENGE
             'Add greatest % increase to Column O2
        ws.Cells(2, 15).Value = "Greatest % Increase"
           
           'Add to greatest % decrease Column O3
        ws.Cells(3, 15).Value = "Greatest % Decrease"
           
           'Add greatest total volume column O4
        ws.Cells(4, 15).Value = "Greatest Total Volume"
    
    
           'Add Ticker to Column P1
        ws.Cells(1, 16).Value = "Ticker"
           
           'Add Value to Column Q1
        ws.Cells(1, 17).Value = "Value"
      
      
        'determine the last row in each
        lastrow = Cells(Rows.Count, 1).End(xlUp).Row
             
        
    'loop through the rows first to test#1001 but will subfor lastrow
                             
        For i = 2 To lastrow
                
            'checking if tickers are the different from top
            If Cells(i - 1, 1).Value <> Cells(i, 1).Value Then
                
            'capture opening price when the ticker is new and changed from previous
            year_open = Cells(i, 3).Value
            
            ' set the ticker name only count there a change
            Ticker = Cells(i, 1).Value
            
            'add the stock volume, create a volume total for each different, same, new
            Volumetotal1 = Volumetotal0 + Cells(i, 7).Value
            
                                    
            'for each row that is different from the last row in section
            ElseIf Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
            
            'add closing price, last date of the year from the last ticker
            year_close = Cells(i, 6).Value
            
              'add the stock volume, create a volume total for each different, same, new
            Volumetotal = Volumetotal + Cells(i, 7).Value
            
            'add yearly change close-open can do after closing if stmts
            Yearly_Change = year_close - year_open
                                                       
                          
            'Yearly change from opening price at the beginning of a given year to the closing price at the end of that year.
           
                If year_open <> 0 Then
                    Percentage_Change = Yearly_Change / year_open
                Else
                    Percentage_Change = 0
                End If
                
                    'Print ticker name in summary table
                    Range("I" & Summary_Section).Value = Ticker
                    
                    'print volume in summary table
                    Range("L" & Summary_Section).Value = Volumetotal
                    
                    'print yearly change in summary table
                    Range("J" & Summary_Section).Value = Yearly_Change
                    'You should also have conditional formatting that will highlight positive change in green and negative change in red.
                    'red color=3 green color=4
                          
                            If Yearly_Change < 0 Then
                                     Range("J" & Summary_Section).Interior.ColorIndex = 3
                                 Else
                                     Range("J" & Summary_Section).Interior.ColorIndex = 4
                                 End If
                         
                    'print percentage change in summary table
                    Range("K" & Summary_Section).Value = Percentage_Change
                          
                                                                 
                    'Add one to summary table row for other ticker
                    Summary_Section = Summary_Section + 1
                    
                    ' then add same tickers
                     Volumetotal = Volumetotal + Cells(i, 7).Value
                    
                    'reset ticker total volumes
                    Volumetotal = 0
                    
             'for each row that is the same
            Else: Cells(i, 1).Value = Cells(i, 1).Value
               
            'add the stock volume, create a volume total for each different, same, new
            Volumetotal = Volumetotal + Cells(i, 7).Value
                     
            End If
                      
             
        'end loop for rows checks within worksheet
        Next i
        
    ws.Columns("K").NumberFormat = "0.00%"
        
           
        
    'end worksheet loop
    'Next ws
 
 
 'CHALLENGE:create a loop that reviews the summary sheet
  'declare data types
  
  Dim Maxpercent As Double
  Dim Minpercent As Double
  Dim Maxvolume As Double
  Dim Maxindex As Integer
  Dim Minindex As Integer
  Dim Volumeindex As Integer

'declare variables to start counts
  Maxpercent = 0
  Minpercent = 0
  Maxvolume = 0
  Maxindex = 0
  Minindex = 0
  Volumeindex = 0
  
'second loop over information in summary table
    lastrow = Cells(Rows.Count, 11).End(xlUp).Row
    For k = 2 To lastrow
                                                 
               'review I through L
               'identify which had the greatest % increase in column K max?
                
                If Cells(k, 11) > 0 Then
                    If Cells(k, 11) > Maxpercent Then
                        Maxpercent = Cells(k, 11)
                        Maxindex = k
                    End If
                End If
               
               If Cells(k, 11) < 0 Then
                    If Cells(k, 11) < Minpercent Then
                        Minpercent = Cells(k, 11)
                        Minindex = k
                    End If
                End If
                              
               If Cells(k, 12) > 0 Then
                    If Cells(k, 12) > Maxvolume Then
                        Maxvolume = Cells(k, 12)
                        Volumeindex = k
                    End If
                End If
    
    'close summary loop
    Next k
    
    'identify where the loop outputs will go
    Cells(2, 16) = Cells(Maxindex, 9)
    Cells(2, 17) = Maxpercent
    Range("Q2").NumberFormat = "0.00%"
    
    Cells(3, 16) = Cells(Minindex, 9)
    Cells(3, 17) = Minpercent
    Range("Q3").NumberFormat = "0.00%"
    
    Cells(4, 16) = Cells(Volumeindex, 9)
    Cells(4, 17) = Maxvolume
    
    
 'autofit data in columns
 Columns("I:Q").AutoFit
  
 'end loop of worksheets
 Next ws
  



End Sub


