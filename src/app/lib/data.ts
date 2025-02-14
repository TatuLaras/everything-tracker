import postgres from 'postgres';

export const sql = postgres(process.env.POSTGRES_URL!);

export const fetchStuff = async () => {
    return await sql`SELECT * FROM test`;
};
