const express = require("express");
const dotenv = require("dotenv");
const mysql = require("mysql2");
const path = require("path");

// Load environment variables
dotenv.config(); // change path acc. (default: .env)

const app = express();

// Set the public directory for static files
app.use(express.static(path.join(__dirname, "public")));

const tableName = process.env.TABLE_NAME || 'users'; // Default table name if not provided
const port = process.env.PORT || 3000;

// Connect to db
const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
});

// Route to serve the HTML file
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

// Route to fetch users
app.get(`/${tableName}`, (req, res) => {
  const query = `SELECT * FROM ${tableName}`;
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).send("Database query failed.");
    }
    res.json(results);
  });
});

// Function to check if the table is empty
function isTableEmpty(callback) {
  const query = `SELECT COUNT(*) AS count FROM ${tableName}`;
  db.query(query, (err, results) => {
    if (err) {
      return callback(err);
    }
    callback(null, results[0].count === 0);
  });
}

// Function to insert dummy data
function insertDummyData() {
  const dummyData = [
    { id: 1, name: 'John Doe', email: 'john.doe@example.com' },
    { id: 2, name: 'Jane Smith', email: 'jane.smith@example.com' },
    { id: 3, name: 'Alice Johnson', email: 'alice.johnson@example.com' }
  ];

  const query = `INSERT INTO ${tableName} (id, name, email) VALUES ?`;
  const values = dummyData.map(user => [user.id, user.name, user.email]);

  db.query(query, [values], (err, results) => {
    if (err) {
      console.error("Error inserting dummy data:", err);
    } else {
      console.log("Dummy data inserted successfully!");
    }
  });
}

// Test connection and insert dummy data if table is empty
db.connect((err) => {
  if (err) throw err;
  console.log("Connected to database!");

  isTableEmpty((err, isEmpty) => {
    if (err) {
      console.error("Error checking if table is empty:", err);
      return;
    }

    if (isEmpty) {
      console.log("Table is empty, inserting dummy data...");
      insertDummyData();
    } else {
      console.log("Table already has data, skipping dummy data insertion.");
    }
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});