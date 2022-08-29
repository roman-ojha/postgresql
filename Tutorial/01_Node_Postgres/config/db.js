import pg from "pg";

// create Client
const client = new pg.Client({
  user: process.env.DATABASEUSER,
  host: process.env.DATABASEHOST,
  database: process.env.DATABASENAME,
  password: process.env.DATABASEPASSWORD,
  port: process.env.DATABASEPORT,
});
// connect to client
client.connect();

export default client;
