using System;
using System.Linq;
using System.Web.UI.WebControls;
using WebFormsApp.Database;

namespace WebFormsApp
{
    public partial class Menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPizzas();
            }
        }

        private void LoadPizzas()
        {
            using (var db = new DatabaseContext())
            {
                var pizzas = db.Pizzas
                    .Where(p => p.IsAvailable)
                    .OrderBy(p => p.Name)
                    .ToList();

                PizzaRepeater.DataSource = pizzas;
                PizzaRepeater.DataBind();
            }
        }

        protected void PizzaRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int pizzaId;
                if (int.TryParse(e.CommandArgument.ToString(), out pizzaId))
                {
                    var cart = Session["Cart"] as System.Collections.Generic.List<CartItem>
                        ?? new System.Collections.Generic.List<CartItem>();

                    using (var db = new DatabaseContext())
                    {
                        var pizza = db.Pizzas.Find(pizzaId);
                        if (pizza != null)
                        {
                            var existingItem = cart.FirstOrDefault(i => i.PizzaId == pizzaId);
                            if (existingItem != null)
                            {
                                existingItem.Quantity += 1;
                            }
                            else
                            {
                                cart.Add(new CartItem
                                {
                                    PizzaId = pizza.PizzaId,
                                    Name = pizza.Name,
                                    UnitPrice = pizza.Price,
                                    Quantity = 1
                                });
                            }

                            Session["Cart"] = cart;
                            Response.Redirect("~/Cart.aspx");
                        }
                    }
                }
            }
        }
    }

    // CartItem 類別用於Session中存儲購物車項目
    [Serializable]
    public class CartItem
    {
        public int PizzaId { get; set; }
        public string Name { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public decimal Subtotal
        {
            get { return UnitPrice * Quantity; }
        }
    }
}