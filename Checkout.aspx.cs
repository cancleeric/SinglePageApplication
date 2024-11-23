using System;
using System.Linq;
using System.Collections.Generic;
using WebFormsApp.Database;

namespace WebFormsApp
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCartSummary();
                LoadUserInfo();
            }
        }

        private void LoadCartSummary()
        {
            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null || !cart.Any())
            {
                Response.Redirect("~/Cart.aspx");
                return;
            }

            CartSummaryGrid.DataSource = cart;
            CartSummaryGrid.DataBind();
            lblTotal.Text = string.Format("NT$ {0:N0}", cart.Sum(i => i.Subtotal));
        }

        private void LoadUserInfo()
        {
            using (var db = new DatabaseContext())
            {
                var user = db.Users
                    .Include(u => u.Profile)
                    .FirstOrDefault(u => u.Username == User.Identity.Name);

                if (user?.Profile != null)
                {
                    txtReceiverName.Text = user.Profile.FullName;
                    txtPhone.Text = user.Profile.PhoneNumber;
                }
            }
        }

        protected void btnEditCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Cart.aspx");
        }

        protected void btnNextToDelivery_Click(object sender, EventArgs e)
        {
            CheckoutMultiView.ActiveViewIndex = 1;
        }

        protected void btnBackToCart_Click(object sender, EventArgs e)
        {
            CheckoutMultiView.ActiveViewIndex = 0;
        }

        protected void btnNextToConfirm_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                LoadOrderConfirmation();
                CheckoutMultiView.ActiveViewIndex = 2;
            }
        }

        private void LoadOrderConfirmation()
        {
            var cart = Session["Cart"] as List<CartItem>;
            OrderItemsRepeater.DataSource = cart;
            OrderItemsRepeater.DataBind();

            lblReceiverName.Text = txtReceiverName.Text;
            lblPhone.Text = txtPhone.Text;
            lblAddress.Text = txtAddress.Text;
            lblNotes.Text = txtNotes.Text;
            lblFinalTotal.Text = string.Format("NT$ {0:N0}", cart.Sum(i => i.Subtotal));
        }

        protected void btnBackToDelivery_Click(object sender, EventArgs e)
        {
            CheckoutMultiView.ActiveViewIndex = 1;
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;
            if (cart == null || !cart.Any()) return;

            using (var db = new DatabaseContext())
            {
                var user = db.Users.FirstOrDefault(u => u.Username == User.Identity.Name);
                if (user == null) return;

                var order = new Order
                {
                    UserId = user.UserId,
                    OrderDate = DateTime.Now,
                    TotalAmount = cart.Sum(i => i.Subtotal),
                    DeliveryAddress = txtAddress.Text,
                    ContactPhone = txtPhone.Text,
                    Status = OrderStatus.Pending,
                    OrderItems = cart.Select(i => new OrderItem
                    {
                        PizzaId = i.PizzaId,
                        Quantity = i.Quantity,
                        UnitPrice = i.UnitPrice
                    }).ToList()
                };

                db.Orders.Add(order);
                db.SaveChanges();

                Session["Cart"] = null;
                lblOrderNumber.Text = order.OrderId.ToString("D6");
                CheckoutMultiView.ActiveViewIndex = 3;
            }
        }

        protected void btnViewOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Member/Dashboard.aspx");
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Menu.aspx");
        }
    }
}