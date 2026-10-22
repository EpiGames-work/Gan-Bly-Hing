import "dotenv/config";
import postgres from "@prisma/orm-postgres/runtime";
import type { Contract } from "./contract.d";
import contractJson from "./contract.json" with { type: "json" };

const database_url = process.env.DATABASE_URL;
if (!database_url) {
    throw new Error("DATABASE_URL not set (see .env.example)");
}

export const db = postgres<Contract>({
    contractJson,
    url: database_url,
});
