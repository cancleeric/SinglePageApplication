using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using WebFormsApp.Database;

namespace WebFormsApp
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            var cart = Session["Cart"] as List<CartItem>;
            if (cart != null && cart.Any())
            {
                CartGrid.DataSource = cart;
                CartGrid.DataBind();
                lblTotal.Text = string.Format("NT$ {0:N0}", cart.Sum(i => i.Subtotal));
            }
            else
            {
                CartGrid.Visible = false;
                OrderPanel.Visible = false;
                lblTotal.Text = "購物車是空的";
            }
        }

        protected void CartGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null) return;

            int index;
            if (int.TryParse(e.CommandArgument.ToString(), out index))
            {
                if (e.CommandName == "Remove")
                {
                    cart.RemoveAt(index);
                }
                else if (e.CommandName == "UpdateQuantity")
                {
                    var row = CartGrid.Rows[index];
                    var quantityBox = row.FindControl("txtQuantity") as TextBox;
                    if (quantityBox != null)
                    {
                        int quantity;
                        if (int.TryParse(quantityBox.Text, out quantity) && quantity > 0)
                        {
                            cart[index].Quantity = quantity;
                        }
                    }
                }

                Session["Cart"] = cart;
                LoadCart();
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null || !cart.Any()) return;

            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            Response.Redirect("~/Checkout.aspx");
        }
    }
}