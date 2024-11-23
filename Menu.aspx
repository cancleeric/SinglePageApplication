<%@ Page Title="披薩菜單" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs"
    Inherits="WebFormsApp.Menu" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="menu-container">
            <h2>披薩菜單</h2>

            <asp:Repeater ID="PizzaRepeater" runat="server" OnItemCommand="PizzaRepeater_ItemCommand">
                <ItemTemplate>
                    <div class="pizza-item">
                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' class="pizza-image" />
                        <div class="pizza-details">
                            <h3>
                                <%# Eval("Name") %>
                            </h3>
                            <p>
                                <%# Eval("Description") %>
                            </p>
                            <p class="price">NT$ <%# Eval("Price", "{0:N0}" ) %>
                            </p>
                            <asp:Button runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("PizzaId") %>'
                                Text="加入購物車" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </asp:Content>