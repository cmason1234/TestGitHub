<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="WineEntryAddEdit.aspx.vb" Inherits="Wine.Web.WineEntryAddEdit" %>

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
                    <telerik:RadButton ID="btnCancel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/cancel-16x16.png" Text="Cancel" ToolTip="Cancel" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCreateNewWineEntry" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/ico_new_16x16.gif" Text="Add New Wine Entry" ToolTip="Add New Wine Entry" Width="150" ButtonType="StandardButton" />
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">

        <br />
        <asp:HiddenField ID="hfWineEntryId" runat="server" Visible="false" />
        <asp:HiddenField ID="hfCompetitionID" runat="server" Visible="false" />
        <fieldset class="fieldset100Percent box_round box_shadow">
            <legend>General Info</legend>
            <table>
                <tr>
                    <td><b>Competion Name</b></td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="350" ID="tbCompNameTextBox" runat="server" ReadOnly="true"/>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%">
                        <b>Entry Number</b>
                    </td>
                    <td>
                        <telerik:RadNumericTextBox Width="50" ID="tbEntryNumTextBox" runat="server" EmptyMessage="Entry Number"
                            MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                            EnabledStyle-HorizontalAlign="Right" />
                        <asp:RequiredFieldValidator ID="entryNumRequiredFieldValidator" runat="server" ControlToValidate="tbEntryNumTextBox" ForeColor="Red">* Entry Number is Required</asp:RequiredFieldValidator>
                    </td>

                </tr>
                <tr>
                    <td>
                        <b>Wine Name</b>
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="350" ID="tbWineName" runat="server" emptymessage="Wine Name" />
                    </td>
                </tr>

                <tr>
                    <td>
                        <b>Entrant Name</b>
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="350" ID="tbEntrantName" runat="server" emptymessage="Entrant Name" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Category Name</b>
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="350" ID="tbCategoryName" runat="server" emptymessage="Category Name" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table>
                            <tr>
                                <td>
                                    <b>Table Num</b>&nbsp;
                                    <telerik:RadNumericTextBox Width="50" ID="tbTableNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" />
                                </td>
                                <td>
                                    <b>Flight Num</b>&nbsp;
                                    <telerik:RadNumericTextBox Width="50" ID="tbFlightNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" />
                                </td>
                                <td>
                                    <b>Seq Num</b>&nbsp;
                                    <telerik:RadNumericTextBox Width="50" ID="tbSeqNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Avg Score</b>&nbsp;
                                    <asp:TextBox CssClass="textbox" Width="75" ID="tbAvgScore" runat="server" ReadOnly="true" />
                                </td>
                                <td>
                                    <b>Medal</b>&nbsp;
                                    <asp:TextBox CssClass="textbox" Width="100" ID="tbMedalColor" runat="server" ReadOnly="true" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

        </fieldset>
        <br class="clear" />
        <br />
    </div>

    <div id="divScoreList" runat="server">
        <telerik:RadButton ID="btnNewScore" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Add-16x16.png" Text="Add New Score" ToolTip="Add New Score" Width="125" ButtonType="StandardButton" OnClick="btnNewScore_Click" />
        <br />
        <span style="margin-left: 12px;">
            <asp:Literal ID="litScoreCount" EnableViewState="false" runat="server" />
        </span>
        <div style="margin-left: 4px;">

            <telerik:RadGrid ID="dgGridScoreComp" Width="85%" AllowPaging="true" PageSize="100" AllowCustomPaging="false" AllowSorting="False" runat="server" AutoGenerateColumns="false">
                <PagerStyle Mode="NumericPages" Position="TopAndBottom" AlwaysVisible="false" />
                <ExportSettings IgnorePaging="true" />
                <MasterTableView TableLayout="Fixed" EnableViewState="false">
                    <Columns>
                        <telerik:GridHyperLinkColumn HeaderText="Judge" DataTextField="JudgeID" DataNavigateUrlFields="WineEntryID, WineScoringID, CompetitionID" 
                            DataNavigateUrlFormatString="/Competition/WineScoreAddEdit.aspx?WineEntryID={0}&WineScoringID={1}&CompetitionID={2}" 
                             ItemStyle-Wrap="true"/>
                        <telerik:GridBoundColumn HeaderText="Score" DataField="Score" />
                        <telerik:GridBoundColumn HeaderText="JudgeScore" DataField="JudgeTotal" />
                        <telerik:GridBoundColumn HeaderText="Clarity" DataField="Clarity" />
                        <telerik:GridBoundColumn HeaderText="Color" DataField="Color" />
                        <telerik:GridBoundColumn HeaderText="Aroma" DataField="Aroma" />
                        <telerik:GridBoundColumn HeaderText="Ta" DataField="Ta" />
                        <telerik:GridBoundColumn HeaderText="Texture" DataField="Texture" />
                        <telerik:GridBoundColumn HeaderText="Flavor" DataField="Flavor" />
                        <telerik:GridBoundColumn HeaderText="Bitterness" DataField="Bitterness" />
                        <telerik:GridBoundColumn HeaderText="Finish" DataField="Finish" />
                        <telerik:GridBoundColumn HeaderText="Quality" DataField="Quality" />
                        <telerik:GridBoundColumn HeaderText="Entered By" DataField="Username" />
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
        <telerik:RadButton ID="btnNewScore2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Add-16x16.png" Text="Add New Score" ToolTip="Add New Score" Width="125" ButtonType="StandardButton" OnClick="btnNewScore_Click" />

        <br />
        <br />

    </div>

</asp:Content>
