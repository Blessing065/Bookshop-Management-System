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

namespace AdvancedDatabaseInterface
{
    public partial class BorrowBookForm : Form
    {
        public BorrowBookForm()
        {
            InitializeComponent();
        }

        SqlConnection conn = new SqlConnection(@"Data Source = BLESSING\MSSQLSERVER02; Initial Catalog = VAN_SCHAIK_TURFLOOP; Integrated Security = True;");


        private bool ValidateInput()
        {
            // Check if TransactionId is not empty
            if (string.IsNullOrWhiteSpace(textBox1.Text))
            {
                MessageBox.Show("Please enter Transaction ID.");
                return false;
            }

            // Check if MemberId is not empty
            if (string.IsNullOrWhiteSpace(textBox2.Text))
            {
                MessageBox.Show("Please enter Member ID.");
                return false;
            }

            // Check if ISBN is not empty
            if (string.IsNullOrWhiteSpace(textBox3.Text))
            {
                MessageBox.Show("Please enter ISBN.");
                return false;
            }

            // Check if DateBorrowed is not empty
            if (string.IsNullOrWhiteSpace(textBox4.Text))
            {
                MessageBox.Show("Please enter Date Borrowed.");
                return false;
            }

            // Check if DueDate is not empty
            if (string.IsNullOrWhiteSpace(textBox5.Text))
            {
                MessageBox.Show("Please enter Due Date.");
                return false;
            }

            // Additional validation checks for DateBorrowed and DueDate format can be added here

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
                SqlCommand command = new SqlCommand("INSERT INTO Transactions (TransactionId, MemberId, ISBN, DateBorrowed, DueDate) " +
                                                     "VALUES (@TransactionId, @MemberId, @ISBN, @DateBorrowed, @DueDate)", conn);
                command.Parameters.AddWithValue("@TransactionId", textBox1.Text);
                command.Parameters.AddWithValue("@MemberId", textBox2.Text);
                command.Parameters.AddWithValue("@ISBN", textBox3.Text);
                command.Parameters.AddWithValue("@DateBorrowed", textBox4.Text);
                command.Parameters.AddWithValue("@DueDate", textBox5.Text);
                command.ExecuteNonQuery();
                MessageBox.Show("Book Borrowed Successfully.");
                conn.Close();
                Bindata();
                textBox1.Clear();
                textBox2.Clear();
                textBox3.Clear();
                textBox4.Clear();
                textBox5.Clear();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

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

        private void button2_Click(object sender, EventArgs e)
        {
            Menuform form = new Menuform();
            form.Show();
            this.Hide();
        }
    }
}
