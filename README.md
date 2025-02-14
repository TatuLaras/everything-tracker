# The everything tracker

## Project installation
This assumes you have a working PostgreSQL server running which you can access using the `psql` tool.

Start by installing the project dependencies with `npm install`.


Put the connection string of your database into an `.env` file at the project root:
```
# .env

DATABASE_URL="postgresql://johndoe:randompassword@localhost:5432/mydb?schema=public"
```

Start by importing the schema found in `schema.sql`:
```bash
$ psql < schema.sql
```

After this, generate a schema for Prisma ORM from the database:
```bash
$ npx prisma db pull
```

Finally, generate the Prisma Client:
```bash
$ npx prisma generate
```

Start a development server with:
```bash
$ npm run dev
```
