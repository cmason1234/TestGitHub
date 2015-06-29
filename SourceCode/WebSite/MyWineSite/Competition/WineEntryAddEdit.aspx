<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="WineEntryAddEdit.aspx.vb" Inherits="Wine.Web.WineEntryAddEdit" %>

<%@ Register Src="../_Controls/ctlErrorMessages.ascx" TagName="ErrorMessages" TagPrefix="ucErrorMessages" %>
<%@ MasterType TypeName="Wine.Web.Blank" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="/_resources/js/jQuery/jquery-ui-1.11.3.css">
    <script src="/_resources/js/jQuery/jquery-1.11.0.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <div class="fake-toolbar">
        <table >
            <tr>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnSave" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Save-16x16.png" Text="Save" ToolTip="Save" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;" id="delArea" runat="server">
                    <telerik:RadButton ID="btnDel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/delete-16x16.png" Text="Delete" ToolTip="Delete" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCancel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/cancel-16x16.png" Text="Back To Comp Add/Edit" ToolTip="Back To Comp Add/Edit" Width="175" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCreateNewWineEntry" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/ico_new_16x16.gif" Text="Add New Wine Entry" ToolTip="Add New Wine Entry" Width="150" ButtonType="StandardButton" />
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">
        <ucErrorMessages:ErrorMessages ID="ucErrorMessages" runat="server" />
        <asp:HiddenField ID="hfWineEntryId" runat="server" Visible="false" />
        <asp:HiddenField ID="hfCompetitionID" runat="server" Visible="false" />
        <fieldset class="fieldset100Percent box_round box_shadow">
            <legend>General Info</legend>
            <table>
                <tr>
                    <td><b>Competion Name</b></td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="350" ID="tbCompNameTextBox" runat="server" ReadOnly="true" BackColor="LightGray" />
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
                                    <b>Table Num</b>
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="50" ID="tbTableNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" />
                                </td>
                                <td style="white-space: nowrap;">
                                    <b>Flight Num</b>
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="50" ID="tbFlightNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" />
                                </td>
                                <td style="white-space: nowrap;">
                                    <b>Seq Num</b>
                                </td>
                                <td>
                                    <telerik:RadNumericTextBox Width="50" ID="tbSeqNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" />
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space: nowrap;"><b>Category Number</b></td>
                                <td style="width: 15%;">
                                    <asp:TextBox CssClass="textBox" Width="50" ID="tbCategoryNumber" runat="server" emptyMessage="Cat Num" />
                                </td>
                                <td style="white-space: nowrap;"><b>Vintage</b></td>
                                <td>
                                    <asp:TextBox CssClass="textBox" Width="50" ID="tbVintage" runat="server" emptyMessage="Vintage" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Avg Score</b>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="textbox" Width="75" ID="tbAvgScore" runat="server" ReadOnly="true" BackColor="LightGray" />
                                </td>
                                <td>
                                    <b>Medal</b>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="textbox" Width="100" ID="tbMedalColor" runat="server" ReadOnly="true" BackColor="LightGray" />
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
        <table style="width: 85%">
            <tr>
                <td style="width: 33%;">
                    <telerik:RadButton ID="btnNewScore" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Add-16x16.png"
                        Text="Add New Score" ToolTip="Add New Score" Width="125" ButtonType="StandardButton" AutoPostBack="false" />
                    <div style="display: none;">
                        <asp:Button ID="btnAddScore" runat="server" Text="Add Score" />
                    </div>
                </td>
                <td style="width: 33%;">
                    <telerik:RadButton ID="btnValidate" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Enable-16x16.png"
                        Text="Validate Scores" ToolTip="Validate Scores" Width="125" ButtonType="StandardButton" OnClick="btnValidate_Click" />
                </td>
                <td style="width: 33%;">
                    <telerik:RadButton ID="btnLock" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Lock-16x16.png"
                        Text="Lock Scores" ToolTip="Lock Scores" Width="125" ButtonType="StandardButton" OnClick="btnChangeLock_Click" />
                    <telerik:RadButton ID="btnUnlock" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Lock-open-16x16.png"
                        Text="UnLock Scores" ToolTip="UnLock Scores" Width="125" ButtonType="StandardButton" OnClick="btnChangeLock_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <span style="margin-left: 12px;">
                        <asp:Literal ID="litScoreCount" EnableViewState="false" runat="server" />
                    </span>
                    <div style="margin-left: 4px;">
                        <telerik:RadGrid ID="dgGridScoreComp" Width="85%" AllowPaging="true" PageSize="100"
                            AllowCustomPaging="false" AllowSorting="true" runat="server" AutoGenerateColumns="false"
                            AllowMultiRowSelection="true">
                            <PagerStyle Mode="NumericPages" Position="TopAndBottom" AlwaysVisible="false" />
                            <ExportSettings IgnorePaging="true" />
                            <MasterTableView TableLayout="Fixed" EnableViewState="true">
                                <SortExpressions>
                                    <telerik:GridSortExpression FieldName="JudgeNum" SortOrder="Ascending" />
                                </SortExpressions>
                                <Columns>
                                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn" HeaderStyle-Width="25px"
                                        ItemStyle-Width="25px" />
                                    <telerik:GridHyperLinkColumn HeaderText="Judge" DataTextField="JudgeNum" DataNavigateUrlFields="WineEntryID, WineScoringID, CompetitionID"
                                        DataNavigateUrlFormatString="/Competition/WineScoreAddEdit.aspx?WineEntryID={0}&WineScoringID={1}&CompetitionID={2}"
                                        ItemStyle-Wrap="true" SortExpression="JudgeNum" />
                                    <telerik:GridBoundColumn Visible="false" DataField="WineScoringID" UniqueName="WineScoringID" />
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
                                    <telerik:GridBoundColumn HeaderText="Entered" DataField="EnteredBy" />
                                    <telerik:GridBoundColumn HeaderText="Validated" DataField="ValidatedBy" />
                                </Columns>
                            </MasterTableView>
                            <HeaderStyle HorizontalAlign="Left" />
                            <ClientSettings EnableRowHoverStyle="true" AllowColumnsReorder="true" ReorderColumnsOnClient="true">
                                <Scrolling AllowScroll="false" EnableVirtualScrollPaging="true" SaveScrollPosition="True"></Scrolling>
                                <Selecting AllowRowSelect="true" UseClientSelectColumnOnly="true" />
                                <Resizing AllowRowResize="False" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" AllowColumnResize="true"></Resizing>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewScore2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Add-16x16.png"
                        Text="Add New Score" ToolTip="Add New Score" Width="125" ButtonType="StandardButton" AutoPostBack="false" />
                </td>
                <td>
                    <telerik:RadButton ID="btnValidate2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Enable-16x16.png"
                        Text="Validate Scores" ToolTip="Validate Scores" Width="125" ButtonType="StandardButton" OnClick="btnValidate_Click" />
                </td>
                <td>
                    <telerik:RadButton ID="btnLock2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Lock-16x16.png"
                        Text="Lock Scores" ToolTip="Lock Scores" Width="125" ButtonType="StandardButton" OnClick="btnChangeLock_Click" />
                    <telerik:RadButton ID="btnUnLock2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Lock-open-16x16.png"
                        Text="UnLock Scores" ToolTip="UnLock Scores" Width="125" ButtonType="StandardButton" OnClick="btnChangeLock_Click" />
                </td>
            </tr>
        </table>
        <br />

        <br />
        <br />

    </div>

    <telerik:RadTextBox ID="tbJudgeNum2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbClarity2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbColor2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbAroma2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbAcidity2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbBody2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbFlavor2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbBitterness2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbFinish2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbQuality2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbJudgeScore2" runat="server" style="display: none;" />
    <telerik:RadNumericTextBox ID="tbCalcScore2" runat="server" style="display: none;" />

    <div style="display: none;">
        <div id="dialog-form" title="Add New Score">
            <p class="validateTips">All form fields are required.</p>
            <fieldset>
                <table>
                    <tr>
                        <td colspan="3">
                            Judge #&nbsp;
                        <telerik:RadNumericTextBox Width="50" ID="tbJudgeNum" runat="server"
                            MinValue="0" MaxValue="50" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                            EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                            <span style="display: none; color: red;" id="spnJudgeNum">* Judge # is Required</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px;">Clarity (1)</td>
                        <td style="width: 140px;">Color (2)</td>
                        <td style="width: 155px;">Aroma (4)</td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbClarity" runat="server"
                                MinValue="0" MaxValue="1" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbColor" runat="server"
                                MinValue="0" MaxValue="2" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbAroma" runat="server"
                                MinValue="0" MaxValue="4" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Acidity (1)</td>
                        <td>Body (2)</td>
                        <td>Flavor (4)</td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbAcidity" runat="server"
                                MinValue="0" MaxValue="1" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbBody" runat="server"
                                MinValue="0" MaxValue="2" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbFlavor" runat="server"
                                MinValue="0" MaxValue="4" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Bitterness (1)</td>
                        <td>Finish (1)</td>
                        <td>Quality (4)</td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbBitterness" runat="server"
                                MinValue="0" MaxValue="1" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbFinish" runat="server"
                                MinValue="0" MaxValue="1" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox Width="50" ID="tbQuality" runat="server"
                                MinValue="0" MaxValue="4" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                    </tr>
                    <tr>
                        <td>Judge Score</td>
                        <td></td>
                        <td>Calc Score</td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadNumericTextBox Width="75" ID="tbJudgeScore" runat="server"
                                MinValue="0" MaxValue="20" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ClientEvents-OnBlur="updateTotalScore" />
                        </td>
                        <td></td>
                        <td>
                            <telerik:RadNumericTextBox Width="75" ID="tbCalcScore" runat="server"
                                MinValue="0" MaxValue="20" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="4"
                                EnabledStyle-HorizontalAlign="Right" ReadOnly="true" BackColor="LightGray" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>

    <script src="/_resources/js/jQuery/jquery-ui-1.11.3.js"></script>
    <script>
        var WINE = WINE || {};
        WINE.EntryAddEdit = {};

        jQuery(document).ready(function () {

        });


        WINE.EntryAddEdit.openPopup = function () {
            "use strict";

            jQuery("#dialog-form").dialog({
                autoOpen: false,
                height: 380,
                width: 350,
                modal: true,
                buttons: [{
                    id: "btn-save",
                    text: "Save Wine Score",
                    click: WINE.EntryAddEdit.saveWineScore
                },
                {
                    id: "btn-cancel",
                    text: "Cancel",
                    click: function () {
                        jQuery("#dialog-form").dialog("close");
                    }
                }],
                close: function () {
                }
            });
            jQuery('#btn-save').button("option", "disabled", true);
            jQuery("#dialog-form").dialog("open");
        };

        WINE.EntryAddEdit.saveWineScore = function () {
            "use strict";
            $find('<%= tbJudgeNum2.ClientID%>').set_value($find('<%=tbJudgeNum.ClientID%>').get_value());
            $find('<%= tbClarity2.ClientID%>').set_value($find('<%= tbClarity.ClientID%>').get_value());
            $find('<%= tbColor2.ClientID%>').set_value($find('<%=tbColor.ClientID%>').get_value());
            $find('<%= tbAroma2.ClientID%>').set_value($find('<%=tbAroma.ClientID%>').get_value());

            $find('<%= tbAcidity2.ClientID%>').set_value($find('<%=tbAcidity.ClientID%>').get_value());
            $find('<%= tbBody2.ClientID%>').set_value($find('<%=tbBody.ClientID%>').get_value());
            $find('<%= tbFlavor2.ClientID%>').set_value($find('<%=tbFlavor.ClientID%>').get_value());

            $find('<%= tbBitterness2.ClientID%>').set_value($find('<%=tbBitterness.ClientID%>').get_value());
            $find('<%= tbFinish2.ClientID%>').set_value($find('<%=tbFinish.ClientID%>').get_value());
            $find('<%= tbQuality2.ClientID%>').set_value($find('<%=tbQuality.ClientID%>').get_value());
            
            $find('<%= tbCalcScore2.ClientID%>').set_value($find('<%=tbCalcScore.ClientID%>').get_value());
            $find('<%= tbJudgeScore2.ClientID%>').set_value($find('<%=tbJudgeScore.ClientID%>').get_value());

            var clickButton = document.getElementById("<%= btnAddScore.ClientID%>");
            clickButton.click();
        };

        function updateTotalScore(sender, eventArgs) {
            "use strict";
            var newScore = 0;
            if (!sender._invalid) {
                var judgeNumval = $find('<%=tbJudgeNum.ClientID%>').get_value();
                var clarity = $find('<%=tbClarity.ClientID%>').get_value();
                var color = $find('<%=tbColor.ClientID%>').get_value();
                var aroma = $find('<%=tbAroma.ClientID%>').get_value();
                var ta = $find('<%=tbAcidity.ClientID%>').get_value();
                var body = $find('<%=tbBody.ClientID%>').get_value();
                var flavor = $find('<%=tbFlavor.ClientID%>').get_value();
                var bitterness = $find('<%=tbBitterness.ClientID%>').get_value();
                var finish = $find('<%=tbFinish.ClientID%>').get_value();
                var quality = $find('<%=tbQuality.ClientID%>').get_value();
                var total = clarity + color + aroma + ta + body + flavor + bitterness + finish + quality;
                var calcScoreId = $find('<%=tbCalcScore.ClientID%>');
                var judgeTotalId = $find('<%=tbJudgeScore.ClientID%>');
                var judgeTotal = judgeTotalId.get_value();
                var save1 = jQuery('#btn-save');
                var bDisableSave = false;

                calcScoreId.set_value(total);
                total = calcScoreId.get_value();  // Go get the rounded value from Telerik.
                if (total !== judgeTotal) {
                    bDisableSave = true;
                    judgeTotalId.get_styles().EnabledStyle[0] += "background-color: red;";
                    judgeTotalId.updateCssClass();
                    calcScoreId.get_styles().ReadOnlyStyle[0] += "background-color: red;";
                    calcScoreId.updateCssClass();
                } else {
                    judgeTotalId.get_styles().EnabledStyle[0] += "background-color: white;";
                    judgeTotalId.updateCssClass();
                    calcScoreId.get_styles().ReadOnlyStyle[0] += "background-color: LightGray;";
                    calcScoreId.updateCssClass();
                }
                if (judgeNumval.length === 0) {
                    bDisableSave = true;
                    jQuery('#spnJudgeNum').show();
                } else {
                    jQuery('#spnJudgeNum').hide();
                }

                save1.button("option", "disabled", bDisableSave);

            }
        };

    </script>
</asp:Content>
