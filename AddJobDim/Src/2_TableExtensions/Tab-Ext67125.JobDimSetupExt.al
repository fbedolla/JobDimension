/// <summary>
/// TableExtension JobDimSetupExt (ID 67125) extends Record Jobs Setup.
/// </summary>
tableextension 67125 JobDimSetupExt extends "Jobs Setup"
{
    fields
    {
        field(67125; "Defined Job Dimension"; Code[20])
        {
            Caption = 'Defined Job Dimension';
            DataClassification = CustomerContent;
            TableRelation = Dimension.Code;
        }
        field(67126; "JobDimCreationActive"; Boolean)
        {
            Caption = 'Job Dimension AutoCreation Active';
            DataClassification = CustomerContent;
        }
        field(67127; "DefaultValuePosting"; Enum "Default Dimension Value Posting Type")
        {
            Caption = 'Default Value Posting';
            DataClassification = CustomerContent;
        }
    }
}
