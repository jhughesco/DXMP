<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="SellerCSS" BlockType="HeadScript" RegisterOnce="False">

  <style type="text/css">
    .pager-active {
      color: #fff !important;
      background-color: #337ab7 !important;
      border-color: #337ab7 !important;
    }

    .nowrap {
      white-space: nowrap;
    }

    .unradius {
      border-radius: 0px;
    }

    .alt-row {
      background-color: #e8e8e8;
    }

    .approved-False, .approved-alt-False {
      background-color: #fee2e2 !important;
    }
    
    .approved-True {
      background-color: #fff !important;
    }
    
    .approved-alt-True {
      background-color: #e8e8e8 !important;
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



    <xmod:Template runat="server" UsePaging="True" Ajax="False" AddRoles="Administrators" EditRoles="Administrators" DeleteRoles="Administrators" DetailRoles="">

        <ListDataSource CommandText="SELECT * FROM vw_XMP_Admin_Ad ORDER BY Approved, Date_Created" />

      	<DetailDataSource CommandText="SELECT * FROM vw_XMP_Admin_Ad_Detail WHERE [AdID] = @AdID">
            <parameter name="AdID" />
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
            FilterExpression="Ad_Title LIKE '%{0}%'"
            SearchLabelText="Search For:" SearchButtonText="GO"
            SortFieldNames="Ad_Title,Seller_Name,Location,Date_Created"
            SortFieldLabels="Title,Name,Location,Created"
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
                <th>Image</th>
                <th>Seller</th>
                <th>Location</th>
                <th>Title</th>
                <th>Price</th>
                <th>Created</th>
                <th>Created By</th>
                <th>Updated</th>
                <th>Updated By</th>
                <th>IsSold</th>
                <th>Ad Expires</th>
                <th>Approved</th>
                <th>Active</th>
                <th  style="min-width: 160px">&nbsp;</th>
              </tr>
            </thead>
            <tbody>
        </HeaderTemplate>

        <ItemTemplate>
            <tr class="approved-<%#Eval("Values")("Approved")%>">
                <td>
                  <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                    <img src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
                  </xmod:IfNotEmpty>
                </td>
                <td style="white-space: nowrap;">
                    <div class="btn-group" role="group">
                      <xmod:Redirect runat="server"  CssClass="btn btn-xs btn-info" Display="LinkButton" Method="Post" Target="~/Classifieds-Admin/Sellers/Seller-Details" Text='<%#Eval("Values")("SellerUsername")%>'>
												<Field Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
                      </xmod:Redirect>
                    </div>
                </td>
                <td><%#Eval("Values")("Location")%></td>
                <td><%#Eval("Values")("Ad_Title")%></td>
                <td>
                    <xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" /></td>
                <td>
                    <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" /></td>
                <td><%#Eval("Values")("CreatedByUsername")%></td>
                <td>
                    <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Updated")%>' Pattern="MM/dd/yyyy" /></td>
                <td><%#Eval("Values")("UpdatedByUsername")%></td>
                <td>
                  <xmod:Select runat="server" Mode="Standard">
                    <Case CompareType="Boolean" Value="True" Operator="=" Expression='<%#Eval("Values")("IsSold")%>'>
                      <xmod:CommandLink runat="server" Text="True" CssClass="btn btn-xs btn-success">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="issold" DataType="string" />
                        </Command>
                      </xmod:CommandLink>    	
                    </Case>
                    <Else>
                      <xmod:CommandLink runat="server" Text="False" CssClass="btn btn-xs btn-danger">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="issold" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </Else>
                  </xmod:Select>
              </td>
                <td>
                    <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" /></td>
                <td>
									<xmod:Select runat="server" Mode="Standard">
                    <Case CompareType="Boolean" Value="True" Operator="=" Expression='<%#Eval("Values")("Approved")%>'>
                      <xmod:CommandLink runat="server" Text="True" CssClass="btn btn-xs btn-success">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="approved" DataType="string" />
                        </Command>
                      </xmod:CommandLink>    	
                    </Case>
                    <Else>
                      <xmod:CommandLink runat="server" Text="False" CssClass="btn btn-xs btn-danger">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="approved" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </Else>
                  </xmod:Select>
              	</td>
                <td>
              		<xmod:Select runat="server" Mode="Standard">
                    <Case CompareType="Boolean" Value="True" Operator="=" Expression='<%#Eval("Values")("Active")%>'>
                      <xmod:CommandLink runat="server" Text="True" CssClass="btn btn-xs btn-success">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="active" DataType="string" />
                        </Command>
                      </xmod:CommandLink>    	
                    </Case>
                    <Else>
                      <xmod:CommandLink runat="server" Text="False" CssClass="btn btn-xs btn-danger">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="active" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </Else>
                  </xmod:Select>
              	</td>

                <td>
          	<div class="btn-group" role="group">
              <xmod:DetailButton runat="server" CssClass="btn btn-xs btn-default" Text="Details">
              	<Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
            	</xmod:DetailButton>
              <xmod:EditButton runat="server" CssClass="btn btn-xs btn-default" Text="Edit">
              	<Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
            	</xmod:EditButton>   
    					<div class="btn-group" role="group">
                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="false">More <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu">
                  <xmod:Select runat="server" Mode="Standard">
                  	<Case Comparetype="Role" Operator="=" Expression="Administrators">
                    	<xmod:Select runat="server" Mode="Inclusive">
                      	<Case Comparetype="Boolean" Value='<%#Eval("Values")("Approved")%>' Operator="=" Expression="False">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Approve Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="ApproveAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("Approved")%>' Operator="=" Expression="True">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Unapprove Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="UnapproveAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="False">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Activate Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="ActivateAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="True">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Deactivate Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="DeactivateAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Mark As Sold" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="MarkAsSold" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="True">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Mark As Not Sold" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="MarkAsUnsold" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                      </xmod:Select>                       
                      
                      <li>
                        <xmod:CommandLink runat="server" Text="Renew Ad" OnClientClick="return confirm('Are you sure?');">
                          <Command Name="RenewAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                            <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                          </Command>
                        </xmod:CommandLink>
                      </li>    
                      
                      <li>
                        <xmod:CommandLink runat="server" Text="Delete" OnClientClick="return confirm('Are you sure?');">
                          <Command Name="DeleteAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          </Command>
                        </xmod:CommandLink>
                      </li>            
                      
                    </Case>
                  	<Else>
                  		<li>
                      	<a>Permission Denied</a>
                      </li>
                  	</Else>
                  </xmod:Select>                  
                </ul>
              </div>
						</div>
          </td>
            </tr>
        </ItemTemplate>

        <AlternatingItemTemplate>
            <tr class="alt-row approved-alt-<%#Eval("Values")("Approved")%>">
                <td>
                  <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("PrimaryImage")%>'>
                    <img src="/Portals/<%#PortalData("ID")%>/Classifieds/Ads/<%#Eval("Values")("SellerID")%>/thm_<%#Eval("Values")("PrimaryImage")%>" />
                  </xmod:IfNotEmpty>
                </td>
                <td style="white-space: nowrap;">
                    <div class="btn-group" role="group">
                      <xmod:Redirect runat="server"  CssClass="btn btn-xs btn-info" Display="LinkButton" Target="~/Classifieds-Admin/Sellers/Seller-Details" Text='<%#Eval("Values")("SellerUsername")%>'>
												<Field Name="SellerID" Value='<%#Eval("Values")("SellerID")%>' />
                      </xmod:Redirect>
                    </div>
                </td>
                <td><%#Eval("Values")("Location")%></td>
                <td><%#Eval("Values")("Ad_Title")%></td>
                <td>
                    <xmod:Format runat="server" Type="Float" Value='<%#Eval("Values")("Ad_Price")%>' Pattern="c" /></td>
                <td>
                    <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Created")%>' Pattern="MM/dd/yyyy" /></td>
                <td><%#Eval("Values")("CreatedByUsername")%></td>
                <td>
                    <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Date_Updated")%>' Pattern="MM/dd/yyyy" /></td>
                <td><%#Eval("Values")("UpdatedByUsername")%></td>
                <td>
                  <xmod:Select runat="server" Mode="Standard">
                    <Case CompareType="Boolean" Value="True" Operator="=" Expression='<%#Eval("Values")("IsSold")%>'>
                      <xmod:CommandLink runat="server" Text="True" CssClass="btn btn-xs btn-success">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="issold" DataType="string" />
                        </Command>
                      </xmod:CommandLink>    	
                    </Case>
                    <Else>
                      <xmod:CommandLink runat="server" Text="False" CssClass="btn btn-xs btn-danger">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="issold" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </Else>
                  </xmod:Select>
              </td>
                <td>
                    <xmod:Format runat="server" Type="Date" Value='<%#Eval("Values")("Ad_Expires")%>' Pattern="MM/dd/yyyy" /></td>
                <td>
									<xmod:Select runat="server" Mode="Standard">
                    <Case CompareType="Boolean" Value="True" Operator="=" Expression='<%#Eval("Values")("Approved")%>'>
                      <xmod:CommandLink runat="server" Text="True" CssClass="btn btn-xs btn-success">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="approved" DataType="string" />
                        </Command>
                      </xmod:CommandLink>    	
                    </Case>
                    <Else>
                      <xmod:CommandLink runat="server" Text="False" CssClass="btn btn-xs btn-danger">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="approved" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </Else>
                  </xmod:Select>
              	</td>
                <td>
              		<xmod:Select runat="server" Mode="Standard">
                    <Case CompareType="Boolean" Value="True" Operator="=" Expression='<%#Eval("Values")("Active")%>'>
                      <xmod:CommandLink runat="server" Text="True" CssClass="btn btn-xs btn-success">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="active" DataType="string" />
                        </Command>
                      </xmod:CommandLink>    	
                    </Case>
                    <Else>
                      <xmod:CommandLink runat="server" Text="False" CssClass="btn btn-xs btn-danger">
                        <Command Name="FlagToggle" Type="Custom">
                          <Parameter Name="ID1" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          <Parameter Name="ID2" Value='<%#UserData("ID")%>' DataType="Int32" />
                          <Parameter Name="FlagType" Value="active" DataType="string" />
                        </Command>
                      </xmod:CommandLink>
                    </Else>
                  </xmod:Select>
              	</td>

                <td>
          	<div class="btn-group" role="group">
              <xmod:DetailButton runat="server" CssClass="btn btn-xs btn-default" Text="Details">
              	<Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
            	</xmod:DetailButton>
              <xmod:EditButton runat="server" CssClass="btn btn-xs btn-default" Text="Edit">
              	<Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' />
            	</xmod:EditButton>   
    					<div class="btn-group" role="group">
                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="false">More <span class="caret"></span></button>
                <ul class="dropdown-menu" role="menu">
                  <xmod:Select runat="server" Mode="Standard">
                  	<Case Comparetype="Role" Operator="=" Expression="Administrators">
                    	<xmod:Select runat="server" Mode="Inclusive">
                      	<Case Comparetype="Boolean" Value='<%#Eval("Values")("Approved")%>' Operator="=" Expression="False">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Approve Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="ApproveAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("Approved")%>' Operator="=" Expression="True">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Unapprove Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="UnapproveAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="False">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Activate Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="ActivateAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("Active")%>' Operator="=" Expression="True">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Deactivate Ad" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="DeactivateAd" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="False">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Mark As Sold" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="MarkAsSold" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                        <Case Comparetype="Boolean" Value='<%#Eval("Values")("IsSold")%>' Operator="=" Expression="True">
                      		<li>
                            <xmod:CommandLink runat="server" Text="Mark As Not Sold" OnClientClick="return confirm('Are you sure?');">
                              <Command Name="MarkAsUnsold" Type="Custom">
                                <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                                <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                              </Command>
                            </xmod:CommandLink>
                          </li>  
                        </Case>
                      </xmod:Select>                       
                      
                      <li>
                        <xmod:CommandLink runat="server" Text="Renew Ad" OnClientClick="return confirm('Are you sure?');">
                          <Command Name="RenewAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                            <Parameter Name="UserID" Value='<%#UserData("ID")%>' DataType="Int32" />
                          </Command>
                        </xmod:CommandLink>
                      </li>    
                      
                      <li>
                        <xmod:CommandLink runat="server" Text="Delete" OnClientClick="return confirm('Are you sure?');">
                          <Command Name="DeleteAd" Type="Custom">
                            <Parameter Name="AdID" Value='<%#Eval("Values")("AdID")%>' DataType="Int32" />
                          </Command>
                        </xmod:CommandLink>
                      </li>            
                      
                    </Case>
                  	<Else>
                  		<li>
                      	<a>Permission Denied</a>
                      </li>
                  	</Else>
                  </xmod:Select>                  
                </ul>
              </div>
						</div>
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

      

		</div>
    
    
    
    

    <xmod:ReturnLink runat="server" CssClass="btn btn-default" Text="&lt;&lt; Go Back" />
    <hr />

  </DetailTemplate>

</xmod:Template></xmod:masterview>