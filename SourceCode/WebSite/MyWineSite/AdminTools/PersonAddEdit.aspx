<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage/Blank.Master"
    CodeBehind="PersonAddEdit.aspx.vb" Inherits="Wine.Web.PersonAddEdit" %>

<%@ MasterType TypeName="Wine.Web.Blank" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <div class="fake-toolbar">
        <table>
            <tr>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnSave" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/Save-16x16.png" Text="Save" ToolTip="Save" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;" id="delArea" runat="server">
                    <telerik:RadButton ID="btnDel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/delete-16x16.png"  Text="Delete" ToolTip="Delete" Width="100" ButtonType="StandardButton" />
                </td>
                <td style="border-right-width: 1px; border-right-style: solid; border-right-color: #939393;">
                    <telerik:RadButton ID="btnCancel" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/cancel-16x16.png"  Text="Cancel" ToolTip="Cancel" Width="100" ButtonType="StandardButton" />
                </td>
            </tr>
        </table>
    </div>

    <div runat="server" id="divPadHasLI" class="pad hasLI ">

        <br />
        <asp:HiddenField ID="hfPersonID" runat="server" Visible="false" />
        <fieldset class="fieldset100Percent box_round box_shadow">
            <legend>General Info</legend>
            <br />
            <table>
                <tr>
                    <td>
                        First&nbsp;<asp:RequiredFieldValidator ID="firstNameRequiredFieldValidator" runat="server" ControlToValidate="tbFirstNameTextBox" ErrorMessage="First Name is Required">*</asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="125" ID="tbFirstNameTextBox" runat="server" emptymessage="First Name" />
                    </td>
                    <td>
                        Middle
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="125" ID="tbMiddleNameTextBox" runat="server" emptymessage="Middle Name" />
                    </td>
                    <td>
                        Last&nbsp;<asp:RequiredFieldValidator ID="lastNameRequiredFieldValidator1" runat="server" ControlToValidate="tbLastNameTextBox" ErrorMessage="Last Name is Required">*</asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" Width="125" ID="tbLastNameTextBox" runat="server" emptymessage="Last Name" />
                    </td>
                </tr>

                <tr>
                    <td>
                        EMail
                    </td>
                    <td colspan="3">
                        <asp:TextBox CssClass="textBox" ID="tbEmailTextBox" runat="server" Width="275px" emptymessage="Email" />
                    </td>

                </tr>

                <tr>
                    <td>
                        Username&nbsp;<asp:RequiredFieldValidator ID="userNameRequiredFieldValidator" runat="server" ControlToValidate="tbUserNameTextBox" ErrorMessage="UserName is Required">*</asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" ID="tbUserNameTextBox" runat="server" emptymessage="Username" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Password&nbsp;<asp:RequiredFieldValidator ID="passwordRequiredFieldValidator" runat="server" ControlToValidate="tbPasswordTextBox" ErrorMessage="Password is Required">*</asp:RequiredFieldValidator>
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" ID="tbPasswordTextBox" runat="server" Style="left: 0; position: relative" TextMode="Password" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Confirm Password
                    </td>
                    <td>
                        <asp:TextBox CssClass="textBox" ID="tbConfirmPasswordTextBox" runat="server" TextMode="Password" />
                    </td>
                    <td colspan="4" id="tdChgPassword" runat="server">
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="tbConfirmPasswordTextBox" ControlToValidate="tbPasswordTextBox" ErrorMessage="Confirm password does not match " />
                        <br />
                        <telerik:RadButton ID="btnChangePassword" runat="server" Icon-PrimaryIconUrl="/_resources/images/ico/PasswordChange-16x16.png"  Text="Change Password" ToolTip="Change Password" ButtonType="StandardButton" />
                    </td>
                </tr>
            </table>

        </fieldset>
        <br class="clear" />
        <br />

    </div>
</asp:Content>
