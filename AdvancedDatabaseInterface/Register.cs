using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ListView;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace AdvancedDatabaseInterface
{
    public partial class Register : Form
    {
        public Register()
        {
            InitializeComponent();
        }

        SqlConnection conn = new SqlConnection(@"Data Source = BLESSING\MSSQLSERVER02; Initial Catalog = VAN_SCHAIK_TURFLOOP; Integrated Security = True;");

        private void button1_Click(object sender, EventArgs e)
        {
            conn.Open();
            SqlCommand command = new SqlCommand("INSERT INTO Login (Username,Password)\r\nVALUES ('" + textBox1.Text + "','" + textBox2.Text + "')", conn);
            command.ExecuteNonQuery();


            if (string.IsNullOrEmpty(textBox1.Text) || string.IsNullOrEmpty(textBox2.Text))
            {
                MessageBox.Show("Please fill in all fields.");
                conn.Close();
            }
            else
            {
                MessageBox.Show("Successfully Registered.");
                textBox1.Clear();
                textBox2.Clear();
                conn.Close();
            }
    

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form1 form = new Form1();
            form.Show();
            this.Hide();
        }
    }
}
