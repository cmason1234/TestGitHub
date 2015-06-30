<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LoginPub.aspx.vb" Inherits="Wine.Web.LoginPub" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style type="text/css">
        body 
        {
            font-family: Helvetica, Arial, sans-serif;
	        font-size: 14px;
        }

        .login_box_headline {
	        font-family: Helvetica, Arial, sans-serif;
	        font-size: 14px;
	        font-weight: bold;
	        color: #555;
	        text-decoration: none;
	        text-align: left;
        }


        .btn2
        {
            border: 1px solid #828282;
            background: transparent url(/_resources/images/toolbar-bkg.png) repeat-x;
            cursor: pointer;
            padding: 5px;
        }

        .widget 
        {
	        background						: transparent; 
	        margin							: 0;
        }

        /*--change this for color update (This is the top and bottom background areas)*/
        .widget .p3_B1, .widget .p3_B2, .widget .p3_B3
        {
	        background-color				: #fff;
        }

        .widget .p3_B1_b, .widget .p3_B2_b, .widget .p3_B3_b
        {
	        background-color				: #fff;
        }

        .widget .p3_B1, .widget .p3_B2
        {
	        height							: 1px;
        }

        .widget .p3_B1_b, .widget .p3_B2_b
        {
	        height							: 1px;
        }

        /*--Color the borders (left and right)*/
        .widgetContent, .widget .p3_B2, .widget .p3_B3
        {
	        border-left						: 1px solid #252525; 
	        border-right					: 1px solid #252525;
        }

            /*--Color the borders (top and bottom)*/
        .widget .p3_B1,.widget .p3_B1_b
        {
	        background						: #252525;
        }

        .widgetContent, .widget .p3_B2_b, .widget .p3_B3_b
        {
	        border-left						: 1px solid #252525; 
	        border-right					: 1px solid #252525;
        }

        /*--Color the borders (left and right)  ============= RED ==============*/
        .widgetContentr, .widget .p3_B2r, .widget .p3_B3r
        {
	        border-left						: 1px solid red; 
	        border-right					: 1px solid red;
        }

            /*--Color the borders (top and bottom)*/
        .widget .p3_B1r,.widget .p3_B1_br
        {
	        background						: red;
        }

        .widgetContentr, .widget .p3_B2_br, .widget .p3_B3_br
        {
	        border-left						: 1px solid red; 
	        border-right					: 1px solid red;
        }

     

        .widgetContent 
        {
	        Padding							: 35px;	
	        Color							: #000;
	        text-align						: left;
        }

        .widgetContentr 
        {
	        Padding							: 5px 15px 5px 15px;	
	        Color							: red;
	        text-align						: left;
        }

        .widgetContentr table
        {
            color :#000;
        }

        /*--3px angle top style--*/
        .p3_B1, .p3_B2, .p3_B3 {display:block; overflow:hidden;height:1px;font-size:1px;}
        .p3_B2, .p3_B3 {border-width:0 1px;}
        .p3_B1 {margin:0 3px; }
        .p3_B2 {margin:0 2px;}
        .p3_B3 {margin:0 1px;}


        /*--3px angle bot style--*/
        .p3_B1_b, .p3_B2_b, .p3_B3_b {display:block; overflow:hidden;height:1px;font-size:1px;}
        .p3_B2_b, .p3_B3_b {border-width:0 1px;}
        .p3_B1_b {margin:0 3px; }
        .p3_B2_b {margin:0 2px;}
        .p3_B3_b {margin:0 1px;}


        /*--3px angle tab bot style--*/       
        .p3_B3_b {border-width:0 1px;}


        /* ============= RED ============= */
        /*--3px angle top style--*/
        .p3_B1r, .p3_B2r, .p3_B3r {display:block; overflow:hidden;height:1px;font-size:1px;}
        .p3_B2r, .p3_B3r {border-width:0 1px;}
        .p3_B1r {margin:0 3px; }
        .p3_B2r {margin:0 2px;}
        .p3_B3r {margin:0 1px;}


        /*--3px angle bot style--*/
        .p3_B1_br, .p3_B2_br, .p3_B3_br {display:block; overflow:hidden;height:1px;font-size:1px;}
        .p3_B2_br, .p3_B3_br {border-width:0 1px;}
        .p3_B1_br {margin:0 3px; }
        .p3_B2_br {margin:0 2px;}
        .p3_B3_br {margin:0 1px;}


        /*--3px angle tab bot style--*/       
        .p3_B3_br {border-width:0 1px;}

        /* ============= END RED ============= */

        .xcap 
        {
	        display							: block; 
	        background						: transparent; 
	        font-size						: 1px;
        }

        #logo
        {
            width: 89px;
            height: 94px;
            position: absolute;
            margin-top: -45px;
            margin-left: -35px;    
        }

        .textBox
        {
            border: 1px solid #cecece;    
            height: 20px;
        }

        .msgErr
        {
            border: solid 1px #cecece; 
            padding: 5px 5px 5px 25px;
            background: #ffffcc url(/_resources/images/ico/msgErr-16x16.png) no-repeat;
            background-position: 5px 5px;
             font-size: 10pt;
            font-weight: normal;
        }

        .msgInfo
        {
            border: solid 1px #cecece; 
            padding: 5px 5px 5px 25px;
            background: #ffffcc url(/_resources/images/ico/msgInfo-16x16.png) no-repeat;
            background-position: 5px 5px;
             font-size: 10pt;
            font-weight: normal;
        }

        .msgRedInfo
        {
            border: solid 1px #cecece; 
            padding: 5px 5px 5px 45px;
            background: #ffffcc url(/_resources/images/ico/msgErr-16x16.png) no-repeat;
            background-position: 5px 5px;
             font-size: 10pt;
            font-weight: normal;
        }
    </style>

</head>
<body >
    <form id="form1" runat="server">       

    <div style="width: 700px; margin: 0 auto; padding-top: 50px;">
        <div class="widget">
            <div id="logo">
            </div>
            <b class="xcap"><b class="p3_B1"></b><b class="p3_B2"></b><b class="p3_B3"></b></b>
            <div class="widgetContent">
                <table>
                    <tr>
                        <td width="48%">
                            <table >
                                <tr>
                                    <td class="login_box_form_names">
                                        Username:
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>
                                        <asp:TextBox ID="Username" runat="server" Width="240" MaxLength="100" CssClass="textBox" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="login_box_form_names">
                                        Password:
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>
                                        <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="240" MaxLength="100"
                                            CssClass="textBox" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><br />&nbsp;<asp:Button ID="btnLogin" runat="server" CssClass="btn2" Text="Login" />
                            <br /><br />
                        </td>
                    </tr>
                    <tr>
                         <td colspan="3">
                            <div id="nojs">
                                <asp:Literal ID="litMsg" runat="server"></asp:Literal><br />
                                <div class="msgInfo" id="msgContainer" runat="server">
                                    <asp:Label ID="messageLabel" runat="server" Text=""/>
                                </div>
                                <br />
                            </div>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="Username" ErrorMessage="Username required" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="Password" ErrorMessage="Password required" Display="Static" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </div>
            <b class="xcap"><b class="p3_B3_b"></b><b class="p3_B2_b"></b><b class="p3_B1_b"></b>
            </b>
        </div>
    </div>
    </form>
 </body>
</html>
