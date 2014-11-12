<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="PersonSearch.aspx.vb" Inherits="Wine.Web.PersonSearch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <div class="fake-toolbar">
        <table border="1">
            <tr>
                <td style="white-space: nowrap; border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <b>LastName</b>&nbsp;<asp:TextBox ID="tbName" runat="server" Width="200" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <b>UserName</b>&nbsp;<asp:TextBox ID="tbUserName" runat="server" Width="200" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnSearch" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/search-16x16.png" Text="Search" ToolTip="Search" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCreateNew" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/ico_new_16x16.gif" Text="Create New" ToolTip="Create New" Width="100" ButtonType="StandardButton" />
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">

        <span style="margin-left: 12px;">
            <asp:Literal ID="litPersonCount" EnableViewState="false" runat="server" /></span>
        <div style="margin-left: 4px;">
            <telerik:RadGrid ItemStyle-Wrap="false" ID="dgGridPerson" Width="750" AllowPaging="true" PageSize="100" AllowCustomPaging="false" AllowSorting="False" runat="server" AutoGenerateColumns="false">
                <PagerStyle Mode="NumericPages" Position="TopAndBottom" AlwaysVisible="false" />
                <ExportSettings IgnorePaging="true" />
                <MasterTableView TableLayout="Fixed" EnableViewState="false">
                    <Columns>
                        <telerik:GridHyperLinkColumn HeaderText="Name" HeaderStyle-Width="125" DataTextField="FullName" DataNavigateUrlFields="PersonID" DataNavigateUrlFormatString="/AdminTools/PersonAddEdit.aspx?PersonID={0}" />
                        <telerik:GridBoundColumn HeaderText="UserName" DataField="Username"/>
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
