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
                <img class="img-thumbnail" src="/Portals/0/avatar.png" style="max-width: 100px" alt="<%#Eval("Values")("Seller_Name")%>">
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