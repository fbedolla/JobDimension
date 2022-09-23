/// <summary>
/// Codeunit JobDimSuscribers (ID 67125).
/// </summary>
codeunit 67125 JobDimSuscribers
{
    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterInsertEvent', '', true, true)]
    local procedure CreaDim(var Rec: Record job)
    var
        AppSetup: Record "Jobs Setup";
        Dim: Record "Dimension Value";
    begin
        AppSetup.Get();
        if AppSetup.JobDimCreationActive = true then
            if AppSetup."Defined Job Dimension" <> '' then begin
                Dim.SetRange("Dimension Code", AppSetup."Defined Job Dimension");
                Dim.SetRange(Code, Rec."No.");
                if Not Dim.FindFirst() then begin
                    Dim.Init();
                    Dim."Dimension Code" := AppSetup."Defined Job Dimension";
                    Dim.Code := Rec."No.";
                    Dim.Insert(true);
                end;
            end else
                Error(Err001);
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterBillToCustomerNoUpdated', '', true, true)]
    local procedure RenameDim(var Job: Record Job)
    var
        AppSetup: Record "Jobs Setup";
        Dim: Record "Dimension Value";
        DefDim: Record "Default Dimension";
    begin
        AppSetup.Get();
        if AppSetup.JobDimCreationActive = true then
            if AppSetup."Defined Job Dimension" <> '' then begin
                Dim.SetRange("Dimension Code", AppSetup."Defined Job Dimension");
                Dim.SetRange(Code, Job."No.");
                if Dim.FindSet() then begin
                    Dim.Name := Job.Description;
                    Dim.Modify(true);
                end;

                DefDim.Reset();
                DefDim."Table ID" := 167;
                DefDim."No." := Job."No.";
                DefDim."Dimension Code" := AppSetup."Defined Job Dimension";
                DefDim."Dimension Value Code" := Job."No.";
                DefDim."Value Posting" := AppSetup.DefaultValuePosting;
                DefDim.Insert(true);
            end else
                Error(Err001);
    end;


    [EventSubscriber(ObjectType::Table, Database::Job, 'OnAfterDeleteEvent', '', true, true)]
    local procedure DelDim(var Rec: Record Job)
    var
        AppSetup: Record "Jobs Setup";
        Dim: Record "Dimension Value";
    begin
        AppSetup.Get();
        if AppSetup.JobDimCreationActive = true then
            if AppSetup."Defined Job Dimension" <> '' then begin
                Dim.SetRange("Dimension Code", AppSetup."Defined Job Dimension");
                Dim.SetRange(Code, Rec."No.");
                if Dim.FindSet() then
                    Dim.DeleteAll();
            end else
                Error(Err001);
    end;

    var
        Err001: Label 'You need to select a dimension code in Jobs Setup before create a new job.';
}
