<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="SellerCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    .pager-active {
      color: #fff !important;
      background-color: #337ab7 !important;
      border-color: #337ab7 !important;
    }
    .top10 {
     	margin-top: 10px; 
    }
  </style>
</xmod:ScriptBlock>

<xmod:Template runat="server" UsePaging="True" Ajax="True" AddRoles="Administrators" EditRoles="Administrators" DeleteRoles="Administrators" DetailRoles="Administrators">
  <ListDataSource CommandText="SELECT * FROM vw_XMP_Admin_Seller"/>
  
  <DetailDataSource CommandText="SELECT * FROM vw_XMP_Admin_Seller_Detail WHERE [SellerID] = @SellerID">
    <Parameter Name="SellerID" />
  </DetailDataSource>  

  <CustomCommands>
    <DataCommand CommandName="ToggleDelBan" CommandText="XMP_Classified_Flag_Toggle" CommandType="StoredProcedure">
      <Parameter Name="ID1" />
      <Parameter Name="ID2" />
      <Parameter Name="FlagType" />
    </DataCommand>
    <DataCommand CommandName="DeleteSeller" CommandText="DELETE FROM XMP_Classified_Seller WHERE [SellerID] = @SellerID">
      <Parameter Name="SellerID" />
    </DataCommand>
    
  </CustomCommands>
  
  <Pager 
    PageSize="5" 
    ShowTopPager="False" 
    ShowBottomPager="True" 
    ShowFirstLast="True" 
    FirstPageCaption="First" 
    LastPageCaption="Last" 
    ShowPrevNext="True" 
    NextPageCaption="&raquo;" 
    PrevPageCaption="&laquo;"
    CurrentPageCssClass="pager-active">
    
    <ul class="pagination">
      <li>{pager}</li>
    </ul>

  </Pager>
  
  <SearchSort 
    FilterExpression="Seller_Name LIKE '%{0}%'"
    SearchLabelText="Search For:" SearchButtonText="GO" 
    SortFieldNames="Seller_Name,CityState,Seller_Level,Date_Created"
    SortFieldLabels="Name,Location,Level,Created"
    SearchBoxCssClass="form-control"
    SearchButtonCssClass="btn btn-default"
    SortButtonText="Go"
    SortButtonCssClass="btn btn-default"
    SortFieldListCssClass="form-control">
    
    <div class="row">
      <div class="col-sm-6 top10">
        <div class="input-group">
          {SearchBox}
          <span class="input-group-btn">
            {SearchButton}
          </span>
        </div>
      </div>
      <div class="col-sm-6 top10">
      	<div class="form-inline">
          <div class="form-group">
            <label class="control-label">Sort</label>
            {SortFieldList}
            {SortButton}
          </div>
          <div class="form-group">
            <div class="checkbox">
              <label>
                {ReverseSort} Reverse
              </label>
            </div>
          </div>
        </div> 	
      </div>
    </div><br/>
  </SearchSort>

  <HeaderTemplate>
    <table class="table table-bordered table-striped">
      <thead>
        <tr>
          <th>ID</th>
          <th>User</th>
          <th>Created</th>
          <th>Updated</th>
          <th>Updated By</th>
          <th>Name</th>
          <th>Location</th>
          <th>Level</th>
          <th>Banned</th>
          <th>Seller Deleted</th>
          <th>User Deleted</th>
          <th>User Authorized</th>
          <th width="150">&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        <div id="acoolbox" class="alert alert-info">
          This is a box.
        </div>


        <script>
          $(document).ready(function() {
            var a = $("#acoolbox")
            $(a).click(function() {
              $(a).hide();
            });
          });
        </script>
  </HeaderTemplate>
    
  <ItemTemplate>
        <tr>
          <td><%#Eval("Values")("SellerID")%></td>
          <td style="white-space:nowrap;">
          	<div class="btn-group" role="group">
              <xmod:DetailLink runat="server" CssClass="btn btn-xs btn-info" Text='<%#Eval("Values")("Username")%>'>
                <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
              </xmod:DetailLink>
            </div>
          </td>
          <td><%#Eval("Values")("Date_Created")%></td>
          <td><%#Eval("Values")("Date_Updated")%></td>
          <td><%#Eval("Values")("UpdatedByUsername")%></td>
          <td><%#Eval("Values")("Seller_Name")%></td>
          <td><%#Eval("Values")("CityState")%></td>
          <td><%#Eval("Values")("Level_Name")%></td>
          <td><%#Eval("Values")("Banned")%></td>
          <td><%#Eval("Values")("SellerDeleted")%></td>
          <td><%#Eval("Values")("UserDeleted")%></td>
          <td><%#Eval("Values")("UserAuthorized")%></td>
          <td style="white-space:nowrap;">
            <div class="btn-group" role="group">                                                
             	<xmod:EditButton runat="server" Text="Edit" CssClass="btn btn-xs btn-success">
                <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
              </xmod:EditButton>
            </div>
            <xmod:Select runat="server" Mode="Standard">
							<Case CompareType="Role" Operator="=" Expression="Administrators">
                <div class="btn-group" role="group">
                  <button type="button" class="btn btn-default btn-xs ">More</button>
                  <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="caret"></span>
                    <span class="sr-only">Toggle Dropdown</span>
                  </button>
                  <ul class="dropdown-menu" role="group">
                    <li>
                      <xmod:CommandLink runat="server" Text="Soft Delete" CssClass="btn btn-xs btn-default">
                        <Command Name="ToggleDelBan" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("SellerID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="soft" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </li>
                    <li>
                      <xmod:CommandLink runat="server" Text="Ban Seller" CssClass="btn btn-xs btn-default">
                        <Command Name="ToggleDelBan" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("SellerID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="ban" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </li>
                    <li>
                      <xmod:CommandLink runat="server" Text="Delete" CssClass="btn btn-xs btn-danger" OnClientClick="return confirm('Are you sure, this is Permanent!?');">
                        <Command Name="DeleteSeller" Type="Custom">
                          <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' DataType="Int32" />
                        </Command>
                      </xmod:CommandLink>
                    </li>
                    <li>
                      <xmod:Redirect runat="server" Display="LinkButton" Method="Post" CssClass="btn btn-xs btn-info" Target="/Classifieds-Admin/Sellers/Post-Ad" Text="Post Ad">
                        <Field Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
                      </xmod:Redirect>
                    </li>
                  </ul>
                </div>
							</Case>
            </xmod:Select>
         </td>
        </tr>
  </ItemTemplate>

  <AlternatingItemTemplate>
        <tr style="background-color:#e8e8e8;">
          <td><%#Eval("Values")("SellerID")%></td>
          <td style="white-space:nowrap;">
          	<div class="btn-group" role="group">
              <xmod:DetailLink runat="server" CssClass="btn btn-xs btn-info" Text='<%#Eval("Values")("Username")%>'>
                <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
              </xmod:DetailLink>
            </div>
          </td>
          <td><%#Eval("Values")("Date_Created")%></td>
          <td><%#Eval("Values")("Date_Updated")%></td>
          <td><%#Eval("Values")("UpdatedByUsername")%></td>
          <td><%#Eval("Values")("Seller_Name")%></td>
          <td><%#Eval("Values")("CityState")%></td>
          <td><%#Eval("Values")("Level_Name")%></td>
          <td><%#Eval("Values")("Banned")%></td>
          <td><%#Eval("Values")("SellerDeleted")%></td>
          <td><%#Eval("Values")("UserDeleted")%></td>
          <td><%#Eval("Values")("UserAuthorized")%></td>
          <td style="white-space:nowrap;">
            <div class="btn-group" role="group">                                                
             	<xmod:EditButton runat="server" Text="Edit" CssClass="btn btn-xs btn-success">
                <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
              </xmod:EditButton>
            </div>
            <xmod:Select runat="server" Mode="Standard">
							<Case CompareType="Role" Operator="=" Expression="Administrators">
                <div class="btn-group" role="group">
                  <button type="button" class="btn btn-default btn-xs">More</button>
                  <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="caret"></span>
                    <span class="sr-only">Toggle Dropdown</span>
                  </button>
                  <ul class="dropdown-menu" role="group">
                    <li>
                      <xmod:CommandLink runat="server" Text="Soft Delete" CssClass="btn btn-xs btn-default">
                        <Command Name="ToggleDelBan" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("SellerID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="soft" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </li>
                    <li>
                      <xmod:CommandLink runat="server" Text="Ban Seller" CssClass="btn btn-xs btn-default">
                        <Command Name="ToggleDelBan" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("SellerID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="ban" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </li>
                    <li>
                      <xmod:CommandLink runat="server" Text="Delete" CssClass="btn btn-xs btn-danger" OnClientClick="return confirm('Are you sure, this is Permanent!?');">
                        <Command Name="DeleteSeller" Type="Custom">
                          <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' DataType="Int32" />
                        </Command>
                      </xmod:CommandLink>
                    </li>
                    <li>
                      <xmod:Redirect runat="server" Display="LinkButton" Method="Post" CssClass="btn btn-xs btn-info" Target="/Classifieds-Admin/Sellers/Post-Ad" Text="Post Ad">
                        <Field Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
                      </xmod:Redirect>
                    </li>                    

                  </ul>
                </div>
							</Case>
              <Else>
              </Else>
            </xmod:Select>
         </td>
        </tr>
  </AlternatingItemTemplate>
    
  <FooterTemplate>
      </tbody>
    </table>
	</FooterTemplate>

	<DetailTemplate>
    
    <div class="media">
      <a class="media-left" href="#">
        <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
        	<img class="img-thumbnail" src="/Portals/<%#PortalData("ID")%>/Classifieds/SellerImages/thm_<%#Eval("Values")("Seller_Image")%>" style="max-width: 100px" alt="<%#Eval("Values")("Seller_Name")%>">
        </xmod:IfNotEmpty>
        <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
        	<img class="img-thumbnail" src="/Portals/<%#PortalData("ID")%>/Classifieds/SellerImages/NoImage_Turtle.png" style="max-width: 100px" alt="NoSellerImage">
        </xmod:IfEmpty>
      </a>
      <div class="media-body">
        <h4 class="media-heading"><%#Eval("Values")("Seller_Name")%></h4>
        <h5>SellerID: <%#Eval("Values")("SellerID")%></h5>
        <h5>UserID: <%#Eval("Values")("Username")%> (<%#Eval("Values")("UserID")%>)</h5>
        <h5>Level: <%#Eval("Values")("Level_Name")%> (<%#Eval("Values")("Seller_Level")%>)</h5>
        <h5>Approved Ads: <%#Eval("Values")("Approved_Ads")%></h5>
      </div>
    </div>
    
    <h4>Seller Profile</h4>
    
    <table class="table table-bordered table-striped">
      <thead>
      	<tr>
          <th>Address</th>
          <th>Location</th>
          <th>Phone</th>
          <th>Email</th>
          <th>Show Address</th>
          <th>Show Phone</th>
          <th>Created</th>
          <th>Updated</th>
          <th>Updated By</th>
          <th>Banned</th>
          <th>Deleted</th>
        </tr>
      </thead>
      <tbody>
      	<tr>
          <td><%#Eval("Values")("Seller_Address")%></td>
          <td><%#Eval("Values")("CityState")%> (<%#Eval("Values")("Seller_Location")%>)</td>
          <td><%#Eval("Values")("Seller_Phone")%></td>
          <td><%#Eval("Values")("Seller_Email")%></td>
          <td><%#Eval("Values")("ShowAddress")%></td>
          <td><%#Eval("Values")("ShowPhone")%></td>
          <td><%#Eval("Values")("Date_Created")%></td>
          <td><%#Eval("Values")("Date_Updated")%></td>
          <td><%#Eval("Values")("UpdatedByUsername")%> (<%#Eval("Values")("UpdatedBy")%>)</td>
          <td><%#Eval("Values")("Banned")%></td>
          <td><%#Eval("Values")("SellerDeleted")%></td>         
        </tr>
      </tbody>

    </table>

    <xmod:ReturnLink runat="server" CssClass="btn btn-default" Text="&lt;&lt; Go Back" />
    <div class="btn-group" role="group">                                                
      <xmod:EditButton runat="server" Text="Edit" CssClass="btn btn-success">
        <Parameter Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
      </xmod:EditButton>
    </div>
    
		<hr />
    
  </DetailTemplate>

</xmod:Template>

<xmod:AddLink runat="server" CssClass="btn btn-primary" Text="New Seller" /></xmod:masterview>