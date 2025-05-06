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

namespace AdvancedDatabaseInterface
{
    public partial class PurchaseBook : Form
    {
        public PurchaseBook()
        {
            InitializeComponent();
        }

        SqlConnection conn = new SqlConnection(@"Data Source = BLESSING\MSSQLSERVER02; Initial Catalog = VAN_SCHAIK_TURFLOOP; Integrated Security = True;");

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Menuform form = new Menuform();
            form.Show();
            this.Hide();
        }


        private bool ValidateInput()
        {
            // Check if TransactionId is not empty
            if (string.IsNullOrWhiteSpace(textBox1.Text))
            {
                MessageBox.Show("Please enter Transaction ID.");
                return false;
            }

            // Check if ISBN is not empty
            if (string.IsNullOrWhiteSpace(textBox2.Text))
            {
                MessageBox.Show("Please enter ISBN.");
                return false;
            }

            // Check if MemberId is not empty
            if (string.IsNullOrWhiteSpace(textBox3.Text))
            {
                MessageBox.Show("Please enter Member ID.");
                return false;
            }

            // Check if FullName is not empty
            if (string.IsNullOrWhiteSpace(textBox4.Text))
            {
                MessageBox.Show("Please enter Full Name.");
                return false;
            }

            // Check if DateOfPurchase is not empty
            if (string.IsNullOrWhiteSpace(textBox5.Text))
            {
                MessageBox.Show("Please enter Date of Purchase.");
                return false;
            }

            // Check if Price is a valid decimal
            decimal price;
            if (!decimal.TryParse(textBox6.Text, out price) || price <= 0)
            {
                MessageBox.Show("Please enter a valid price.");
                return false;
            }

            return true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate input fields
                if (!ValidateInput())
                    return;

                conn.Open();
                SqlCommand command = new SqlCommand("INSERT INTO PURCHASEDBOOKS (TransactionId, ISBN, MemberId, FullName, DateOfPurchase, Price) " +
                                                     "VALUES (@TransactionId, @ISBN, @MemberId, @FullName, @DateOfPurchase, @Price)", conn);
                command.Parameters.AddWithValue("@TransactionId", textBox1.Text);
                command.Parameters.AddWithValue("@ISBN", textBox2.Text);
                command.Parameters.AddWithValue("@MemberId", textBox3.Text);
                command.Parameters.AddWithValue("@FullName", textBox4.Text);
                command.Parameters.AddWithValue("@DateOfPurchase", textBox5.Text);
                command.Parameters.AddWithValue("@Price", textBox6.Text);
                command.ExecuteNonQuery();
                MessageBox.Show("Book Purchased Successfully.");

                textBox1.Clear();
                textBox2.Clear();
                textBox3.Clear();
                textBox4.Clear();
                textBox5.Clear();
                textBox6.Clear();
                conn.Close();
                Bindata();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        void Bindata()
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open(); // Open connection if it's closed

            SqlCommand command = new SqlCommand("SELECT * FROM LIBRARY_MEMBERS", conn);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sd.Fill(dt);
            dataGridView1.DataSource = dt;

            conn.Close();
        }
    }
}
