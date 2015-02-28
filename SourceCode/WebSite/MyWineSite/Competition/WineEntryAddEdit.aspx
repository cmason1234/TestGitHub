<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="WineEntryAddEdit.aspx.vb" Inherits="Wine.Web.WineEntryAddEdit" %>

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
                        Text="Add New Score" ToolTip="Add New Score" Width="125" ButtonType="StandardButton" OnClick="btnNewScore_Click" />
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
                        Text="Add New Score" ToolTip="Add New Score" Width="125" ButtonType="StandardButton" AutoPostBack="false" OnClick="btnNewScore_Click" />
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

</asp:Content>

<asp:Content ID="Contnet3" ContentPlaceHolderID="cphExtra" runat="server">
    <link rel="stylesheet" href="/_resources/js/jQuery/jquery-ui-1.11.3.css">
    <script src="/_resources/js/jQuery/jquery-1.11.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.3/jquery-ui.js"></script>
    <script>
        $(function () {
            var dialog, form,
            // From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
            emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
            name = $("#name"),
            email = $("#email"),
            password = $("#password"),
            allFields = $([]).add(name).add(email).add(password),
            tips = $(".validateTips");
            function updateTips(t) {
                tips
                .text(t)
                .addClass("ui-state-highlight");
                setTimeout(function () {
                    tips.removeClass("ui-state-highlight", 1500);
                }, 500);
            }
            function checkLength(o, n, min, max) {
                if (o.val().length > max || o.val().length < min) {
                    o.addClass("ui-state-error");
                    updateTips("Length of " + n + " must be between " +
                    min + " and " + max + ".");
                    return false;
                } else {
                    return true;
                }
            }
            function checkRegexp(o, regexp, n) {
                if (!(regexp.test(o.val()))) {
                    o.addClass("ui-state-error");
                    updateTips(n);
                    return false;
                } else {
                    return true;
                }
            }
            function addUser() {
                var valid = true;
                allFields.removeClass("ui-state-error");
                valid = valid && checkLength(name, "username", 3, 16);
                valid = valid && checkLength(email, "email", 6, 80);
                valid = valid && checkLength(password, "password", 5, 16);
                valid = valid && checkRegexp(name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter.");
                valid = valid && checkRegexp(email, emailRegex, "eg. ui@jquery.com");
                valid = valid && checkRegexp(password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9");
                if (valid) {
                    $("#users tbody").append("<tr>" +
                    "<td>" + name.val() + "</td>" +
                    "<td>" + email.val() + "</td>" +
                    "<td>" + password.val() + "</td>" +
                    "</tr>");
                    dialog.dialog("close");
                }
                return valid;
            }
            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 300,
                width: 350,
                modal: true,
                buttons: {
                    "Create an account": addUser,
                    Cancel: function () {
                        dialog.dialog("close");
                    }
                },
                close: function () {
                    form[0].reset();
                    allFields.removeClass("ui-state-error");
                }
            });
            form = dialog.find("form").on("submit", function (event) {
                event.preventDefault();
                addUser();
            });
            $("#create-user").button().on("click", function () {
                dialog.dialog("open");
            });
        });
    </script>
    <div id="dialog-form" title="Create new user">
        <p class="validateTips">All form fields are required.</p>
        <form>
        <fieldset>
            <label for="name">Name</label>
            <input type="text" name="name" id="name" value="Jane Smith" class="text ui-widget-content ui-corner-all">
            <label for="email">Email</label>
            <input type="text" name="email" id="email" value="jane@smith.com" class="text ui-widget-content ui-corner-all">
            <label for="password">Password</label>
            <input type="password" name="password" id="password" value="xxxxxxx" class="text ui-widget-content ui-corner-all">
            <!-- Allow form submission with keyboard without duplicating the dialog button -->
            <input type="submit" tabindex="-1" style="position: absolute; top: -1000px">
        </fieldset>
        </form>
    </div>
    <div id="users-contain" class="ui-widget">
        <h1>Existing Users:</h1>
        <table id="users" class="ui-widget ui-widget-content">
            <thead>
                <tr class="ui-widget-header ">
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>John Doe</td>
                    <td>john.doe@example.com</td>
                    <td>johndoe1</td>
                </tr>
            </tbody>
        </table>
    </div>
    <button id="create-user">Create new user</button>
</asp:Content>
