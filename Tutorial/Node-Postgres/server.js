import express from "express";
import client from "./config/db.js";
// https://node-postgres.com/features/connecting

const app = express();
const PORT = process.env.PORT || 8080;

app.listen(PORT, () => {
  console.log(`Running on ${PORT}`);
});
