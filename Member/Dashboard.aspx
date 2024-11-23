<%@ Page Title="會員專區" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs"
    Inherits="WebFormsApp.Member.Dashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="dashboard">
            <h2>會員專區</h2>
            <asp:GridView ID="UserProfileGrid" runat="server" AutoGenerateColumns="false" CssClass="grid-view"
                OnRowEditing="UserProfileGrid_RowEditing" OnRowUpdating="UserProfileGrid_RowUpdating"
                DataKeyNames="UserProfileId">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="姓名" />
                    <asp:BoundField DataField="PhoneNumber" HeaderText="電話" />
                    <asp:CommandField ShowEditButton="true" />
                </Columns>
            </asp:GridView>
        </div>
    </asp:Content>