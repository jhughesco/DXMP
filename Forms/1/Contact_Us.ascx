<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server">
  <Label CssClass="" For="Department">Department</Label>
  <DropDownList Id="Department" DataField="Department">
    <ListItem Value="">
      - Please Select -
    </ListItem>
    <ListItem Value="Support">
      Support
    </ListItem>
    <ListItem Value="Report Abuse">
      Report Abuse
    </ListItem>
    <ListItem Value="General">
      General
    </ListItem>
  </DropDownList>
  <Validate Target="Department" CssClass="" Type="required" Text="*" Message="Please select a department." />

  <Label CssClass="" For="Name">Name</Label>
  <TextBox Id="Name" MaxLength="50" DataField="Name" />
  <Validate Target="Name" CssClass="" Type="required" Text="*" Message="Please enter your name." />

  <Label CssClass="" For="Email">Email</Label>
  <TextBox Id="Email" MaxLength="50" DataField="Email" />
  <Validate Target="Email" CssClass="" Type="required" Text="*" Message="Please enter an email address." />
  <Validate Target="Email" CssClass="" Type="email" Text="*" Message="Please enter a valid email address." />

  <Label CssClass="" For="Phone">Phone</Label>
  <TextBox Id="Phone" MaxLength="20" DataField="Phone" />

  <Label CssClass="" For="Message">Message</Label>
  <TextArea Id="Message" DataField="Message" />
  <Validate Target="Message" CssClass="" Type="required" Text="*" Message="Please enter a message." />

  <Label CssClass="xmp-form-label" For="ContactMethod">Please select a preferred contact method:</Label>
  <RadioButtonList Id="ContactMethod" DataField="ContactMethod" RepeatDirection="Vertical" RepeatLayout="Table" SelectedItemsSeparator="|">
    <ListItem Value="Email">
      Email
    </ListItem>
    <ListItem Value="Phone">
      Phone
    </ListItem>
    <ListItem Value="Either">
      Either
    </ListItem>
    <ListItem Value="None">
      None
    </ListItem>
  </RadioButtonList>

  <ValidationSummary CssClass="" Id="ContactValidation" DisplayMode="BulletList" HeaderText="Please correct the following errors:" />

  <AddButton Text="Send Message" />
  <CancelButton Text="Cancel" style="margin-left: 12px;" Visible="false" />

  <Email To="admin@hughesco.org" CC="" BCC="" From="admin@hughesco.org" ReplyTo="[[Email]]" Format="text" Subject="[[Name]] has sent you a message">
    You received a message from [[Name]].

    Department: [[Department]]
    Name: [[Name]]
    Email: [[Email]]
    Phone: [[Phone]]
    Contact Method: [[ContactMethod]]
    Message: [[Message]]

    Thank you!
  </Email>
</xmod:AddForm></AddItemTemplate>

<EditItemTemplate><xmod:EditForm runat="server">
  <ScriptBlock BlockType="HeadScript" RegisterOnce="True" ScriptId="KBXM_Theme_none_Contact_Us">
    <link rel="stylesheet" type="text/css" href="/DesktopModules/XModPro/styles/none" />
  </ScriptBlock>

  <ScriptBlock BlockType="HeadScript" RegisterOnce="True" ScriptId="KBXM_Style_Contact_Us">
    <style type="text/css">
      .xmp-Contact_Us { padding: 10px 5px 5px 5px; }
      .xmp-Contact_Us .xmp-form-row { margin: 3px; padding: 3px; clear:left;}
      .xmp-Contact_Us label.xmp-form-label, .xmp-Contact_Us span.xmp-form-label{ display:block; float:left; width: 120px;text-align: left; margin-right: 5px; }
      .xmp-Contact_Us .xmp-button { margin-right: 5px; }
    </style>
  </ScriptBlock>


<div class="xmp-form xmp-Contact_Us">
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Department">Department</Label><DropDownList Id="Department" DataField="Department"><ListItem Value="">- Please Select -</ListItem><ListItem Value="Support">Support</ListItem><ListItem Value="Report Abuse">Report Abuse</ListItem><ListItem Value="General">General</ListItem></DropDownList><Validate Target="Department" CssClass="xmp-validation" Type="required" Text="*" Message="Please select a department."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Name">Name</Label><TextBox Id="Name" MaxLength="50" DataField="Name"></TextBox><Validate Target="Name" CssClass="xmp-validation" Type="required" Text="*" Message="Please enter your name."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Email">Email</Label><TextBox Id="Email" MaxLength="50" DataField="Email"></TextBox><Validate Target="Email" CssClass="xmp-validation" Type="required" Text="*" Message="Please enter an email address."></Validate><Validate Target="Email" CssClass="xmp-validation" Type="email" Text="*" Message="Please enter a valid email address."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Phone">Phone</Label><TextBox Id="Phone" MaxLength="20" DataField="Phone"></TextBox></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="Message">Message</Label><TextArea Id="Message" DataField="Message"></TextArea><Validate Target="Message" CssClass="xmp-validation" Type="required" Text="*" Message="Please enter a message."></Validate></div>
    <div class="xmp-form-row"><Label CssClass="xmp-form-label" For="ContactMethod">Please select a preferred contact method:</Label><RadioButtonList Id="ContactMethod" DataField="ContactMethod" RepeatDirection="Vertical" RepeatLayout="Table" SelectedItemsSeparator="|"><ListItem Value="Email">Email</ListItem><ListItem Value="Phone">Phone</ListItem><ListItem Value="Either">Either</ListItem><ListItem Value="None">None</ListItem></RadioButtonList></div><ValidationSummary CssClass="xmp-validation" Id="ContactValidation" DisplayMode="BulletList" HeaderText="Please correct the following errors:"></ValidationSummary><div class="xmp-form-row"><Label class="xmp-form-label">&nbsp;</Label><UpdateButton Text="Update"></UpdateButton><CancelButton Text="Cancel" style="margin-left: 12px;" Visible="false"></CancelButton></div>
  </div></xmod:EditForm></EditItemTemplate>

</xmod:FormView>
