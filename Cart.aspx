<%@ Page Title="購物車" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs"
    Inherits="WebFormsApp.Cart" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="cart-container">
            <h2>購物車</h2>

            <asp:GridView ID="CartGrid" runat="server" AutoGenerateColumns="false" CssClass="cart-grid"
                OnRowCommand="CartGrid_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="品項" />
                    <asp:BoundField DataField="UnitPrice" HeaderText="單價" DataFormatString="{0:C0}" />
                    <asp:TemplateField HeaderText="數量">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' Width="50px"
                                TextMode="Number" min="1" />
                            <asp:Button runat="server" Text="更新" CommandName="UpdateQuantity"
                                CommandArgument='<%# Container.DataItemIndex %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Subtotal" HeaderText="小計" DataFormatString="{0:C0}" />
                    <asp:ButtonField CommandName="Remove" Text="移除" />
                </Columns>
            </asp:GridView>

            <div class="cart-summary">
                <h3>訂單總計:
                    <asp:Label ID="lblTotal" runat="server" />
                </h3>

                <asp:Panel ID="OrderPanel" runat="server" CssClass="order-form">
                    <div class="form-group">
                        <asp:Label runat="server">配送地址:</asp:Label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress" ErrorMessage="請輸入配送地址"
                            CssClass="text-danger" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server">聯絡電話:</asp:Label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" ErrorMessage="請輸入聯絡電話"
                            CssClass="text-danger" />
                    </div>

                    <asp:Button ID="btnCheckout" runat="server" Text="確認訂購" CssClass="btn btn-success"
                        OnClick="btnCheckout_Click" />
                </asp:Panel>
            </div>
        </div>
    </asp:Content>