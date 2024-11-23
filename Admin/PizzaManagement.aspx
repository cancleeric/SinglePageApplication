<%@ Page Title="披薩管理" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="PizzaManagement.aspx.cs" Inherits="WebFormsApp.Admin.PizzaManagement" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="admin-container">
            <h2>披薩管理</h2>

            <asp:Panel ID="AddEditPanel" runat="server" CssClass="pizza-form">
                <h3>
                    <asp:Literal ID="ltFormTitle" runat="server" Text="新增披薩" />
                </h3>

                <div class="form-group">
                    <asp:Label runat="server">名稱:</asp:Label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="請輸入披薩名稱"
                        CssClass="text-danger" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <asp:Label runat="server">描述:</asp:Label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"
                        CssClass="form-control" />
                </div>

                <div class="form-group">
                    <asp:Label runat="server">價格:</asp:Label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice" ErrorMessage="請輸入價格"
                        CssClass="text-danger" Display="Dynamic" />
                    <asp:RangeValidator runat="server" ControlToValidate="txtPrice" MinimumValue="0"
                        MaximumValue="99999" Type="Integer" ErrorMessage="價格必須大於0" CssClass="text-danger"
                        Display="Dynamic" />
                </div>

                <div class="form-group">
                    <asp:Label runat="server">圖片網址:</asp:Label>
                    <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <asp:CheckBox ID="chkIsAvailable" runat="server" Text="是否上架" Checked="true" />
                </div>

                <div class="form-group">
                    <asp:Button ID="btnSave" runat="server" Text="儲存" CssClass="btn btn-primary"
                        OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="取消" CssClass="btn btn-default"
                        OnClick="btnCancel_Click" CausesValidation="false" />
                </div>
            </asp:Panel>

            <asp:GridView ID="PizzaGrid" runat="server" AutoGenerateColumns="false" CssClass="table table-striped"
                DataKeyNames="PizzaId" OnRowCommand="PizzaGrid_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="名稱" />
                    <asp:BoundField DataField="Description" HeaderText="描述" />
                    <asp:BoundField DataField="Price" HeaderText="價格" DataFormatString="{0:C0}" />
                    <asp:CheckBoxField DataField="IsAvailable" HeaderText="已上架" />
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="EditPizza"
                                CommandArgument='<%# Eval("PizzaId") %>' Text="編輯" />
                            |
                            <asp:LinkButton runat="server" CommandName="DeletePizza"
                                CommandArgument='<%# Eval("PizzaId") %>' Text="刪除"
                                OnClientClick="return confirm('確定要刪除此披薩嗎？');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Content>