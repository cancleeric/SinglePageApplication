<%@ Page Title="首頁" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs"
    Inherits="WebFormsApp.Default" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="jumbotron">
            <h1>歡迎來到我的網站</h1>
            <p>這是一個基於 ASP.NET Web Forms 的網站。</p>

            <asp:LoginView runat="server">
                <AnonymousTemplate>
                    <p>
                        <asp:Button ID="btnLogin" runat="server" Text="立即登入" CssClass="btn btn-primary"
                            OnClick="btnLogin_Click" />
                        或
                        <asp:Button ID="btnRegister" runat="server" Text="註冊新帳號" CssClass="btn btn-success"
                            OnClick="btnRegister_Click" />
                    </p>
                </AnonymousTemplate>
                <LoggedInTemplate>
                    <p>
                        <asp:Button ID="btnDashboard" runat="server" Text="進入會員專區" CssClass="btn btn-primary"
                            OnClick="btnDashboard_Click" />
                    </p>
                </LoggedInTemplate>
            </asp:LoginView>
        </div>
    </asp:Content>