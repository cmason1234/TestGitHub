<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master" 
    CodeBehind="CompSearch.aspx.vb" Inherits="Wine.Web.CompSearch" %>

<%@ MasterType TypeName="Wine.Web.Blank" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <div class="fake-toolbar">
        <table>
            <tr>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <b>Name</b>&nbsp;<asp:TextBox ID="tbName" runat="server" Width="200" />
                </td>
                <td style="white-space: nowrap; border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <b>Year</b>&nbsp;
                    <asp:DropDownList ID="ddlYear" runat="server">
                        <asp:ListItem Value="" >** Select</asp:ListItem>
                        <asp:ListItem Selected="True">2019</asp:ListItem>
                        <asp:ListItem>2018</asp:ListItem>
                        <asp:ListItem>2017</asp:ListItem>
                        <asp:ListItem>2016</asp:ListItem>
                        <asp:ListItem>2015</asp:ListItem>
                        <asp:ListItem>2014</asp:ListItem>
                        <asp:ListItem>2013</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <b>Month</b>&nbsp;
                    <asp:DropDownList ID="ddlMonth" runat="server">
                        <asp:ListItem Value="" Selected="True">** Select</asp:ListItem>
                        <asp:ListItem>January</asp:ListItem>
                        <asp:ListItem>Febuary</asp:ListItem>
                        <asp:ListItem>March</asp:ListItem>
                        <asp:ListItem>April</asp:ListItem>
                        <asp:ListItem>May</asp:ListItem>
                        <asp:ListItem>June</asp:ListItem>
                        <asp:ListItem>July</asp:ListItem>
                        <asp:ListItem>August</asp:ListItem>
                        <asp:ListItem>September</asp:ListItem>
                        <asp:ListItem>October</asp:ListItem>
                        <asp:ListItem>November</asp:ListItem>
                        <asp:ListItem>December</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnFind" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/search-16x16.png" Text="Search" ToolTip="Search" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCreateNew" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/ico_new_16x16.gif" Text="Create New" ToolTip="Create New" Width="100" ButtonType="StandardButton" />
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">

        <span style="margin-left: 12px;">
            <asp:Literal ID="litCompetitionCount" EnableViewState="false" runat="server" /></span>
        <div style="margin-left: 4px;">
            <telerik:RadGrid ItemStyle-Wrap="false" ID="dgGridComp" Width="750" AllowPaging="true" PageSize="100" AllowCustomPaging="false" AllowSorting="true" runat="server" AutoGenerateColumns="false">
                <PagerStyle Mode="NumericPages" Position="TopAndBottom" AlwaysVisible="false" />
                <ExportSettings IgnorePaging="true" />
                <MasterTableView TableLayout="Fixed" EnableViewState="false" >
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="CompetitionName" SortOrder="Descending" />
                    </SortExpressions>
                    <Columns>
                        <telerik:GridHyperLinkColumn HeaderText="Name" HeaderStyle-Width="300" DataTextField="CompetitionName" DataNavigateUrlFields="CompetitionId" DataNavigateUrlFormatString="/Competition/CompAddEdit.aspx?CompetitionID={0}" SortExpression="CompetitionName"/>
                        <telerik:GridBoundColumn HeaderText="Year" DataField="Year" />
                        <telerik:GridBoundColumn HeaderText="Month" DataField="Month" />
                        <telerik:GridBoundColumn HeaderText="Type" DataField="CompType" />
                    </Columns>
                </MasterTableView>
                <HeaderStyle HorizontalAlign="Left" />
                <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                    <Scrolling AllowScroll="false" EnableVirtualScrollPaging="true" SaveScrollPosition="True"></Scrolling>
                    <Selecting AllowRowSelect="false" />
                    <Resizing AllowRowResize="False" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" AllowColumnResize="true"></Resizing>
                </ClientSettings>
            </telerik:RadGrid>
        </div>

        <br />
        <br />
    </div>

</asp:Content>
