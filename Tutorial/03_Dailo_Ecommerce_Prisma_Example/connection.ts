import { PrismaClient } from "@prisma/client";
import { drizzle } from "drizzle-orm/node-postgres";
import { Pool } from "pg";
import * as schemas from "./drizzle/schema";
import logger from "../utils/logger";
import env from "../constants/env";

// prisma db connection
const prisma = new PrismaClient();

const client = new Pool({
  // max: 30,
  connectionString: env.DATABASE_URL,
  // connectionTimeoutMillis: 0,
  // idleTimeoutMillis: 10,
});

async function connect() {
  await prisma
    .$connect()
    .then(() => {
      logger.console.info("Database connected");
    })
    .catch((err) => {
      logger.console.error(err);
    });
  // await client
  //   .connect()
  //   .then(() => {
  //     logger.console.info("Database connected");
  //   })
  //   .catch((err) => {
  //     logger.console.error(err);
  //     process.exit(1);
  //   });
}

async function disconnect() {
  // await prisma
  //   .$disconnect()
  //   .then(() => {})
  //   .catch((err) => {
  //     logger.console.error(err);
  //   });
}

// drizzle db connection
const db = drizzle(client, {
  schema: schemas,
  logger: env.APPLICATION_ENVIRONMENT == "development",
}); // true for debug

export { connect, disconnect, prisma, db };
