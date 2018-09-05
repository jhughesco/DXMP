<Forms FormName="Admin_Classified_Location">
  <Style Theme="none" LabelAlign="left"    LabelWidth=""/>
  <Form Type="Add">
    <Data TableName="XMP_Classified_Location" Key="LocationID" SelectedFields="City,State" />
    <Controls>
      <TextBox Id="City" Width="165" MaxLength="25" DataField="City">
        <Label For="City">City</Label>
              <Validate Type="required" Text="*" Message="Please enter a city." />

      </TextBox>

      <TextBox Id="State" Width="35" MaxLength="5" DataField="State">
        <Label For="State">State</Label>
              <Validate Type="required" Text="*" Message="Please enter a state." />

      </TextBox>

      <ValidationSummary Id=" ClassifiedLocation" DisplayMode="BulletList" HeaderText="Please correct the following errors."/>


      <CommandButtons>
        <AddButton Text="Add" /> 
        <UpdateButton Text="Update" /> 
        <CancelButton Text="Cancel" style="margin-left: 12px;" Visible="true"/> 
      </CommandButtons>
    </Controls>
  </Form>
</Forms>