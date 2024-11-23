using System;
using System.Linq;
using System.Web.UI.WebControls;
using WebFormsApp.Database;

namespace WebFormsApp.Admin
{
    public partial class PizzaManagement : System.Web.UI.Page
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
                PizzaGrid.DataSource = db.Pizzas.OrderBy(p => p.Name).ToList();
                PizzaGrid.DataBind();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (var db = new DatabaseContext())
            {
                Pizza pizza;
                int pizzaId;
                bool isEdit = int.TryParse(Request.QueryString["id"], out pizzaId);

                if (isEdit)
                {
                    pizza = db.Pizzas.Find(pizzaId);
                    if (pizza == null) return;
                }
                else
                {
                    pizza = new Pizza();
                    db.Pizzas.Add(pizza);
                }

                pizza.Name = txtName.Text;
                pizza.Description = txtDescription.Text;
                pizza.Price = decimal.Parse(txtPrice.Text);
                pizza.ImageUrl = txtImageUrl.Text;
                pizza.IsAvailable = chkIsAvailable.Checked;

                db.SaveChanges();
            }

            ClearForm();
            LoadPizzas();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void PizzaGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int pizzaId;
            if (!int.TryParse(e.CommandArgument.ToString(), out pizzaId)) return;

            using (var db = new DatabaseContext())
            {
                var pizza = db.Pizzas.Find(pizzaId);
                if (pizza == null) return;

                switch (e.CommandName)
                {
                    case "EditPizza":
                        // 載入編輯表單
                        ltFormTitle.Text = "編輯披薩";
                        txtName.Text = pizza.Name;
                        txtDescription.Text = pizza.Description;
                        txtPrice.Text = pizza.Price.ToString();
                        txtImageUrl.Text = pizza.ImageUrl;
                        chkIsAvailable.Checked = pizza.IsAvailable;
                        Response.Redirect($"~/Admin/PizzaManagement.aspx?id={pizzaId}");
                        break;

                    case "DeletePizza":
                        // 刪除披薩
                        db.Pizzas.Remove(pizza);
                        db.SaveChanges();
                        LoadPizzas();
                        break;
                }
            }
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtImageUrl.Text = string.Empty;
            chkIsAvailable.Checked = true;
            ltFormTitle.Text = "新增披薩";
            Response.Redirect("~/Admin/PizzaManagement.aspx");
        }
    }
}