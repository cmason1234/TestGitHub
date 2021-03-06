﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="WineScoreAddEdit.aspx.vb" Inherits="Wine.Web.WineScoreAddEdit" %>

<%@ Register Src="../_Controls/ctlErrorMessages.ascx" TagName="ErrorMessages" TagPrefix="ucErrorMessages" %>
<%@ MasterType TypeName="Wine.Web.Blank" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- ReSharper disable UseOfImplicitGlobalInFunctionScope --%>
    <script type="text/javascript">
        /*global $, jQuery, $find */

        function updateTotalScore(sender) {
            if (!sender._invalid) {
                var calcScoreId = $find('<%=tbCalcScore.ClientID%>');
                var judgeTotalId = $find('<%=tbJudgeScore.ClientID%>');
                var judgeTotal = judgeTotalId.get_value();
                var save1 = $find('<%=btnSave.ClientID%>');
                var save2 = $find('<%=btnSave2.ClientID%>');
                var monthly = jQuery('#<%=hfIsMonthlyComp.ClientID%>').val();
                var total;

                if (monthly) {
                    calcScoreId.set_value(judgeTotal);
                } else {
                    var clarity = $find('<%=tbClarity.ClientID%>').get_value();
                    var color = $find('<%=tbColor.ClientID%>').get_value();
                    var aroma = $find('<%=tbAroma.ClientID%>').get_value();
                    var ta = $find('<%=tbAcidity.ClientID%>').get_value();
                    var body = $find('<%=tbBody.ClientID%>').get_value();
                    var flavor = $find('<%=tbFlavor.ClientID%>').get_value();
                    var bitterness = $find('<%=tbBitterness.ClientID%>').get_value();
                    var finish = $find('<%=tbFinish.ClientID%>').get_value();
                    var quality = $find('<%=tbQuality.ClientID%>').get_value();
                    total = clarity + color + aroma + ta + body + flavor + bitterness + finish + quality;
                    calcScoreId.set_value(total);
                }

                total = calcScoreId.get_value();  // Go get the rounded value from Telerik.
                if (total !== judgeTotal) {
                    save1.set_enabled(false);
                    save2.set_enabled(false);
                    judgeTotalId.get_styles().EnabledStyle[0] += "background-color: red;";
                    judgeTotalId.updateCssClass();
                    calcScoreId.get_styles().ReadOnlyStyle[0] += "background-color: red;";
                    calcScoreId.updateCssClass();
                } else {
                    save1.set_enabled(true);
                    save2.set_enabled(true);
                    judgeTotalId.get_styles().EnabledStyle[0] += "background-color: white;";
                    judgeTotalId.updateCssClass();
                    calcScoreId.get_styles().ReadOnlyStyle[0] += "background-color: LightGray;";
                    calcScoreId.updateCssClass();
                }
            }
        };

    </script>
    <%-- ReSharper restore UseOfImplicitGlobalInFunctionScope --%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">

    <div class="fake-toolbar">
        <table>
            <tr>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnSave" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Save-16x16.png" Text="Save" ToolTip="Save" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;" id="delArea" runat="server">
                    <telerik:RadButton ID="btnDel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/delete-16x16.png" Text="Delete" ToolTip="Delete" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCancel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/cancel-16x16.png" Text="Back To Wine Entry" ToolTip="Back To Wine Entry" Width="150" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCreateNew" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/ico_new_16x16.gif" Text="Add New Wine Score" ToolTip="Add New" Width="150" ButtonType="StandardButton" Visible="false" />
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">
        <ucErrorMessages:ErrorMessages ID="ucErrorMessages" runat="server" />
        <asp:HiddenField ID="hfCompetitionID" runat="server" Visible="false" />
        <asp:HiddenField ID="hfWineEntryId" runat="server" Visible="false" />
        <asp:HiddenField ID="hfWineScoringID" runat="server" Visible="false" />
        <asp:HiddenField ID="hfIsMonthlyComp" runat="server" />
        <fieldset class="fieldset100Percent box_round box_shadow">
            <legend>General Info</legend>
            <table>
                <tr>
                    <td><b>Competion Name</b></td>
                    <td colspan="2">
                        <asp:TextBox CssClass="textBox" Width="350" ID="tbCompNameTextBox" runat="server" ReadOnly="true" BackColor="LightGray" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        Entry #&nbsp;
                        <telerik:RadNumericTextBox Width="50" ID="tbWineNum" runat="server"
                            NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                            EnabledStyle-HorizontalAlign="Right" ReadOnly="true" BackColor="LightGray" />
                    </td>

                    <td rowspan="3" style="text-align: right; vertical-align: middle;">
                        <asp:Label ID="lblEnteredByText" runat="server"><b>Entered By:</b><br /></asp:Label>
                        <asp:Label ID="lblEnteredBy" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblValidText" runat="server" Visible="false"><b>Validated By:</b><br /></asp:Label>
                        <asp:Label ID="lblValidatedBy" runat="server" Visible="false"></asp:Label>
                        <telerik:RadButton ID="btnValidate" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Enable-16x16.png" Text="Validate Wine Score" ToolTip="Validate" Width="150" ButtonType="StandardButton" />
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        Wine Name&nbsp;
                        <telerik:RadTextBox ID="tbWineName" runat="server" Width="350" EnabledStyle-HorizontalAlign="Left" ReadOnly="true" BackColor="LightGray" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <table>
                            <tr>
                                <td>
                                    Table Num&nbsp;
                                    <telerik:RadNumericTextBox Width="50" ID="tbTableNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" ReadOnly="true" BackColor="LightGray" />
                                </td>
                                <td>
                                    Flight Num&nbsp;
                                    <telerik:RadNumericTextBox Width="50" ID="tbFlightNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" ReadOnly="true" BackColor="LightGray" />
                                </td>
                                <td style="white-space: nowrap;">
                                    Seq Num&nbsp;
                                    <telerik:RadNumericTextBox Width="50" ID="tbSeqNum" runat="server"
                                        MinValue="0" MaxValue="999999999" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                                        EnabledStyle-HorizontalAlign="Right" ReadOnly="true" BackColor="LightGray" />
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space: nowrap;">
                                    Cat Number&nbsp;
                                    <telerik:RadTextBox CssClass="textBox" Width="50" ID="tbCategoryNumber" runat="server"
                                        EmptyMessage="Cat Num" ReadOnly="true" BackColor="LightGray" />
                                </td>
                                <td style="white-space: nowrap;">
                                    Vintage&nbsp;
                                    <asp:TextBox CssClass="textBox" Width="50" ID="tbVintage" runat="server" emptyMessage="Vintage" ReadOnly="true" BackColor="LightGray" />
                                </td>

                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td colspan="3">
                        Judge #&nbsp;
                        <telerik:RadNumericTextBox Width="50" ID="tbJudgeNum" runat="server"
                            MinValue="0" MaxValue="50" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                            EnabledStyle-HorizontalAlign="Right" />
                        <asp:RequiredFieldValidator ID="judgeNumRequiredFieldValidator" runat="server" ControlToValidate="tbJudgeNum" ForeColor="Red">* Judge # is Required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr id="judgenameTR" runat="server" visible="false">
                    <td colspan="3">
                        Judge Name&nbsp;<telerik:RadTextBox Width="125" ID="tbJudgeName" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                </tr>
                <div id="divEnterScores" runat="server">
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
                </div>
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
                <tr>
                    <td>
                        Avg Score<br />
                        <telerik:RadTextBox CssClass="textbox" Width="75" ID="tbAvgScore" runat="server" ReadOnly="true" BackColor="LightGray" />
                    </td>
                    <td></td>
                    <td>
                        Medal<br />
                        <telerik:RadTextBox CssClass="textbox" Width="100" ID="tbMedalColor" runat="server" ReadOnly="true" BackColor="LightGray" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadButton ID="btnSave2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Save-16x16.png" Text="Save" ToolTip="Save" Width="100" ButtonType="StandardButton" />
                    </td>
                    <td></td>
                    <td>
                        <telerik:RadButton ID="btnCreateNew2" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/ico_new_16x16.gif" Text="Add New Wine Score" ToolTip="Add New" Width="150" ButtonType="StandardButton" Visible="false" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <br class="clear" />
        <br />

        <fieldset class="fieldset100Percent box_round box_shadow">
            <legend>Switch Wine #</legend>
            <table>
                <tr>
                    <td>
                        Switch Wine #
                    </td>
                    <td>
                        <telerik:RadNumericTextBox Width="50" ID="tbWineSwitch" runat="server"
                            NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"
                            EnabledStyle-HorizontalAlign="Right" />
                    </td>
                    <td>
                        <telerik:RadButton ID="btnSwitch" runat="server"
                            Icon-PrimaryIconUrl="/_resources/images/ico/Login-16x16.png" Text="Score Different Wine"
                            ToolTip="Score" Width="150" ButtonType="StandardButton" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <br class="clear" />
        <br />

    </div>
</asp:Content>
