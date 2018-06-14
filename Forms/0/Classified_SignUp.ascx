<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<%@ Register tagprefix="rmg" namespace="reflect.xile" assembly="reflect.xile" %>
<%@ Register tagprefix="rmg" namespace="reflect.xile" assembly="reflect.xile" %>
<xmod:FormView runat="server">  <AddItemTemplate><xmod:AddForm runat="server">

  <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <title>$1</title>
    
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
      .HeaderLabel_Small {
            color: inherit;
            opacity: 0.7;
            font-weight: normal;
        }
      .info_panel_spacing {
      	margin-top: 10px;
      }
      .fileupload-buttons {
        border-bottom: none !important;
      }
      .checkbox input[type=checkbox] {
       	margin-left: 0px !important; 
        position: relative !important;
      }
      .Categories_Container {
            list-style-type: none;
            margin-left: 0px;
        }

            .Categories_Container ul {
                list-style-type: none;
                margin-left: 25px
            }
    </style>  
  </ScriptBlock> 
  
  <SelectCommand CommandText="SELECT UserID, Email FROM Users WHERE UserID = @UserID">
    <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
  </SelectCommand>

  <SubmitCommand CommandText="INSERT INTO [XMP_Classified_Seller] (
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
                              VALUES (
                                @UserID
                                ,@Seller_Name
                                ,@Seller_Address
                                ,@Seller_Location
                                ,@Seller_Phone
                                ,@Seller_Email
                                ,@Show_Address_By_Default
                                ,@Show_Phone_By_Default
                                ,@Seller_Image
                                ,3
                                ,@Agree
                                )" 
	/>
  
  <ControlDataSource Id="cds_Locations" CommandText="SELECT [LocationID], [City] + ', ' + [State] AS CityState FROM [XMP_Classified_Location] ORDER BY [City] ASC" />
  <div style="text-align: center;"><h2>Seller Sign-Up</h2></div>
  
  <div class="panel panel-primary info_panel_spacing">
    
    
    <div class="panel-heading">
      <h3 class="panel-title">Primary Information</h3>
    </div>
    
    <div class="panel-body">
    
      <div class="form-group">
        <Label For="Seller_Name">Seller Name |<small Class="HeaderLabel_Small"> This name can be your name, company name, or just a fun name like <em>The Ad King</em></small></Label>
        <TextBox Id="Seller_Name" CssClass="form-control required-field" MaxLength="150" DataField="Seller_Name" DataType="string" />
        <Validate Target="Seller_Name" CssClass="validate-error" Type="required" Text="*" Message="Name is required." />
      </div>
      
      <div class="form-group">
        <Label For="Seller_Address">Seller Address |<small Class="HeaderLabel_Small"> This will be displayed on your ads if you choose to make it public.</small></Label>
        <TextBox Id="Seller_Address" CssClass="form-control required-field" MaxLength="150" DataField="Seller_Address" DataType="string" />
        <Validate Target="Seller_Address" CssClass="validate-error" Type="required" Text="*" Message="Address is required." />
      </div>      
    
      <div class="form-group">
        <Label For="Seller_Location">Location |<small Class="HeaderLabel_Small"> This is your default location, which can be changed on each ad.</small></Label>
        <DropDownList Id="Seller_Location" CssClass="form-control required-field" Nullable="true" DataField="Seller_Location" DataSourceId="cds_Locations" DataTextField="CityState" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">- Please Select -</ListItem>
        </DropDownList>
        <Validate Target="Seller_Location" CssClass="validate-error" Type="required" Text="*" Message="Location is required." />
      </div>

      <div class="form-group">
        <Label For="Seller_Image">Seller Image |<small Class="HeaderLabel_Small"> Optional picture/logo to be associated with your seller profile.</em></small></Label>
        <rmg:Xile runat="server" 
                    Id="Seller_Image" 
                    Nullable="True" 
                    DataField="Seller_Image" 
                    Dropzone="False"
                    AcceptFileTypes="jpg,jpeg,png"
                    MaxNumberOfFiles="1"
                    MaxFileSize="2097152"
                    AutoUpload="True"
                    AutoCreateFolder="True"
                    FileUploadPath='<%#Join("~/Portals/{0}/Classifieds/SellerImages/", PortalData("ID"))%>'
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
  
  </div>
  

  <div class="panel panel-default">
    
    <div class="panel-heading">
      <h3 class="panel-title">Contact Information</h3>
    </div>
    
    <div class="panel-body">
    
      <div class="form-group">
        <Label For="Seller_Phone">Seller Phone |<small Class="HeaderLabel_Small"> This is only displayed on your ads if you choose to make it public.</em></small></Label>
        <TextBox Id="Seller_Phone" CssClass="form-control required-field" MaxLength="50" DataField="Seller_Phone" DataType="string" />
        <Validate Target="Seller_Phone" CssClass="validate-error" Type="required" Text="*" Message="Phone is required." />
      </div>

      <div class="form-group">
        <Label For="Seller_Email">Seller Email |<small Class="HeaderLabel_Small"> Inquires will be sent to this email address.</small></Label>
        <TextBox Id="Seller_Email" Value='<%#SelectData("Email")%>' CssClass="form-control required-field" MaxLength="100" DataField="Seller_Email" DataType="string" />
        <Validate Target="Seller_Email" CssClass="validate-error" Type="required" Text="*" Message="Email is required." />
        <Validate Target="Seller_Email" CssClass="validate-error" Type="email" Text="*" Message="Email is invalid." />
      </div>
      
    </div>

	</div>
 

	<div class="panel panel-default">
    
    <div class="panel-heading">
      <h3 class="panel-title">Default Options</h3>
    </div>
    
    <div class="panel-body">
      
      <div class="alert alert-info">
        <p>
          Items that you check below will be visible on your seller profile, but only to authenticated users on the site who have created a user account. 
          You can always change your default options later if desired, as well as override these options on a per/ad basis.
        </p>
      </div>

      <ul class="Categories_Container">
        <li>
            <Label For="Show_Address_By_Default">&nbsp;</Label>
            <CheckBox Id="Show_Address_By_Default" DataField="Show_Address_By_Default" DataType="boolean" /> <strong>Show Address by Default</strong>
        </li>
        <li>
            <Label For="Show_Phone_By_Default">&nbsp;</Label>
            <CheckBox Id="Show_Phone_By_Default" DataField="Show_Phone_By_Default" DataType="boolean" /> <strong>Show Phone by Default</strong>       
        </li>
      </ul>
    </div>
      
    </div>

  <div class="panel panel-warning">
    
    <div class="panel-heading">
      <h3 class="panel-title">Terms and Conditions</h3>
    </div>
    
    <div class="panel-body">
      
      <ul>
        <li>
          <strong>Contact Information:</strong> I understand that including my contact information by utilizing the defaults or inserting them per/ad is my sole responsibility. I am also aware that this contact information will only be seen by registered members on this website unless I include my contact information in the description of my ad, in which case will be visible to unauthenticated visitors to the website. 
        </li>
        <li>
          <strong>Adult Content:</strong> I agree to not post any ad that is adult-related in content, such as anything that would offend or be inappropriate for children under the age of 18.
        </li>
        <li>
          <strong>Animals and Pets:</strong>I also understand that no animals are permitted, such as trade, free, adoption or otherwise. 
        </li>
        <li>
          <strong>Your Responsibility:</strong> I also understand that utilizing the classifieds on this website is my full responsibility in every way, whether posting, viewing, inquiring, etc. I agree that aza-z.com will not be liable in any way for any Ad or communication of any part in relation to an Ad, including, but not limited to, for any errors or omissions in my ad(s) or other ads, or for any loss or damage of any kind incurred as a result of the use of this website.
        </li>
        <li>
          <strong>The Hammer:</strong> I also understand that if I violate any of these guidelines my account may be terminated, IP address may be blocked, or ad may be removed if deemed inappropriate. 
        </li>
      </ul>
      <p>
        By checking the box below, I fully understand and agree to the above noted terms and conditions and I promise to behave myself!
      </p>
      <ul class="Categories_Container">
        <li>
            <CheckBox Id="Agree" DataField="Agree" DataType="boolean" /> <strong>I Agree to the Terms and Conditions</strong>
            <Validate Type="checkbox" CssClass="validate-error" Target="Agree" Text="*" Message="You must agree to the terms and conditions." />
        </li>
      </ul>
    </div>
  </div>
    
  
    
  <ValidationSummary CssClass="col-sm-offset-2 col-sm-10 alert alert-info" Id="vsXMP_Classified_Seller" />
    
  <AddButton CssClass="btn btn-primary" Text="Create Seller" Redirect="/Dashboard?f=1" RedirectMethod="Get" />  
  <CancelButton CssClass="btn btn-default" Text="Cancel" Visible="true" Redirect="/Dashboard" RedirectMethod="Get" />
  
  <Email To='[[Seller_Email]]' From="jeff@hughesco.org" ReplyTo="jeff@hughesco.org" Subject="Your Seller account has been created." Format="HTML">
		<body style="margin:0; padding:0; background-color:#F2F2F2;">    
    <center>
		<table width="640" cellpadding="0" cellspacing="0" border="0" class="wrapper" bgcolor="#FFFFFF">
			<tr>
				<td height="10" style="font-size:10px; line-height:10px;">&nbsp;</td>
			</tr>
			<tr>
				<td align="center" valign="top">

					<table width="600" cellpadding="0" cellspacing="0" border="0" class="container">
                        <tr>
							<td align="center" valign="top">
								<img src="http:acich.org/portals/0/classifieds/Images/Banner_01_Classifieds.jpg" width="100%" height="auto" style="margin:0; padding:0; border:none; display:block;" border="0" alt="ACI Chapter Central Logo" /> 
							</td>
						</tr>
						<tr>
                            <td height="10" style="font-size:10px; line-height:10px;">&nbsp;</td>
                        </tr>
                        <tr>
							<td align="center" valign="top" style="font-family: Arial, sans-serif; font-size:18px; font-weight:bold;">
								Congratulations [[Seller_Name]]
							</td>
						</tr>
						<tr>
                            <td height="10" style="font-size:10px; line-height:10px;">&nbsp;</td>
                        </tr>
                        <tr>
							<td align="left" valign="top" style="font-family: Arial, sans-serif; font-size:12px; font-weight:bold;">
								<p> You can post ads or make changes to your seller profile from your dashboard: <br /><br />
    
                                    http://acich.org/Dashboard <br /><br />
    
                                    If you have any questions, feel free to reply to this email. <br /><br />

                                    ~ acich.org 
                                </p>
							</td>
						</tr>
                        <tr>
                            <td height="10" style="font-size:10px; line-height:10px;">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="center" valign="middle" height="44" style="font-family: Arial, sans-serif; font-size:14px; font-weight:bold;">
    	                        <a href="http://acich.org/Dashboard/Post-Ad" target="_blank" style="font-family: Arial, sans-serif; color:#505050; display: inline-block; text-decoration: none; line-height:38px; width:160px; font-weight:bold; border: 3px solid #99CC99; border-radius: 10px;">Post Ad Now!</a>
                            </td>
                        </tr>
					</table>

				</td>
			</tr>
			<tr>
				<td height="10" style="font-size:10px; line-height:10px;">&nbsp;</td>
			</tr>
		</table>
	</center>
    </body>
  </Email>
  
  <AddToRoles RoleNames="Sellers" UserId='[[UserID]]'></AddToRoles>

  
  <TextBox ID="UserID" DataField="UserID" DataType="Int32" ReadOnly="True" Visible="False" />
  
