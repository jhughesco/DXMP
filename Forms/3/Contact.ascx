<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server">
  <ScriptBlock ScriptId="CustomCSS" BlockType="HeadScript" RegisterOnce="true">
    <style type="text/css">
      .contact-form {
        max-width: 800px;
        margin: auto;
      }
      .validate-error {
        position: absolute;
        top: 0;
        left: 0;
        color: red;
      }
      .contact-radio input {
        margin-right: 5px;
      }
      .required-field {
        border-left: 1px solid red;
      }

    </style>
  </ScriptBlock>

  <div class="form-horizontal contact-form" role="form">
    <h3 class="text-center">
    Contact Me
  </h3>
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Name">
        Name
      </Label>
      <div class="col-sm-10">

        <TextBox Id="Name" Value='<%#UserData("Displayname")%>' CssClass="form-control required-field" MaxLength="50" DataField="Name">
        </TextBox>
        <Validate Target="Name" CssClass="validate-error" Type="required" Text="*" Message="Please Enter Your Name">
        </Validate>
      </div>
    </div>
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Email">
        Email
      </Label>
      <div class="col-sm-10">
        <TextBox Id="Email" Value='<%#UserData("Email")%>' CssClass="form-control required-field" MaxLength="50" DataField="Email">
        </TextBox>
        <Validate Target="Email" CssClass="validate-error" Type="required" Text="*" Message="Please Enter an Email Address">
        </Validate>

        <Validate Target="Email" CssClass="validate-error" Type="email" Text="*" Message="Please Enter a Valid Email Address">
        </Validate>
      </div>
    </div>
    <div class="form-group">
      <Label CssClass="col-sm-2 control-label" For="Message">
        Message
      </Label>
      <div class="col-sm-10">
        <TextArea Id="Message" CssClass="form-control required-field" DataField="Message">
        </TextArea>
        <Validate Target="Message" CssClass="validate-error" Type="required" Text="*" Message="Please Enter a Message">
        </Validate>
      </div>
    </div>

  </div>

  <ValidationSummary CssClass="alert alert-info" Id="ContactValidation" DisplayMode="BulletList" HeaderText="Please Correct the Following Errors:" />

  <div class="form-group">
    <div class="text-right">
      <AddButton type="submit" CssClass="btn btn-primary" Text="Send Message" />
      <CancelButton Text="Cancel" style="margin-left: 12px;" Visible="false" />
    </div>
  </div>

  </div>
<Email To="jeff@hughesco.org" CC="" BCC="" From="jeff@hughesco.org" ReplyTo="[[Email]]" Format="text" Subject="[[Name]] sent a message from HughesCo.org">
  You received a message from [[Name]].

  Name: [[Name]]
  Email: [[Email]]
  Message: [[Message]]

</Email>
</xmod:AddForm></AddItemTemplate>

<AddSuccessTemplate><xmod:AddSuccess runat="server">
  <ItemTemplate>
    <xmod:ScriptBlock runat="server" ScriptId="SuccessCSS" BlockType="HeadScript" RegisterOnce="true">
      <style type="text/css">
        .success-message {
          max-width: 800px;
          margin: auto;
        }




      </style>
    </xmod:ScriptBlock>

    <div class="alert alert-success success-message">
      <h4 class="alert-heading text-center">
        Thank You!
      </h4>
      <p>
        Your inquiry is on it's way to me, I will reply ASAP to discuss your needs.
      </p>
      <p class="mb-0">
        Thank you and have a wonderful day!  
      </p>
    </div>

  </ItemTemplate>
</xmod:AddSuccess></AddSuccessTemplate><EditItemTemplate><xmod:EditForm runat="server">
  <SelectCommand CommandText="" />
  <Submitcommand CommandText="" />

  <Label For="txtFieldOne" Text="Field One:" /> 
  <TextBox Id="txtFieldOne" DataField="FieldOne" DataType="string" /> <br />

  <UpdateButton Text="Update" /> &nbsp;<CancelButton Text="Cancel"/>
  <Textbox Id="txtKey" DataField="KeyFieldName" DataType="int32" Visible="False" />
</xmod:EditForm></EditItemTemplate></xmod:FormView>
