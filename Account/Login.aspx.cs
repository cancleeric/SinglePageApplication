using System;
using System.Linq;
using System.Web.Security;
using WebFormsApp.Database;

namespace WebFormsApp.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void LoginUser_Authenticate(object sender, AuthenticateEventArgs e)
        {
            using (var db = new DatabaseContext())
            {
                var username = LoginUser.UserName;
                var password = LoginUser.Password;

                // 在實際應用中應該使用密碼雜湊
                var user = db.Users.FirstOrDefault(u =>
                    u.Username == username &&
                    u.PasswordHash == HashPassword(password));

                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(username, false);
                    Response.Redirect("~/Member/Dashboard.aspx");
                }
                else
                {
                    LoginUser.FailureText = "用戶名或密碼錯誤。";
                }
            }
        }

        private string HashPassword(string password)
        {
            // 實際應用中應使用更安全的雜湊方法
            return FormsAuthentication.HashPasswordForStoringInConfigFile(password, "SHA1");
        }
    }
}