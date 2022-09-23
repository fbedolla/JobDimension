/// <summary>
/// PageExtension JobDimSetupExt (ID 67125) extends Record Jobs Setup.
/// </summary>
pageextension 67125 JobDimSetupExt extends "Jobs Setup"
{
    layout
    {
        addlast(General)
        {
            field("JobDimCreation Active"; Rec."JobDimCreationActive")
            {
                ApplicationArea = All;
            }
            field("Defined Job Dimension"; Rec."Defined Job Dimension")
            {
                ApplicationArea = All;
            }
            field(DefaultValuePosting; Rec.DefaultValuePosting)
            {
                ApplicationArea = All;
            }
        }
    }
}
