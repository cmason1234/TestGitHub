<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="CompAddEdit.aspx.vb" Inherits="Wine.Web.CompAddEdit" %>

<%@ MasterType TypeName="Wine.Web.Blank" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">

    <div class="fake-toolbar">
        <table border="1">
            <tr>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnSave" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Save-16x16.png" Text="Save" ToolTip="Save" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;" id="delArea" runat="server">
                    <telerik:RadButton ID="btnDel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/delete-16x16.png"  Text="Delete" ToolTip="Delete" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCancel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/cancel-16x16.png"  Text="Back to Competitions" ToolTip="Back to Competitions" Width="150" ButtonType="StandardButton" />
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">

        <br />
        <asp:HiddenField ID="hfCompetitionID" runat="server" Visible="false" />
        <fieldset class="fieldset100Percent box_round box_shadow">
            <legend>General Info</legend>
            <br />
            <table>
                <tr>
                    <td>
                        <b>Name</b>&nbsp;<asp:RequiredFieldValidator ID="firstNameRequiredFieldValidator" runat="server" ControlToValidate="tbCompNameTextBox" ErrorMessage="Competition Name is Required">*</asp:RequiredFieldValidator>
                    </td>
                    <td colspan="3">
                        <asp:TextBox CssClass="textBox" Width="350" ID="tbCompNameTextBox" runat="server" emptymessage="Competition Name" />
                    </td>
                </tr>

                <tr>
                    <td>
                        <b>Comp Type</b>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCompType" runat="server">
                            <asp:ListItem>Monthly</asp:ListItem>
                            <asp:ListItem>Yearly</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <b>Year</b>&nbsp;
                        <asp:DropDownList ID="ddlYear" runat="server">
                            <asp:ListItem Value="">** Select</asp:ListItem>
                            <asp:ListItem>2013</asp:ListItem>
                            <asp:ListItem>2014</asp:ListItem>
                            <asp:ListItem>2015</asp:ListItem>
                            <asp:ListItem>2016</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <b>Month</b>&nbsp;
                        <asp:DropDownList ID="ddlMonth" runat="server">
                            <asp:ListItem Value="">** Select</asp:ListItem>
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
                </tr>
            </table>

        </fieldset>
        <br class="clear" />
        <br />
    </div>

    <div id="divMontlyList" runat="server">
        <telerik:RadButton ID="btnNewWine1" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Add-16x16.png" Text="Add New Wine" ToolTip="Add New Wine" Width="125" ButtonType="StandardButton" OnClick="btnNewWine_Click" />
        <br />
        <span style="margin-left: 12px;">
            <asp:Literal ID="litMontlyCount" EnableViewState="false" runat="server" />
        </span>
        <div style="margin-left: 4px;">

            <telerik:RadGrid ItemStyle-Wrap="false" ID="dgGridMonthlyComp" Width="80%" AllowPaging="true" 
                PageSize="100" AllowCustomPaging="false" AllowSorting="true" runat="server" AutoGenerateColumns="false" ShowFooter="true">
                <PagerStyle Mode="NumericPages" Position="TopAndBottom" AlwaysVisible="false" />
                <ExportSettings IgnorePaging="true" />
                <MasterTableView TableLayout="Fixed" EnableViewState="false">
                    <Columns>
                        <telerik:GridHyperLinkColumn HeaderText="Entry" FooterText="Entry" DataTextField="EntryID" DataNavigateUrlFields="CompetitionID, WineEntryID" DataNavigateUrlFormatString="/Competition/WineEntryAddEdit.aspx?CompetitionID={0}&WineEntryID={1}" SortExpression="EntryID" />
                        <telerik:GridBoundColumn HeaderText="Wine Name" FooterText="Wine Name" DataField="WineName" />
                        <telerik:GridBoundColumn HeaderText="Entrant Name" FooterText="Entrant Name" DataField="EntrantName" />
                        <telerik:GridBoundColumn HeaderText="AvgScore" FooterText="AvgScore" DataField="AvgScore" />
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

        <telerik:RadButton ID="btnNewWine2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Add-16x16.png" Text="Add New Wine" ToolTip="Add New Wine" Width="125" ButtonType="StandardButton" OnClick="btnNewWine_Click" />

        <br />
        <br />

    </div>


    <div id="divYearlyList" runat="server">
        <asp:Button ID="btnNewWine3" runat="server" Text="Add New Wine" OnClick="btnNewWine_Click" />&nbsp;
        <span style="margin-left: 12px;">
            <asp:Literal ID="litYearlyCount" EnableViewState="false" runat="server" />
        </span>
        <div style="margin-left: 4px;">
            <asp:DataGrid ItemStyle-Wrap="false" ID="DataGrid1" Width="750" AllowPaging="true" PageSize="100" AllowCustomPaging="false" AllowSorting="true" runat="server" AutoGenerateColumns="false">
                <PagerStyle Mode="NumericPages" Position="TopAndBottom" />
                <Columns>
                    <asp:HyperLinkColumn HeaderText="Name" HeaderStyle-Width="350" DataTextField="CompetitionName" DataNavigateUrlField="CompetitionId" DataNavigateUrlFormatString="/Competition/CompAddEdit.aspx?CompetitionID={0}" SortExpression="CompetitionId" />
                    <asp:BoundColumn HeaderText="Year" DataField="Year" />
                    <asp:BoundColumn HeaderText="Month" DataField="Month" />
                    <asp:BoundColumn HeaderText="Type" DataField="CompType" />
                </Columns>
                <HeaderStyle HorizontalAlign="Left" />
                <AlternatingItemStyle BackColor="White" />
                <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            </asp:DataGrid>
        </div>
        <br />
        <br />
        <asp:Button ID="btnNewWine4" runat="server" Text="Add New Wine" OnClick="btnNewWine_Click" />

        <br />
        <br />

    </div>

</asp:Content>
