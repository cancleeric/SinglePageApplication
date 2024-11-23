using System;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Data.Entity;
using WebFormsApp.Database;

namespace WebFormsApp
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // 初始化數據庫
            Database.SetInitializer(new CreateDatabaseIfNotExists<DatabaseContext>());

            using (var db = new DatabaseContext())
            {
                // 確保數據庫被創建
                db.Database.Initialize(force: false);

                // 如果沒有任何用戶，創建一個管理員帳號
                if (!db.Users.Any())
                {
                    var adminUser = new User
                    {
                        Username = "admin",
                        PasswordHash = FormsAuthentication.HashPasswordForStoringInConfigFile("admin123", "SHA1"),
                        Email = "admin@example.com",
                        Profile = new UserProfile
                        {
                            FullName = "系統管理員",
                            PhoneNumber = "0900000000"
                        }
                    };

                    db.Users.Add(adminUser);
                    db.SaveChanges();
                }
            }
        }
    }
}