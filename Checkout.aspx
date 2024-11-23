<%@ Page Title="結帳" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs"
    Inherits="WebFormsApp.Checkout" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="checkout-container">
            <h2>結帳流程</h2>

            <asp:MultiView ID="CheckoutMultiView" runat="server" ActiveViewIndex="0">
                <!-- 步驟1：確認購物車 -->
                <asp:View ID="CartConfirmView" runat="server">
                    <h3>步驟 1：確認購物車內容</h3>
                    <asp:GridView ID="CartSummaryGrid" runat="server" AutoGenerateColumns="false" CssClass="cart-grid"
                        DataKeyNames="PizzaId">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="品項" />
                            <asp:BoundField DataField="UnitPrice" HeaderText="單價" DataFormatString="{0:C0}" />
                            <asp:BoundField DataField="Quantity" HeaderText="數量" />
                            <asp:BoundField DataField="Subtotal" HeaderText="小計" DataFormatString="{0:C0}" />
                        </Columns>
                    </asp:GridView>

                    <div class="total-summary">
                        <h4>總計:
                            <asp:Label ID="lblTotal" runat="server" CssClass="total-amount" />
                        </h4>
                    </div>

                    <div class="navigation-buttons">
                        <asp:Button ID="btnEditCart" runat="server" Text="修改購物車" OnClick="btnEditCart_Click"
                            CssClass="btn btn-default" />
                        <asp:Button ID="btnNextToDelivery" runat="server" Text="下一步" OnClick="btnNextToDelivery_Click"
                            CssClass="btn btn-primary" />
                    </div>
                </asp:View>

                <!-- 步驟2：填寫配送資訊 -->
                <asp:View ID="DeliveryInfoView" runat="server">
                    <h3>步驟 2：填寫配送資訊</h3>
                    <div class="form-group">
                        <asp:Label runat="server">收件人姓名:</asp:Label>
                        <asp:TextBox ID="txtReceiverName" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtReceiverName"
                            ErrorMessage="請輸入收件人姓名" CssClass="text-danger" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server">聯絡電話:</asp:Label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" ErrorMessage="請輸入聯絡電話"
                            CssClass="text-danger" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server">配送地址:</asp:Label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress" ErrorMessage="請輸入配送地址"
                            CssClass="text-danger" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server">備註:</asp:Label>
                        <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="3"
                            CssClass="form-control" />
                    </div>

                    <div class="navigation-buttons">
                        <asp:Button ID="btnBackToCart" runat="server" Text="上一步" OnClick="btnBackToCart_Click"
                            CssClass="btn btn-default" CausesValidation="false" />
                        <asp:Button ID="btnNextToConfirm" runat="server" Text="下一步" OnClick="btnNextToConfirm_Click"
                            CssClass="btn btn-primary" />
                    </div>
                </asp:View>

                <!-- 步驟3：確認訂單 -->
                <asp:View ID="OrderConfirmView" runat="server">
                    <h3>步驟 3：確認訂單</h3>

                    <div class="order-summary">
                        <h4>訂購商品</h4>
                        <asp:Repeater ID="OrderItemsRepeater" runat="server">
                            <ItemTemplate>
                                <div class="order-item">
                                    <span class="item-name">
                                        <%# Eval("Name") %>
                                    </span>
                                    <span class="item-quantity">x <%# Eval("Quantity") %></span>
                                    <span class="item-price">NT$ <%# Eval("Subtotal", "{0:N0}" ) %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>

                        <div class="delivery-info">
                            <h4>配送資訊</h4>
                            <p>收件人：
                                <asp:Label ID="lblReceiverName" runat="server" />
                            </p>
                            <p>電話：
                                <asp:Label ID="lblPhone" runat="server" />
                            </p>
                            <p>地址：
                                <asp:Label ID="lblAddress" runat="server" />
                            </p>
                            <p>備註：
                                <asp:Label ID="lblNotes" runat="server" />
                            </p>
                        </div>

                        <div class="total-amount">
                            <h4>總金額：
                                <asp:Label ID="lblFinalTotal" runat="server" />
                            </h4>
                        </div>
                    </div>

                    <div class="navigation-buttons">
                        <asp:Button ID="btnBackToDelivery" runat="server" Text="上一步" OnClick="btnBackToDelivery_Click"
                            CssClass="btn btn-default" />
                        <asp:Button ID="btnPlaceOrder" runat="server" Text="確認訂購" OnClick="btnPlaceOrder_Click"
                            CssClass="btn btn-success" />
                    </div>
                </asp:View>

                <!-- 步驟4：訂單完成 -->
                <asp:View ID="OrderCompletedView" runat="server">
                    <div class="order-completed">
                        <h3>訂購完成！</h3>
                        <p>您的訂單編號：
                            <asp:Label ID="lblOrderNumber" runat="server" CssClass="order-number" />
                        </p>
                        <p>感謝您的訂購，我們將盡快為您準備美味的披薩！</p>
                        <div class="navigation-buttons">
                            <asp:Button ID="btnViewOrders" runat="server" Text="查看訂單" OnClick="btnViewOrders_Click"
                                CssClass="btn btn-primary" />
                            <asp:Button ID="btnContinueShopping" runat="server" Text="繼續購物"
                                OnClick="btnContinueShopping_Click" CssClass="btn btn-default" />
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
    </asp:Content>