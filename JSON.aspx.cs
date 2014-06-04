using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string InsertData(string username, string subj, string desc)
    {
        string msg = string.Empty;
        using (SqlConnection con = new SqlConnection("Connection String"))
        {
            using (SqlCommand cmd = new SqlCommand("insert into TEMP_User(Name,subject,Description) VALUES(@name,@subject,@desc)", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@name", username);
                cmd.Parameters.AddWithValue("@subject", subj);
                cmd.Parameters.AddWithValue("@desc", desc);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i == 1)
                {
                    msg = "true";
                }
                else
                {
                    msg = "false";
                }
            }
        }
        return msg;
    }

    [WebMethod]
    public static string InsertDataUsingJSONObj(empdata empdata)
    {
        string msg = string.Empty;
        using (SqlConnection con = new SqlConnection("Connection String"))
        {
            using (SqlCommand cmd = new SqlCommand("insert into TEMP_User(Name,subject,Description) VALUES(@name,@subject,@desc)", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@name", empdata.Username);
                cmd.Parameters.AddWithValue("@subject", empdata.Subject);
                cmd.Parameters.AddWithValue("@desc", empdata.Desc);
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i == 1)
                {
                    msg = "true";
                }
                else
                {
                    msg = "false";
                }
            }
        }
        return msg;
    }

    public class empdata
    {
        private string username;

        public string Username
        {
            get
            {
                return username;
            }
            set
            {
                username = value;
            }
        }


        private string subject;
        public string Subject
        {
            get
            {
                return subject;
            }
            set
            {
                subject = value;
            }
        }


        private string desc;
        public string Desc
        {
            get
            {
                return desc;
            }
            set
            {
                desc = value;
            }
        }
    }

}
