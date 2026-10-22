import "dotenv/config";
import { definePrismaConfig } from "@prisma/cli-engine";
import { defineConfig as ormConfig } from "@prisma/orm-postgres/config";

const database_url = process.env.DATABASE_URL;
if (!database_url)
    throw new Error("DATABASE_URL is not set (check .env.example)");

export default definePrismaConfig({
    orm: ormConfig({
        contract: "./prisma/contract.prisma",
        db: {
            connection: database_url,
        },
        migrations: {
            dir: "prisma/migrations",
        },
    }),
});
