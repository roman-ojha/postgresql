import express from "express";
import client from "./config/db.js";

// https://node-postgres.com/features/connecting

const app = express();
const PORT = process.env.PORT || 8080;

client.query(
  "SELECT * FROM person WHERE country_of_birth ILIKE 'nepal'",
  (err, res) => {
    if (err) {
      console.log(err);
    } else {
      console.log(res);
    }
  }
);

// Insert into database
const text =
  "INSERT INTO person(first_name,last_name,email,gender,date_of_birth,country_of_birth) VALUES($1, $2, $3, $4, $5, $6)";
const values = [
  "roman",
  "ojha",
  "razz@roman.com",
  "male",
  "2022-01-23T18:15:00.000Z",
  "Nepal",
];

client.query(text, values, (err, res) => {
  if (err) {
    console.log(err);
  } else {
    console.log(res);
  }
});

app.listen(PORT, () => {
  console.log(`Running on ${PORT}`);
});
