<Forms FormName="Admin_Classified_Location">
  <Style Theme="none" LabelAlign="left"    LabelWidth=""/>
  <Form Type="Add">
    <Data TableName="XMP_Classified_Location" Key="LocationID" SelectedFields="City,State" />
    <Controls>
      <TextBox Id="City" Width="165" MaxLength="25" DataField="City">
        <Label For="City">City</Label>
      </TextBox>

      <TextBox Id="State" Width="35" MaxLength="5" DataField="State">
        <Label For="State">State</Label>
      </TextBox>

      <ValidationSummary Id="vsXMP_Classified_Location"/>


      <CommandButtons>
        <AddButton Text="Add" /> 
        <UpdateButton Text="Update" /> 
        <CancelButton Text="Cancel" style="margin-left: 12px;" Visible="true"/> 
      </CommandButtons>
    </Controls>
  </Form>
</Forms>