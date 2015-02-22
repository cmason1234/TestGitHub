<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="CompAddEdit.aspx.vb" Inherits="Wine.Web.CompAddEdit" %>

<%@ Register Src="../_Controls/ctlErrorMessages.ascx" TagName="ErrorMessages" TagPrefix="ucErrorMessages" %>
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
                    <telerik:RadButton ID="btnDel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/delete-16x16.png" Text="Delete" ToolTip="Delete" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCancel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/cancel-16x16.png" Text="Back to Competitions" ToolTip="Back to Competitions" Width="150" ButtonType="StandardButton" />
                </td>

            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">

        <ucErrorMessages:ErrorMessages ID="ucErrorMessages" runat="server" />
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

    <div id="divYearlyList" runat="server">
        <table style="width: 85%;">
            <tr>
                <td style="width: 40%">
                    <asp:Button ID="btnNewWine3" runat="server" Text="Add New Wine" OnClick="btnNewWine_Click" />
                </td>
                <td>
                    <telerik:RadNumericTextBox Width="50" ID="tbWineSwitch" runat="server"
                        NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                        EnabledStyle-HorizontalAlign="Right" />&nbsp;
                    <telerik:RadButton ID="btnSwitch" runat="server"
                        Icon-PrimaryIconUrl="/_resources/images/ico/Login-16x16.png" Text="View Wine Scores"
                        ToolTip="View" Width="150" ButtonType="StandardButton" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <br />
                    <span style="margin-left: 12px;">
                        <asp:Literal ID="litYearlyCount" EnableViewState="false" runat="server" />
                    </span>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <telerik:RadGrid ID="dgGridYearlyComp" AllowPaging="false" PageSize="10" AllowSorting="false" runat="server"
                        AllowCustomPaging="false" AutoGenerateColumns="false" ShowFooter="True" GridLines="Both" Width="80%">
                        <PagerStyle Mode="NumericPages" Position="Bottom" />
                        <MasterTableView DataMember="WineColors" DataKeyNames="MedalColor" Width="100%" Name="MedalColor" HierarchyLoadMode="Client" GroupLoadMode="Server">
                            <HeaderStyle Font-Bold="true" Font-Size="Small" />
                            <FooterStyle Font-Bold="true" Font-Size="Small" />
                            <DetailTables>
                                <telerik:GridTableView HierarchyLoadMode="Client" AllowPaging="true" AllowSorting="true" DataMember="WineEntry" DataKeyNames="MedalColor" Width="100%" runat="server" ShowHeader="true">
                                    <PagerStyle Position="Top" Mode="NumericPages" />
                                    <ParentTableRelation>
                                        <telerik:GridRelationFields DetailKeyField="MedalColor" MasterKeyField="MedalColor" />
                                    </ParentTableRelation>
                                    <RowIndicatorColumn CurrentFilterFunction="NoFilter" FilterListOptions="VaryByDataType" Visible="False">
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="EntryID" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <Columns>
                                        <telerik:GridHyperLinkColumn HeaderText="Entry" FooterText="Entry" DataTextField="EntryID" DataNavigateUrlFields="CompetitionID, WineEntryID" DataNavigateUrlFormatString="/Competition/WineEntryAddEdit.aspx?CompetitionID={0}&WineEntryID={1}" SortExpression="EntryID" />
                                        <telerik:GridBoundColumn HeaderText="Wine Name" FooterText="Wine Name" DataField="WineName" />
                                        <telerik:GridBoundColumn HeaderText="Category" FooterText="Category" DataField="CatNum" />
                                        <telerik:GridBoundColumn HeaderText="AvgScore" FooterText="AvgScore" DataField="AvgScore" />
                                        <telerik:GridBoundColumn HeaderText="MedalColor" FooterText="MedalColor" DataField="MedalColor" />
                                    </Columns>
                                </telerik:GridTableView>
                            </DetailTables>
                            <RowIndicatorColumn CurrentFilterFunction="NoFilter" FilterListOptions="VaryByDataType" Visible="False">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn CurrentFilterFunction="NoFilter" FilterListOptions="VaryByDataType" Resizable="False">
                                <HeaderStyle Width="20px"></HeaderStyle>
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridBoundColumn DataField="MedalColor" />
                                <telerik:GridBoundColumn DataField="NumMedals" />
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnNewWine4" runat="server" Text="Add New Wine" OnClick="btnNewWine_Click" />
                </td>
                <td>
                    <telerik:RadNumericTextBox Width="50" ID="tbWineSwitch1" runat="server"
                        NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                        EnabledStyle-HorizontalAlign="Right" />&nbsp;
                    <telerik:RadButton ID="btnSwitch1" runat="server"
                        Icon-PrimaryIconUrl="/_resources/images/ico/Login-16x16.png" Text="View Wine Scores"
                        ToolTip="View" Width="150" ButtonType="StandardButton" />
                </td>
            </tr>
        </table>

        <br />
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
                PageSize="10" AllowCustomPaging="false" AllowSorting="true" runat="server" AutoGenerateColumns="false" ShowFooter="true">
                <PagerStyle Mode="NumericPages" Position="TopAndBottom" AlwaysVisible="false" />
                <ExportSettings IgnorePaging="true" />
                <MasterTableView TableLayout="Fixed" EnableViewState="true">
                    <SortExpressions>
                        <telerik:GridSortExpression FieldName="EntryID" SortOrder="Ascending" />
                    </SortExpressions>
                    <Columns>
                        <telerik:GridHyperLinkColumn HeaderText="Entry" FooterText="Entry" DataTextField="EntryID" DataNavigateUrlFields="CompetitionID, WineEntryID" DataNavigateUrlFormatString="/Competition/WineEntryAddEdit.aspx?CompetitionID={0}&WineEntryID={1}" SortExpression="EntryID" />
                        <telerik:GridBoundColumn HeaderText="Wine Name" FooterText="Wine Name" DataField="WineName" />
                        <telerik:GridBoundColumn HeaderText="Entrant Name" FooterText="Entrant Name" DataField="EntrantName" />
                        <telerik:GridBoundColumn HeaderText="AvgScore" FooterText="AvgScore" DataField="AvgScore" />
                        <telerik:GridBoundColumn HeaderText="MedalColor" FooterText="MedalColor" DataField="MedalColor" />
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

</asp:Content>
