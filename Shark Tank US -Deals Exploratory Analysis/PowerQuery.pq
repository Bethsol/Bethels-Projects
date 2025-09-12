let
    Source = Csv.Document(File.Contents("SharkTankData.csv"),[Delimiter=",", Columns={"..."}, Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // Step 1: Replace blanks in the 'Original Offered Equity' column with '0'
    #"Replaced Values" = Table.ReplaceValue(
        #"Promoted Headers",
        " ",
        "0",
        Replacer.ReplaceText,
        {"Original Offered Equity"}
    ),
    
    // Step 2: Change the data type of 'Original Offered Equity' to Decimal
    #"Changed Type with Locale" = Table.TransformColumnTypes(
        #"Replaced Values",
        {
            {"Original Offered Equity", type number}
        },
        "en-US"
    ),

    // Step 3: Replace blanks in the 'Original Ask Amount' with '0'
    #"Replaced Values1" = Table.ReplaceValue(
        #"Changed Type with Locale",
        " ",
        "0",
        Replacer.ReplaceText,
        {"Original Ask Amount"}
    ),

    // Step 4: Change the data type of 'Original Ask Amount' to Decimal
    #"Changed Type with Locale1" = Table.TransformColumnTypes(
        #"Replaced Values1",
        {
            {"Original Ask Amount", type number}
        },
        "en-US"
    ),

    // Step 5: Clean and format date column if applicable
    #"Cleaned Date" = Table.TransformColumnTypes(
        #"Changed Type with Locale1", 
        {
            {"Date of Pitch", type date}
        },
        "en-US"
    )

in
    #"Cleaned Date"