report 50005 "Print Case Lables CBR"
{
    DefaultLayout = RDLC;
    Caption = 'Print Case Lables';
    RDLCLayout = './PrintCaseLabelsCBR.rdl';

    dataset
    {
        dataitem(Item; "Item")
        {
            column(i; i)
            {
            }
            column(j; j)
            {
            }
            column(ItemDescription; Item.Description)
            {
            }
            column(LotNo; LotNo)
            {
            }
            column(GTIN; Item.GTIN)
            {
            }

            column(ExpirationDate; ExpirationDate)
            {
            }
            column(ItemNo; Item."No.")
            {
            }
            column(Lot_BarCode; EncodeBarCode)
            {

            }
            column(GTIN_BarCode1; EncodeBarCode1)
            {

            }
            dataitem(Loops; Integer)
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 0;
                dataitem(IntegerHeader; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(NoOfLoops; NoOfLoops)
                    {
                    }
                    column(Copytext; CopyText)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var

                begin
                    //NoOfCopies+=1;
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        IF ISSERVICETIER THEN
                            OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    ExpirationDate := FORMAT(ExpirationDates, 0, 4);
                    LotNo := LotNumber;

                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Codabar;
                    BarcodeString := LotNumber;
                    BarcodeString1 := Item.GTIN;
                    EncodeBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    EncodeBarCode1 := BarcodeFontProvider.EncodeFont(BarcodeString1, BarcodeSymbology);

                    IF i = 1 THEN BEGIN
                        j += 1;
                        i := 0;
                    END;
                    i += 1;
                    //CurrReport.Break();
                end;

                trigger OnPreDataItem()
                begin
                    //NoOfLoops := ABS(NoOfCopies) + 1;
                    NoOfLoops := ABS(NoOfCopies);
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    IF ISSERVICETIER THEN
                        OutputNo := 1;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field("Lot No."; LotNumber)
                    {
                        Caption = 'Lot No.';
                        ApplicationArea = All;
                    }
                    field("Expiration Date"; ExpirationDates)
                    {
                        Caption = 'Expiration Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        G_ItemNo: Text;
        i: Integer;
        j: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        CopyText: Text[30];
        PageCaptionCap: Label 'Page %1 of %2';
        Text003: Label 'copy';
        ExpirationDates: Date;
        LotNumber: Code[20];
        LotNo: Text;
        ExpirationDate: Text;
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProvider: Interface "Barcode Font Provider";
        BarcodeString: Text;
        EncodeBarCode: Text;
        BarcodeString1: Text;
        EncodeBarCode1: Text;
}

