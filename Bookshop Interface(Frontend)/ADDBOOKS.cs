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
    public partial class ADDBOOKS : Form
    {
        public ADDBOOKS()
        {
            InitializeComponent();
        }

        SqlConnection conn = new SqlConnection(@"Data Source = BLESSING\MSSQLSERVER02; Initial Catalog = VAN_SCHAIK_TURFLOOP; Integrated Security = True;");


        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private bool ValidateInput()
        {
            //Check if ISBN is a valid Integer
            int isbn;
            if (!int.TryParse(textBox1.Text, out isbn))
            {
                MessageBox.Show("ISBN must be a valid integer.");
                return false;
            }

            // Check if Title is not empty
            if (string.IsNullOrWhiteSpace(textBox5.Text))
            {
                MessageBox.Show("Please enter Title.");
                return false;
            }

            // Check if AuthorName is not empty
            if (string.IsNullOrWhiteSpace(textBox4.Text))
            {
                MessageBox.Show("Please enter Author's Name.");
                return false;
            }

            // Check if Publisher is not empty
            if (string.IsNullOrWhiteSpace(textBox6.Text))
            {
                MessageBox.Show("Please enter Publisher.");
                return false;
            }

            // Check if NumberOfPages is a valid integer
            int numberOfPages;
            if (!int.TryParse(textBox7.Text, out numberOfPages) || numberOfPages <= 0)
            {
                MessageBox.Show("Please enter a valid number of pages.");
                return false;
            }

            // Check if BookLocation is not empty
            if (string.IsNullOrWhiteSpace(textBox3.Text))
            {
                MessageBox.Show("Please enter Book Location.");
                return false;
            }

            // Check if Price is a valid decimal
            decimal price;
            if (!decimal.TryParse(textBox8.Text, out price) || price <= 0)
            {
                MessageBox.Show("Please enter a valid price.");
                return false;
            }

            // Check if Quantity_Availability is a valid integer
            int quantityAvailability;
            if (!int.TryParse(textBox2.Text, out quantityAvailability) || quantityAvailability < 0)
            {
                MessageBox.Show("Please enter a valid quantity availability.");
                return false;
            }

            // All fields passed validation
            return true;
        }

        private void button_add_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate input fields
                if (!ValidateInput())
                    return;

                conn.Open();
                SqlCommand command = new SqlCommand("INSERT INTO BOOKS (ISBN, Title, AuthorName, Publisher, NumberOfPages, BookLocation, Price, Quantity_Availability) " +
                                                     "VALUES (@ISBN, @Title, @AuthorName, @Publisher, @NumberOfPages, @BookLocation, @Price, @Quantity_Availability)", conn);
                command.Parameters.AddWithValue("@ISBN", textBox1.Text);
                command.Parameters.AddWithValue("@Title", textBox5.Text);
                command.Parameters.AddWithValue("@AuthorName", textBox4.Text);
                command.Parameters.AddWithValue("@Publisher", textBox6.Text);
                command.Parameters.AddWithValue("@NumberOfPages", textBox7.Text);
                command.Parameters.AddWithValue("@BookLocation", textBox3.Text);
                command.Parameters.AddWithValue("@Price", textBox8.Text);
                command.Parameters.AddWithValue("@Quantity_Availability", textBox2.Text);
                command.ExecuteNonQuery();
                MessageBox.Show("Book Successfully Added.");

                Bindata(); // Bind data after successful insertion

                // Clear text boxes
                textBox1.Clear();
                textBox2.Clear();
                textBox3.Clear();
                textBox4.Clear();
                textBox5.Clear();
                textBox6.Clear();
                textBox7.Clear();
                textBox8.Clear();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                conn.Close();
            }

        }

        void Bindata()
        {
            if (conn.State == ConnectionState.Closed)
                conn.Open(); // Open connection if it's closed

            SqlCommand command = new SqlCommand("SELECT * FROM BOOKS", conn);
            SqlDataAdapter sd = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sd.Fill(dt);
            dataGridView1.DataSource = dt;

            conn.Close();
        }

        private void button_delete_Click(object sender, EventArgs e)
        {
           
            if (textBox1.Text != "")
            {
                if (MessageBox.Show("Are you sure you want to delete?", "Delete Book", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    conn.Open();
                    SqlCommand command = new SqlCommand("Delete BOOKS where ISBN = '" + textBox1.Text + "' ", conn);
                    command.ExecuteNonQuery();
                    MessageBox.Show("Succefully Deleted.");
                    conn.Close();
                    Bindata();
                }
            }

            else
            {
                MessageBox.Show("Please enter the Book");
            }
        }

        private void button_update_Click(object sender, EventArgs e)
        {
            conn.Open();
            SqlCommand command = new SqlCommand("UPDATE BOOKS SET Quantity_Availability = '" + textBox2.Text + "' WHERE ISBN = '" + textBox1.Text + "' ", conn);
            command.ExecuteNonQuery();
            MessageBox.Show("Book Successfully Updated.");
            conn.Close();
            Bindata();
        }

        private void button_back_Click(object sender, EventArgs e)
        {
            Menuform form = new Menuform();
            form.Show();
            this.Hide();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            textBox1.Clear();
            textBox2.Clear();
            textBox3.Clear();
            textBox4.Clear();
            textBox5.Clear();
            textBox6.Clear();
            textBox7.Clear();
            textBox8.Clear();
        }
    }
}
