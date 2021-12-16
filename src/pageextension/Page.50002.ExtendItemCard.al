pageextension 50002 Extenditemcard extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Item Reclassification Journal")
        {
            action("Print Case Labels")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Case Labels';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(REPORT::"Print Case Lables CBR", TRUE, FALSE, Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}