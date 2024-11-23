<%@ Page Title="登入" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs"
    Inherits="WebFormsApp.Account.Login" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="login-form">
            <h2>登入</h2>
            <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false"
                OnAuthenticate="LoginUser_Authenticate">
                <LayoutTemplate>
                    <div class="form-group">
                        <asp:Label ID="UserNameLabel" runat="server">用戶名:</asp:Label>
                        <asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                            ErrorMessage="必須填寫用戶名。" ValidationGroup="LoginUser" Display="Dynamic" CssClass="error" />
                    </div>

                    <div class="form-group">
                        <asp:Label ID="PasswordLabel" runat="server">密碼:</asp:Label>
                        <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="form-control">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                            ErrorMessage="必須填寫密碼。" ValidationGroup="LoginUser" Display="Dynamic" CssClass="error" />
                    </div>

                    <div class="form-group">
                        <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="登入"
                            ValidationGroup="LoginUser" CssClass="btn btn-primary" />
                    </div>

                    <div class="form-group">
                        <asp:Literal ID="FailureText" runat="server" EnableViewState="false"></asp:Literal>
                    </div>
                </LayoutTemplate>
            </asp:Login>
        </div>
    </asp:Content>