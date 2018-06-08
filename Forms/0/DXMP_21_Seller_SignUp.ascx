<register tagprefix="rmg" namespace="reflect.xile" assembly="reflect.xile" />
<AddForm>

  <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
    <style type="text/css">
      .validate-error {
        position: absolute;
        top: 0;
        left: 0;
        color: red;
      }
      .required-field {
        border-left: 1px solid red; 
      }
    </style>  
  </ScriptBlock> 
  
  <SelectCommand CommandText="SELECT @UserID AS UserID">
    <Parameter Name="UserID" Value='[[User:ID]]' DataType="Int32" />
  </SelectCommand>

  <SubmitCommand CommandText="INSERT INTO [XMP_Classified_Seller] 
                              (
                                 [UserID]
                                ,[Seller_Name]
                                ,[Seller_Address]
                                ,[Seller_Location]
                                ,[Seller_Phone]
                                ,[Seller_Email]
                                ,[Show_Address_By_Default]
                                ,[Show_Phone_By_Default]
                                ,[Seller_Image]
                                ,[Seller_Level]
                                ,[Agree]                              	
                              ) 
                                VALUES
                              (
                                 @UserID
                                ,@Seller_Name
                                ,@Seller_Address
                                ,@Seller_Location
                                ,@Seller_Phone
                                ,@Seller_Email
                                ,@Show_Address_By_Default
                                ,@Show_Phone_By_Default
                                ,@Seller_Image
                                ,1
                                ,@Agree
                              )" />
  
  <ControlDataSource Id="cds_Locations" CommandText="SELECT [LocationID], [City] + ', ' + [State] AS CityState FROM [XMP_Classified_Location] ORDER BY [City] ASC" />
  
  <div class="form-horizontal">
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Name">Seller Name</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Name" CssClass="form-control required-field" MaxLength="150" DataField="Seller_Name" DataType="string" />
        <Validate Target="Seller_Name" CssClass="validate-error" Type="required" Text="*" Message="Name is required." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Address">Seller Address</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Address" CssClass="form-control required-field" MaxLength="150" DataField="Seller_Address" DataType="string" />
        <Validate Target="Seller_Address" CssClass="validate-error" Type="required" Text="*" Message="Address is required." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Location">Location</Label>
      <div class="col-sm-10">
        <DropDownList Id="Seller_Location" CssClass="form-control required-field" Nullable="true" DataField="Seller_Location" DataSourceId="cds_Locations" DataTextField="CityState" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">- Please Select -</ListItem>
        </DropDownList>
        <Validate Target="Seller_Location" CssClass="validate-error" Type="required" Text="*" Message="Location is required." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Phone">Seller Phone</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Phone" CssClass="form-control required-field" MaxLength="50" DataField="Seller_Phone" DataType="string" />
        <Validate Target="Seller_Phone" CssClass="validate-error" Type="required" Text="*" Message="Phone is required." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Email">Seller Email</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Email" Value='[[User:Email]]' CssClass="form-control required-field" MaxLength="100" DataField="Seller_Email" DataType="string" />
        <Validate Target="Seller_Email" CssClass="validate-error" Type="required" Text="*" Message="Email is required." />
        <Validate Target="Seller_Email" CssClass="validate-error" Type="email" Text="*" Message="Email is invalid." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Show_Address_By_Default">&nbsp;</Label>
      <div class="col-sm-10">
        <CheckBox Id="Show_Address_By_Default" DataField="Show_Address_By_Default" DataType="boolean" /> Show Address by Default
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Show_Phone_By_Default">&nbsp;</Label>
      <div class="col-sm-10">
        <CheckBox Id="Show_Phone_By_Default" DataField="Show_Phone_By_Default" DataType="boolean" /> Show Phone by Default
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Image">Seller Image</Label>
      <div class="col-sm-10">
        <rmg:Xile 
          Id="Seller_Image" 
          Nullable="True" 
          DataField="Seller_Image" 
          Dropzone="False"
          AcceptFileTypes="jpg,jpeg,png"
          MaxNumberOfFiles="1"
          MaxFileSize="2097152"
          AutoUpload="True"
          AutoCreateFolder="True"
          FileUploadPath='[[Join("~/Portals/{0}/Classifieds/SellerImages/", [[Portal:ID]])]]'
          ResizeVersions="width=800;height=600;mode=max, sm_:width=400;height=400;mode=max, thm_:width=80;height=80;mode=max"
          UniqueFileName="True"
          UploadMode="Single"
          AddFilesButtonText="Add Image"
          WrapperClass="rmg-singleupload"
          ShowTopCancelButton="False"
          ShowTopCheckBox="False"
          ShowTopProgressBar="False"
          ShowTopDeleteButton="False">
        </rmg:Xile>        
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Agree">&nbsp;</Label>
      <div class="col-sm-10">
        <CheckBox Id="Agree" DataField="Agree" DataType="boolean" /> I Agree to the Terms and Conditions
        <Validate Type="checkbox" CssClass="validate-error" Target="Agree" Text="*" Message="You must agree to the terms and conditions." />
      </div>      
    </div>
    
    <ValidationSummary CssClass="col-sm-offset-2 col-sm-10 alert alert-info" Id="vsXMP_Classified_Seller" />
    
    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <AddButton CssClass="btn btn-primary" Text="Create My Account" Redirect="/Dashboard?f=1" RedirectMethod="Get" />  
        <CancelButton CssClass="btn btn-default" Text="Cancel" Visible="true" Redirect="/Dashboard" RedirectMethod="Get" />
      </div>
    </div>
    
  </div>
  
  <Email To='[[Seller_Email]]' From="hello@aza-z.com" ReplyTo="hello@aza-z.com" BCC="hello@aza-z.com" Format="text" Subject="Your seller account has been created.">
    Congratulations [[Seller_Name]]!
    
    You've successfully created a seller account. 
    
    You can post ads or make changes to your seller profile from your dashboard:
    
    http://aza-z.com/Dashboard
    
    If you have any questions, feel free to reply to this email.

    ~ aza-z.com 
  </Email>
  
  <AddToRoles RoleNames="Sellers" UserId='[[UserID]]'></AddToRoles>
  
  <TextBox ID="UserID" DataField="UserID" DataType="Int32" ReadOnly="True" Visible="False" />
</AddForm>