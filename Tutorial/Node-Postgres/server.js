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

app.listen(PORT, () => {
  console.log(`Running on ${PORT}`);
});
