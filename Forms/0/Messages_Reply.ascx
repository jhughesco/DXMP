<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.FormBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls.Form" TagPrefix="xmod" %>
<xmod:FormView runat="server"><AddItemTemplate><xmod:AddForm runat="server">
  
  <ScriptBlock ScriptId="SellerContact" BlockType="HeadScript" RegisterOnce="True">
    <style type="text/css">
      html { display: none; }
      body { background: #f1f1f1 !important; }
      
      .form-control {
        margin-bottom:0px !important;
        background: white !important;
        box-shadow: none !important;
      }      
      
    </style>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css?cdv=23" media="all" type="text/css" rel="stylesheet"/>
  </ScriptBlock>
  
  <SelectCommand CommandText="
                SELECT
                   c.[ConversationID]
                  ,a.[AdID]
                  ,a.[Ad_Title]
                  ,@UserID AS [Author]
                  ,@UserIP AS [AuthorIP]
                  ,CASE WHEN(@UserID = c.[Initiator]) 
                        THEN CAST(u.Username AS nvarchar(150))
                        ELSE CAST(s.[Seller_Name] AS nvarchar(150))
                        END 'From'
                  ,CASE WHEN(@UserID = c.[Initiator])
                        THEN CAST(s.[Seller_Email] AS nvarchar(150))
                        ELSE CAST(u.[Email] AS nvarchar(150))		  
                        END 'To'
                  		  
                FROM [XMP_Classified_Conversation] c
                INNER JOIN [XMP_Classified_Ad] a ON c.[AdID] = a.[AdID]
                INNER JOIN [XMP_Classified_Seller] s ON a.[SellerID] = s.[SellerID]
                INNER JOIN [Users] u ON c.[Initiator] = u.[UserID]
                WHERE c.[ConversationID] = @ConversationID
                AND (c.[Initiator] = @UserID OR s.[UserID] = @UserID)">
    
    <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
    <Parameter Name="UserIP" Value='<%#RequestData("HostAddress")%>' DataType="String" />
    <Parameter Name="ConversationID" Value='<%#UrlData("ConversationID")%>' DataType="Int32" />    
  </SelectCommand>
  
   
  <SubmitCommand CommandText="XMP_Classified_Messages_Reply" CommandType="StoredProcedure">
    <Parameter Name="Author" />
    <Parameter Name="AuthorIP" />
    <Parameter Name="Message" />
    <Parameter Name="ConversationID" />
  </SubmitCommand>
  
  
  <TextArea Id="Message" MaxLength="500" DataField="Message" CssClass="form-control" Placeholder="Type your reply here..." Rows="3" autocomplete="off" DataType="String" />
  <Validate Type="required" CssClass="validate-error" Target="Message" />          
  <div class="text-right">
    <AddLink CssClass="send-msg bt btn-primary btn-xs" Text="Send" Redirect="/Dashboard/Messages/Reply?ConversationID=[[ConversationID]]&submit=1" RedirectMethod="Get" />
  </div>

    
  <Email To="[[To]]" From="hello@aza-z.com" Format="text" Subject="Re: [[Ad_Title]]">
    You've received a response regarding: [[Ad_Title]]

    From: [[From]]
    
    Message: 
    
    [[Message]]

    ----------------------------
    Unless the inquirer has provided their email address or other contact information within this message, 
    you can reply directly from your seller's dashboard: http://aza-z.com/Dashboard
    
    Messages within your dashboard will automatically be removed after the associated ad is deleted.
  </Email>
  
  
  <TextBox Id="Ad_Title" MaxLength="200" DataField="Ad_Title" DataType="String" Visible="False" />
  <TextBox Id="To" DataField="To" DataType="String" Visible="False" />
  <TextBox Id="From" DataField="From" DataType="String" Visible="False" />
  <TextBox Id="Author" DataField="Author" DataType="Int32" Visible="False" />
  <TextBox Id="AuthorIP" DataField="AuthorIP" DataType="String" Visible="False" Nullable="True" />
  <TextBox Id="ConversationID" DataField="ConversationID" DataType="Int32" Visible="False" />
  
  <script type="text/javascript">
    
    $(document).ready(function() {
      
      $('html').fadeIn('fast');
      
      if ("<%#UrlData("submit")%>" === "1") {
        parent.GetConversation(true); 
      }
    
    });
  </script>
  
</xmod:AddForm></AddItemTemplate><EditItemTemplate><xmod:EditForm runat="server">
  <SelectCommand CommandText="" />
  <Submitcommand CommandText="" />

  <Label For="txtFieldOne" Text="Field One:" /> 
  <TextBox Id="txtFieldOne" DataField="FieldOne" DataType="string" /> <br />

  <UpdateButton Text="Update" /> &nbsp;<CancelButton Text="Cancel"/>
  <Textbox Id="txtKey" DataField="KeyFieldName" DataType="int32" Visible="False" />
</xmod:EditForm></EditItemTemplate></xmod:FormView>
