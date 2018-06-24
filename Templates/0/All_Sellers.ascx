<%@ Control Language="vb" AutoEventWireup="false" Inherits="KnowBetter.XModPro.TemplateBase" %>
<%@ Register Assembly="KnowBetter.XModPro.Web.Controls" Namespace="KnowBetter.XModPro.Web.Controls" TagPrefix="xmod" %>
<xmod:masterview runat="server">
<xmod:ScriptBlock runat="server" ScriptId="SellerCSS" BlockType="HeadScript" RegisterOnce="True">
  <style type="text/css">
    #Body { background: #fff; }

    #Popup_Modal .modal-body {
      background:url("/images/loading.gif") center no-repeat;
    }

    #AllSellers div.media.ad {
      border: 1px solid #ebebeb;
      border-radius: 2px;
      position: relative;
      margin-bottom: 25px;
      background: white;
    }

    #AllSellers div.media-left.middle {
      vertical-align: middle; 
    }

    #AllSellers div.media a {
      text-decoration: none;
    }

    #AllSellers div.media img {
      max-height: 100px;
    }

    #AllSellers div.media .fa-picture-o {
      font-size: 36px;
      padding: 30px;
    }

    #AllSellers div.media .fa-expand {
      opacity: 0;      
      position: absolute;
      right: 10px;
      top: 10px;
    }

    #AllSellers div.media:hover .fa-expand {
      opacity: 1;
    }

    #AllSellers div.media .media-left {
      padding: 0px;
      background: white;
      height: 130px;
    }

    #AllSellers div.media .media-body {
      border-left: 1px dashed #ebebeb;
      padding: 5px 0 5px 10px;
    }

    .pager-active {
      color: #fff !important;
      background-color: #337ab7 !important;
      border-color: #337ab7 !important;
    }

    ol.breadcrumb { margin-left: 0px; }
    ol.breadcrumb li.pull-right:before {
      content: "";
    }

    .top10 {
      margin-top: 10px; 
    }
  
  </style>
</xmod:ScriptBlock>

<xmod:Template runat="server" UsePaging="False" Ajax="True">
  <ListDataSource CommandText="SELECT * 
                               FROM vw_XMP_All_Sellers
                               WHERE Agree=1 AND Banned=0 AND IsDeleted=0 AND Authorised=1 AND UserIsDeleted=0"/>
  
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
              SearchBoxCssClass="form-control"
              SearchButtonCssClass="btn btn-default">

    <div class="row">
      <div class="col-lg-3 col-sm-12 text-right">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#Location_Modal">Locations</button>
      </div>
      <div class="col-lg-6 text-center">
        <div class="input-group seller-search">
          {SearchBox}
          <span class="input-group-btn">
            {SearchButton}
          </span>
        </div>
      </div>
      <div class="col-lg-3 col-sm-12 text-left">
        <div class="clear-search">
          <button id="clear_search" type="button" class="btn btn-warning">
            Clear Search
          </button>
          <a href="/Sellers" class="btn btn-default">View All</a>
        </div>
      </div>
    </div><br/>
  </SearchSort>

    <HeaderTemplate>
      
      <div class="row">
        <div class="col-sm-12">
          <ol id="Ads_Breadcrumb" class="breadcrumb">
            <li>All Sellers</li>
          </ol>
        </div>  
      </div>
      
      <div id="AllSellers" class="row">
    </HeaderTemplate>

    <ItemTemplate>
      <div class="col-md-4 col-sm-6">
        <div class="media ad">
          <a href="/Sellers/Details/SellerID/<%#Eval("Values")("SellerID")%>">
            <div class="media-left middle">
              <xmod:IfNotEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
                <img class="media-object" src="/Portals/<%#PortalData("ID")%>/Classifieds/SellerImages/thm_<%#Eval("Values")("Seller_Image")%>" alt="<%#Eval("Values")("Seller_Name")%>">
              </xmod:IfNotEmpty>
              <xmod:IfEmpty runat="server" Value='<%#Eval("Values")("Seller_Image")%>'>
                <span class="fa fa-picture-o"></span>
              </xmod:IfEmpty>
            </div>
            <div class="media-body">
              <h4 class="media-heading"><%#Eval("Values")("Seller_Name")%></h4>
              <h5>
                <span class="text text-muted"><small><%#Eval("Values")("CityState")%></small></span>
              </h5>            
              <div>
                <span><small><xmod:Format runat="server" Type="Text" Value="Some Text" MaxLength="150" /></small></span>
              </div>
            </div>
          </a>
        </div>
      </div>
  </ItemTemplate>

  <FooterTemplate>
    </div>
  </FooterTemplate>


</xmod:Template>

<xmod:AddLink runat="server" CssClass="btn btn-primary" Text="New Seller" /></xmod:masterview>