</xmod:AddForm></AddItemTemplate><EditItemTemplate><xmod:EditForm runat="server">

  <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <title>$1</title>
    
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
      .HeaderLabel_Small {
            color: inherit;
            opacity: 0.7;
            font-weight: normal;
        }
      .info_panel_spacing {
      	margin-top: 10px;
      }
      .fileupload-buttons {
        border-bottom: none !important;
      }
      .checkbox input[type=checkbox] {
       	margin-left: 0px !important; 
        position: relative !important;
      }
      .Categories_Container {
            list-style-type: none;
            margin-left: 0px;
        }

            .Categories_Container ul {
                list-style-type: none;
                margin-left: 25px
            }
    </style>  
  </ScriptBlock>


  <SelectCommand CommandText="SELECT @CurrentUser AS [UpdatedBy], [Seller_Name], [Seller_Address], [Seller_Location], [Seller_Phone], [Seller_Email], [Show_Address_By_Default], [Show_Phone_By_Default], [Seller_Image], [SellerID] FROM XMP_Classified_Seller WHERE [UserID]=@CurrentUser">
    <Parameter Name="CurrentUser" Value='<%#UserData("ID")%>' DataType="int32" />
  </SelectCommand>

  <SubmitCommand CommandText="UPDATE [XMP_Classified_Seller] SET [UpdatedBy]=@UpdatedBy, [Date_Updated]=getdate(), [Seller_Name]=@Seller_Name, [Seller_Address]=@Seller_Address, [Seller_Location]=@Seller_Location, [Seller_Phone]=@Seller_Phone, [Seller_Email]=@Seller_Email, [Show_Address_By_Default]=@Show_Address_By_Default, [Show_Phone_By_Default]=@Show_Phone_By_Default, [Seller_Image]=@Seller_Image WHERE [SellerID]=@SellerID" />
  
  <ControlDataSource Id="cds_Locations" CommandText="SELECT [LocationID], [City] + ', ' + [State] AS CityState FROM [XMP_Classified_Location] ORDER BY [City] ASC" />
  
  <div class="form-horizontal">
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Name">Seller Name</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Name" CssClass="form-control required-field" Width="250" MaxLength="150" DataField="Seller_Name" DataType="string" />
        <Validate Target="Seller_Name" CssClass="validate-error" Type="required" Text="*" Message="Name is required." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Address">Seller Address</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Address" CssClass="form-control required-field" Width="250" MaxLength="150" DataField="Seller_Address" DataType="string" />
        <Validate Target="Seller_Address" CssClass="validate-error" Type="required" Text="*" Message="Address is required." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Location">Location</Label>
      <div class="col-sm-10">
        <DropDownList Id="Seller_Location" CssClass="form-control required-field" Width="250" Nullable="true" DataField="Seller_Location" DataSourceId="cds_Locations" DataTextField="CityState" DataValueField="LocationID" AppendDataBoundItems="true" DataType="int32">
          <ListItem Value="">- Please Select -</ListItem>
          <Validate Target="Seller_Location" CssClass="validate-error" Type="required" Text="*" Message="Location is required." />
        </DropDownList>
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Phone">Seller Phone</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Phone" CssClass="form-control required-field" Width="250" MaxLength="50" DataField="Seller_Phone" DataType="string" />
        <Validate Target="Seller_Phone" CssClass="validate-error" Type="required" Text="*" Message="Phone is required." />
      </div>      
    </div>
    
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Seller_Email">Seller Email</Label>
      <div class="col-sm-10">
        <TextBox Id="Seller_Email" CssClass="form-control required-field" Width="250" MaxLength="100" DataField="Seller_Email" DataType="string" />
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
        <rmg:Xile runat="server" 
                 Id="Seller_Image" 
                 Nullable="True" 
                 DataField="Seller_Image" 
                 Dropzone="False"
                 AcceptFileTypes="jpg,jpeg,png"
                 MaxNumberOfFiles="1"
                 MaxFileSize="2097152"
                 AutoUpload="True"
                 AutoCreateFolder="True"
                 FileUploadPath='<%#Join("~/Portals/{0}/Classifieds/SellerImages/", PortalData("ID"))%>'
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
        <UpdateButton CssClass="btn btn-primary" Text="Save Changes" />  
        <CancelButton CssClass="btn btn-default" Text="Cancel" Visible="true" Redirect="/Dashboard" RedirectMethod="Get" />
      </div>
    </div>
    
  </div>
  
  <TextBox Visible="False" Id="SellerID" DataField="SellerID" DataType="int32" />
  <TextBox Id="UpdatedBy" Nullable="True" DataField="UpdatedBy" DataType="int32" Visible="False" />
</xmod:EditForm></EditItemTemplate>

<EditSuccessTemplate><xmod:EditSuccess runat="server">
  <ItemTemplate>
    <div class="alert alert-success success-message text-center">
      <h1>Success!</h1>
      <p>Your changes have been saved.</p>
      <p>
        <xmod:ContinueButton runat="server" CssClass="btn btn-default" Text="Reload Form" />        
      </p>
    </div>    
  </ItemTemplate>
</xmod:EditSuccess></EditSuccessTemplate></xmod:FormView>
