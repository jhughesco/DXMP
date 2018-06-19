<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server"  ScriptId="SellerCSS" BlockType="HeadScript" RegisterOnce="False">

  <style type="text/css">
    .pager-active {
      color: #fff !important;
      background-color: #337ab7 !important;
      border-color: #337ab7 !important;
    }
    .nowrap {
      white-space: nowrap;
    }
    .button-spacing {
    	padding: 2.5px 0 2.5px 0 !important;
    }
    .alt-row {
      background-color: #e8e8e8;
    }
    
    .detail_title {
      text-align: center;
    
    }
    .gridfix {
      float:left !important;
    
    }
    .hide {
      display: none; 
    }
    
    .red hr {
      height: 2px;
      background-color:#FF0000;
      width: 75%;
    }
    
    .grn hr {
      height: 2px;
      background-color:#33CC33;
      width: 75%;
    }
    
    .width_adj {
      width: 75%; 
    }
    
    .status-row { border-bottom: 15px solid #ebebeb; }
    .summary-wrapper { margin-top:50px; }
    .summary-wrapper .title-wrapper { text-align:center; }
    .summary-wrapper .title-wrapper h1 { margin: 0px; }
    .summary-wrapper .title-wrapper h2 { margin: 0px; }
    .summary-wrapper .title-wrapper h3 { margin: 0px; }
    .summary-wrapper .title-wrapper h4 { margin: 0px; }
    .summary-wrapper .title-wrapper h5 { margin: 0px; }
    .summary-wrapper .image-wrapper { text-align:center; margin-top: 20px; }
    .summary-wrapper .price-wrapper { text-align:center; font-size: 20px; color:darkgreen; }
    .summary-wrapper .contact-wrapper { text-align:center; margin-top: 10px; font-size: 16px; color: #555; }
    .summary-wrapper .adsummary-wrapper { max-width: 600px; margin: 20px auto; }
    .summary-wrapper .adsummary-wrapper p { font-size:16px; }
    .summary-wrapper .adinfo-wrapper { max-width: 600px; margin: 15px auto; }
    .summary-wrapper .adinfo-wrapper ul { margin-left: 0px !important; }
    .summary-wrapper .addetails-wrapper p { font-size:16px; }
    .summary-wrapper .seller-wrapper { margin-top: 50px; }
    .seller_address { margin-left: 10px; }
    .addetails_cards { padding: 5px; border: 2px solid #505050; }
    
  </style>
  
  <link href="/js/bootstrap-toggle/css/bootstrap-toggle.min.css" rel="stylesheet">
	<script src="/js/bootstrap-toggle/js/bootstrap-toggle.min.js">
    $(function() {
      $('#toggle-one').bootstrapToggle();
    })
  </script>
  
</xmod:ScriptBlock>



<xmod:Template runat="server"  UsePaging="True" Ajax="True" AddRoles="Sellers" EditRoles="Sellers" DeleteRoles="Sellers" DetailRoles="Sellers">

  <ListDataSource CommandText="SELECT * FROM vw_XMP_Seller_Ad WHERE SellerUserID = @SellerUserID ORDER BY Approved, Date_Created DESC">
    <Parameter Name="SellerUserID" Value='<%#UserData("ID")%>' DataType="Int32" />
  </ListDataSource>

  <DetailDataSource CommandText="SELECT * FROM vw_XMP_Admin_Ad_Detail WHERE [AdID] = @AdID">
    <Parameter name="AdID" />
  </DetailDataSource>

  <customcommands>
    <DataCommand CommandName="FlagToggle" CommandText="XMP_Classified_Flag_Toggle" CommandType="StoredProcedure">
      <Parameter Name="ID1" />
      <Parameter Name="ID2" />
      <Parameter Name="FlagType" />
    </DataCommand>
    <DataCommand CommandName="RenewAd" CommandText="XMP_Classified_Admin_RenewAd" CommandType="StoredProcedure">
      <Parameter Name="AdID" />
      <Parameter Name="UserID" />
      <Parameter Name="Updated_IP" />
    </DataCommand>
    <DataCommand CommandName="DeleteAd" CommandText="DELETE FROM XMP_Classified_Ad WHERE [AdID] = @AdID">
      <Parameter Name="AdID" />
    </DataCommand>
  </customcommands>

  <Pager PageSize="10"
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

  <SearchSort FilterExpression="Ad_Title LIKE '%{0}%'"
              SearchLabelText="Search For:" SearchButtonText="GO"
              SortFieldNames="Approved, Active, IsSold, Ad_Expires, Date_Created"
              SortFieldLabels="Approved, Active, Sold, Expired, Created"
              SearchBoxCssClass="form-control"
              SearchButtonCssClass="btn btn-default"
              SortButtonText="Go"
              SortButtonCssClass="btn btn-default"
              SortFieldListCssClass="form-control">

    <div class="row">
      <div class="col-sm-6">
        <div class="input-group">
          {SearchBox}

          <span class="input-group-btn">{SearchButton}
          </span>
        </div>
      </div>
      <div class="col-sm-6">
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
    </div>
    <br />
    
  </SearchSort>

	<HeaderTemplate>
		<table class="table table-bordered table-striped">
      <thead>
        <tr>
          <th class="text-center">Image</th>
          <th class="text-center">ID</th>
          <th class="text-center">Title</th>
          <th class="text-center">Price</th>
          <th class="text-center">Created</th>
          <th class="text-center">Expires</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
	</HeaderTemplate>

  <ItemTemplate>
        <tr>
          <td>
            <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
              <img src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
            </xmod:IfNotEmpty>
            <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
              <img class="img-thumbnail" src="http://placehold.it/80&text=no+image" />
            </xmod:IfEmpty>
          </td>
					<td class="text-center"><%#Eval("Values")("AdID")%></td>
          <td><%#Eval("Values")("Ad_Title")%></td>
          <td>
            <xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" />
          </td>
          <td>
            <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" />
          </td>
          <td>
            <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" />
          </td>
          <td>
            
            <div class="btn-group" role="group">
              <xmod:DetailButton runat="server" CssClass="btn btn-xs btn-default" Text="Details">
              	<Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
            	</xmod:DetailButton>
              <xmod:Select runat="server">
              	<Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
              		<xmod:EditButton runat="server" CssClass="btn btn-xs btn-default" Text="Edit">
                    <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
                  </xmod:EditButton>     
                </Case>
              </xmod:Select>
                
    					<div class="btn-group" role="group">
                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="false">More <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu">
                  <xmod:Select runat="server" Mode="Standard">
                  	<Case Comparetype="Role" Operator="=" Expression="Sellers">
                       <xmod:Select runat="server">
                          <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
                            <xmod:Select runat="server" Mode="Inclusive">
                              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="False">
                                <li>
                                  <xmod:CommandLink runat="server" Text="Activate Ad" ToolTip="Activate Ad">
                                    <Command Name="FlagToggle" Type="Custom">
                                      <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                      <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                                      <Parameter Name="FlagType" Value="active" DataType="string" />
                                    </Command>
                                  </xmod:CommandLink>
                                </li>  
                              </Case>
                              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="True">
                                <li>
                                  <xmod:CommandLink runat="server" Text="Deactivate Ad" ToolTip="Deactivate Ad">
                                    <Command Name="FlagToggle" Type="Custom">
                                      <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                      <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                                      <Parameter Name="FlagType" Value="active" DataType="string" />
                                    </Command>
                                  </xmod:CommandLink>
                                </li>  
                              </Case>
                              <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
                                <li>
                                  <xmod:CommandLink runat="server"   Text="Mark Sold" ToolTip="Mark item/s SOLD">
                                    <Command Name="FlagToggle" Type="Custom">
                                      <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                      <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                                      <Parameter Name="FlagType" Value="issold" DataType="string" />
                                    </Command>
                                  </xmod:CommandLink>
                                </li>  
                              </Case>
                            </xmod:Select>
                          </Case>
                        </xmod:Select>
                      <li>
                        <xmod:CommandLink runat="server" Text="Renew Ad" ToolTip="Renew Item" OnClientClick="return confirm('Renew the Ad for an additional 30 Days?');">
                          <Command Name="RenewAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                            <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                            <Parameter Name="Updated_IP" Value='<%#RequestData("HostAddress")%>' DataType="String"/>
                          </Command>
                        </xmod:CommandLink>
                      </li>    
                      
                      <li>
                        <xmod:CommandLink runat="server" Text="Delete" ToolTip="Delete Item" OnClientClick="return confirm('Are you sure, this is Permanent!?');">
                          <Command Name="DeleteAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          </Command>
                        </xmod:CommandLink>
                      </li>            
                      
                    </Case>
                  </xmod:Select>                  
                </ul>
              </div>
						</div>
          </td>
    		</tr>
    		<tr class="status-row">
          <td colspan="7">
            <xmod:Select runat="server" Mode="Inclusive">
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Approved")%>' Operator="=" Expression="False">
                <span class="label label-warning">Pending Approval</span>
              </Case>
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Expired")%>' Operator="=" Expression="True">
                <span class="label label-danger">Expired</span>
              </Case>
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="False">
                <span class="label label-default">Inactive</span>
              </Case>
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="True">
                <span class="label label-success">Sold</span>
              </Case>
            </xmod:Select>
          </td>
        </tr>
  </ItemTemplate>

  <AlternatingItemTemplate>
  	<tr class="alt-row">
          <td>
            <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
              <img src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
            </xmod:IfNotEmpty>
            <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
              <img class="img-thumbnail" src="http://placehold.it/80&text=no+image" />
            </xmod:IfEmpty>
          </td>
					<td class="text-center"><%#Eval("Values")("AdID")%></td>
          <td><%#Eval("Values")("Ad_Title")%></td>
          <td>
            <xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" />
          </td>
          <td>
            <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" />
          </td>
          <td>
            <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" />
          </td>
          <td>
            
            <div class="btn-group" role="group">
              <xmod:DetailButton runat="server" CssClass="btn btn-xs btn-default" Text="Details">
              	<Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
            	</xmod:DetailButton>
              <xmod:Select runat="server">
              	<Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
              		<xmod:EditButton runat="server" CssClass="btn btn-xs btn-default" Text="Edit">
                    <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
                  </xmod:EditButton>     
                </Case>
              </xmod:Select>
                
    					<div class="btn-group" role="group">
                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="false">More <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu">
                  <xmod:Select runat="server" Mode="Standard">
                  	<Case Comparetype="Role" Operator="=" Expression="Sellers">
                       <xmod:Select runat="server">
                          <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
                            <xmod:Select runat="server" Mode="Inclusive">
                              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="False">
                                <li>
                                  <xmod:CommandLink runat="server" Text="Activate Ad" ToolTip="Activate Ad">
                                    <Command Name="FlagToggle" Type="Custom">
                                      <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                      <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                                      <Parameter Name="FlagType" Value="active" DataType="string" />
                                    </Command>
                                  </xmod:CommandLink>
                                </li>  
                              </Case>
                              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="True">
                                <li>
                                  <xmod:CommandLink runat="server" Text="Deactivate Ad" ToolTip="Deactivate Ad">
                                    <Command Name="FlagToggle" Type="Custom">
                                      <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                      <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                                      <Parameter Name="FlagType" Value="active" DataType="string" />
                                    </Command>
                                  </xmod:CommandLink>
                                </li>  
                              </Case>
                              <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
                                <li>
                                  <xmod:CommandLink runat="server"   Text="Mark Sold" ToolTip="Mark item/s SOLD">
                                    <Command Name="FlagToggle" Type="Custom">
                                      <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                      <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                                      <Parameter Name="FlagType" Value="issold" DataType="string" />
                                    </Command>
                                  </xmod:CommandLink>
                                </li>  
                              </Case>
                            </xmod:Select>
                          </Case>
                        </xmod:Select>
                      <li>
                        <xmod:CommandLink runat="server" Text="Renew Ad" ToolTip="Renew Item" OnClientClick="return confirm('Renew the Ad for an additional 30 Days?');">
                          <Command Name="RenewAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                            <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                            <Parameter Name="Updated_IP" Value='<%#RequestData("HostAddress")%>' DataType="String"/>
                          </Command>
                        </xmod:CommandLink>
                      </li>    
                      
                      <li>
                        <xmod:CommandLink runat="server" Text="Delete" ToolTip="Delete Item" OnClientClick="return confirm('Are you sure, this is Permanent!?');">
                          <Command Name="DeleteAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          </Command>
                        </xmod:CommandLink>
                      </li>            
                      
                    </Case>
                  </xmod:Select>                  
                </ul>
              </div>
						</div>
          </td>
    		</tr>
    		<tr class="status-row">
          <td colspan="7">
            <xmod:Select runat="server" Mode="Inclusive">
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Approved")%>' Operator="=" Expression="False">
                <span class="label label-warning">Pending Approval</span>
              </Case>
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Expired")%>' Operator="=" Expression="True">
                <span class="label label-danger">Expired</span>
              </Case>
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="False">
                <span class="label label-default">Inactive</span>
              </Case>
              <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="True">
                <span class="label label-success">Sold</span>
              </Case>
            </xmod:Select>
          </td>
        </tr>
  </AlternatingItemTemplate>


	<FooterTemplate>

    	</tbody>
    </table>
	</FooterTemplate>

        <DetailTemplate>

    <div role="tabpanel">

      <ul class="nav nav-tabs" role="tablist" style="margin-left: 0px">
        <li role="presentation" class="active"><a href="#adsummary" aria-controls="adsummary" role="tab" data-toggle="tab">Ad Summary</a></li>
        <li role="presentation"><a href="#addetails" aria-controls="addetails" role="tab" data-toggle="tab">Detailed Description</a></li>
        <li role="presentation"><a href="#seller" aria-controls="seller" role="tab" data-toggle="tab">Seller</a></li>
      </ul>
      
      <div class="tab-content">

        <div role="tabpanel" class="tab-pane active" id="adsummary">
          <div class="summary-wrapper">
            <div class="title-wrapper">
              <h1><%#Eval("Values")("Ad_Title")%></h1>
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Subtitle")%>'>
                <h2><%#Eval("Values")("Ad_Subtitle")%></h2>
              </xmod:IfNotEmpty>
              <h5>Item located in <%#Eval("Values")("Location")%></h5>
            </div>
            <div class="price-wrapper">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
                <xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" />
              </xmod:IfNotEmpty>
              <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
                FREE!
              </xmod:IfEmpty>
            </div>
            <div class="contact-wrapper">
              <xmod:Select runat="server" Mode="Inclusive">
                <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowPhone")%>' Operator="=" Expression="True">
                  Phone: <%#Eval("Values")("Seller_Phone")%><br/>
                </Case>
                <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowEmail")%>' Operator="=" Expression="True">
                  Email: <a href="mailto:<%#Eval("Values")("Seller_Email")%>"><%#Eval("Values")("Seller_Email")%></a>
                </Case>
              </xmod:Select>
            </div>
            <div class="image-wrapper">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                <img class="img-thumbnail" src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/<%#Eval("Values")("PrimaryImage")%>" />
              </xmod:IfNotEmpty>
              <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                <img class="img-thumbnail" src="http://placehold.it/300&text=no+image" />
              </xmod:IfEmpty>
            </div>

            <div class="adsummary-wrapper">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Summary")%>'>
                <p><%#Eval("Values")("Ad_Summary")%></p>
              </xmod:IfNotEmpty>	
            </div>
            <div class="adinfo-wrapper">
              <ul class="list-group" style="margin-left: 0px">
                <li class="list-group-item">Posted by <%#Eval("Values")("Seller_Name")%> on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" /></li>
                <li class="list-group-item">Expires on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" /></li>
                <xmod:Select runat="server">
                  <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowAddress")%>' Operator="=" Expression="True">
                    <li class="list-group-item">Address: <%#Eval("Values")("Seller_Address")%> - <%#Eval("Values")("SellerLocation")%></li>
                  </Case>
                </xmod:Select>
              </ul>
            </div>
          </div>        
        </div>
 
        <div role="tabpanel" class="tab-pane" id="addetails">
        	<div class="summary-wrapper">
            <div class="title-wrapper">
              <h1><%#Eval("Values")("Ad_Title")%></h1>
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Subtitle")%>'>
              	<h2><%#Eval("Values")("Ad_Subtitle")%></h2>
              </xmod:IfNotEmpty>
              <h5>Item located in <%#Eval("Values")("Location")%></h5>
            </div>
            <div class="price-wrapper">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
              	<xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" />
              </xmod:IfNotEmpty>
              <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Price")%>'>
              	FREE!
              </xmod:IfEmpty>
            </div>
            <div class="contact-wrapper">
              <xmod:Select runat="server" Mode="Inclusive">
              	<Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowPhone")%>' Operator="=" Expression="True">
                	Phone: <%#Eval("Values")("Seller_Phone")%><br/>
                </Case>
                <Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowEmail")%>' Operator="=" Expression="True">
                	Email: <a href="mailto:<%#Eval("Values")("Seller_Email")%>"><%#Eval("Values")("Seller_Email")%></a>
                </Case>
              </xmod:Select>
            </div>
            <div class="addetails-wrapper">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Ad_Description")%>'>
              	<div><%#Eval("Values")("Ad_Description")%></div>
              </xmod:IfNotEmpty>	
              <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Ad_Description")%>'>
              	<div>Contact seller for details...</div>
              </xmod:IfEmpty>
            </div>
            <div class="adinfo-wrapper">
              <ul class="list-group" style="margin-left: 0px;">
                <li class="list-group-item">Posted by <%#Eval("Values")("Seller_Name")%> on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" /></li>
                <li class="list-group-item">Expires on: <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" /></li>
                <xmod:Select runat="server">
                	<Case Comparetype="Boolean" Value='<%#Eval("Values")("ShowAddress")%>' Operator="=" Expression="True">
                  	<li class="list-group-item">Address: <%#Eval("Values")("Seller_Address")%> - <%#Eval("Values")("SellerLocation")%></li>
                  </Case>
                </xmod:Select>
              </ul>
            </div>
          </div> 
        </div>
     		
        <div role="tabpanel" class="tab-pane" id="seller">
          <div class="media" style="margin-top: 50px">
            <a class="media-left" href="#">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
                <img class="img-thumbnail" src="/Portals/<%#PortalData("ID")%>/Classifieds/SellerImages/thm_<%#Eval("Values")("Seller_Image")%>" style="max-width: 100px" alt="<%#Eval("Values")("Seller_Name")%>">
              </xmod:IfNotEmpty>
              <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
                <img class="img-thumbnail" src="http://placehold.it/100&text=no+image" />
              </xmod:IfEmpty>
            </a>
            <div class="media-body">
              <h4 class="media-heading"><%#Eval("Values")("Seller_Name")%></h4>
              <h5>SellerID: <%#Eval("Values")("SellerID")%></h5>
              <h5>User: <%#Eval("Values")("SellerUsername")%> (<%#Eval("Values")("UserID")%>)</h5>
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
                <th>Seller Deleted</th>
                <th>User Deleted</th>
                <th>User Authorized</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><%#Eval("Values")("Seller_Address")%></td>
                <td><%#Eval("Values")("SellerLocation")%> (<%#Eval("Values")("Seller_Location")%>)</td>
                <td><%#Eval("Values")("Seller_Phone")%></td>
                <td><%#Eval("Values")("Seller_Email")%></td>
                <td><%#Eval("Values")("ShowAddress")%></td>
                <td><%#Eval("Values")("ShowPhone")%></td>
                <td><%#Eval("Values")("Date_Created")%></td>
                <td><%#Eval("Values")("Date_Updated")%></td>
                <td><%#Eval("Values")("UpdatedByUsername")%> (<%#Eval("Values")("UpdatedBy")%>)</td>
                <td><%#Eval("Values")("Banned")%></td>
                <td><%#Eval("Values")("SellerDeleted")%></td> 
                <td><%#Eval("Values")("UserDeleted")%></td>
                <td><%#Eval("Values")("UserAuthorized")%></td>
              </tr>
            </tbody>

          </table>
        </div>        
        
     </div>
      
   </div>
    
    
    
    

    <xmod:ReturnLink runat="server" CssClass="btn btn-default" Text="&lt;&lt; Go Back" />
    <hr />

  </DetailTemplate>

</xmod:Template></xmod:masterview>