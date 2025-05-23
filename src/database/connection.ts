//pg é o pacote oficial do PostgreSQL para Node.js.
import { Pool } from 'pg';
//Pool é uma classe que gerencia múltiplas conexões com o banco, evitando abrir uma nova conexão para cada query.

const pool = new Pool({
  user: process.env.DB_USER || 'seu_usuario',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'cantina',
  password: process.env.DB_PASSWORD || 'sua_senha',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
});

/**
 * Exporta uma função query para ser usada em outros arquivos do backend.
text é a SQL que será executada (SELECT * FROM ...).
params é um array com os valores da query parametrizada.
 */

export const query = (text: string, params?: any[]) => pool.query(text, params);

export default pool;