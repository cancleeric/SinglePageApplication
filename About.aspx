<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebFormsApp.About" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>關於我們</title>
        <link href="Content/Site.css" rel="stylesheet" />
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="container">
                <h1>關於我們</h1>

                <div class="nav-menu">
                    <asp:Menu ID="MainMenu" runat="server" Orientation="Horizontal">
                        <Items>
                            <asp:MenuItem Text="首頁" NavigateUrl="~/Default.aspx" />
                            <asp:MenuItem Text="關於" NavigateUrl="~/About.aspx" />
                            <asp:MenuItem Text="聯繫我們" NavigateUrl="~/Contact.aspx" />
                        </Items>
                    </asp:Menu>
                </div>

                <div class="content">
                    <asp:Label ID="lblAbout" runat="server" Text="這是一個示例 Web Forms 應用程序。"></asp:Label>
                </div>
            </div>
        </form>
    </body>

    </html>