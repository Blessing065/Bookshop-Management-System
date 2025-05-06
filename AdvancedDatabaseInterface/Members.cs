using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Data.SqlClient;

namespace AdvancedDatabaseInterface
{
    public partial class Members : Form
    {
        public Members()
        {
            InitializeComponent();
        }

        SqlConnection conn = new SqlConnection(@"Data Source = BLESSING\MSSQLSERVER02; Initial Catalog = VAN_SCHAIK_TURFLOOP; Integrated Security = True;");


        private void label2_Click(object sender, EventArgs e)
        {
            

        }


        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            // Validate each field
            if (!ValidateMemberId(textBox6.Text) ||
                !ValidateName(textBox1.Text) ||
                !ValidateName(textBox2.Text) ||
                !ValidateEmail(textBox3.Text) ||
                !ValidatePhoneNumber(textBox4.Text) ||
                !ValidateAddress(textBox5.Text))
            {
                MessageBox.Show("Please enter valid data for all fields.");
                return;
            }

            try
            {
                conn.Open();

                // Prepare SQL command with parameterized query to prevent SQL injection
                SqlCommand command = new SqlCommand("INSERT INTO LIBRARY_MEMBERS(MemberId, FirstName, LastName, EmailAddress, PhoneNumber, Address) VALUES (@MemberId, @FirstName, @LastName, @EmailAddress, @PhoneNumber, @Address)", conn);

                // Set parameter values
                command.Parameters.AddWithValue("@MemberId", textBox6.Text);
                command.Parameters.AddWithValue("@FirstName", textBox1.Text);
                command.Parameters.AddWithValue("@LastName", textBox2.Text);
                command.Parameters.AddWithValue("@EmailAddress", textBox3.Text);
                command.Parameters.AddWithValue("@PhoneNumber", textBox4.Text);
                command.Parameters.AddWithValue("@Address", textBox5.Text);

                // Execute the query
                command.ExecuteNonQuery();
                MessageBox.Show("Member Successfully Registered.");

                // Clear textboxes after successful insertion
                textBox1.Clear();
                textBox2.Clear();
                textBox3.Clear();
                textBox4.Clear();
                textBox5.Clear();
                textBox6.Clear();

                // Close connection and update DataGridView
                conn.Close();
                BindData();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
                // Clear textboxes on error
                textBox1.Clear();
                textBox2.Clear();
                textBox3.Clear();
                textBox4.Clear();
                textBox5.Clear();
                textBox6.Clear();
            }
        }


        void BindData()
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



        // Validation methods for each field
private bool ValidateMemberId(string memberId)
        {
            // Check if MemberId is a valid integer
            if (!int.TryParse(memberId, out _))
            {
                MessageBox.Show("Member ID must be a valid integer.");
                return false;
            }
            return true;
        }

        private bool ValidateName(string name)
        {
            // Validate First Name and Last Name (you can add your own validation rules)
            return !string.IsNullOrWhiteSpace(name);
        }

        private bool ValidateEmail(string email)
        {
            // Validate Email Address (you can add your own validation rules)
            // This is a simple validation, you may want to use more complex validation if required.
            return !string.IsNullOrWhiteSpace(email) && email.Contains("@");
        }

        private bool ValidatePhoneNumber(string phoneNumber)
        {
            // Validate Phone Number (you can add your own validation rules)
            // This is a simple validation, you may want to use more complex validation if required.
            return !string.IsNullOrWhiteSpace(phoneNumber) && phoneNumber.Length >= 10;
        }

        private bool ValidateAddress(string address)
        {
            // Validate Address (you can add your own validation rules)
            return !string.IsNullOrWhiteSpace(address);
        }









    }






}
