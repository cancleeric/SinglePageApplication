using System;
using System.Linq;
using System.Web.UI.WebControls;
using WebFormsApp.Database;

namespace WebFormsApp.Member
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            using (var db = new DatabaseContext())
            {
                var username = User.Identity.Name;
                var userProfile = db.Users
                    .Where(u => u.Username == username)
                    .Select(u => u.Profile)
                    .FirstOrDefault();

                if (userProfile != null)
                {
                    UserProfileGrid.DataSource = new[] { userProfile };
                    UserProfileGrid.DataBind();
                }
            }
        }

        protected void UserProfileGrid_RowEditing(object sender, GridViewEditEventArgs e)
        {
            UserProfileGrid.EditIndex = e.NewEditIndex;
            LoadUserProfile();
        }

        protected void UserProfileGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            using (var db = new DatabaseContext())
            {
                var profileId = Convert.ToInt32(UserProfileGrid.DataKeys[e.RowIndex].Value);
                var profile = db.UserProfiles.Find(profileId);

                if (profile != null)
                {
                    profile.FullName = e.NewValues["FullName"]?.ToString();
                    profile.PhoneNumber = e.NewValues["PhoneNumber"]?.ToString();
                    db.SaveChanges();
                }
            }

            UserProfileGrid.EditIndex = -1;
            LoadUserProfile();
        }
    }
}