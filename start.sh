#!/bin/bash

# Criar estrutura de pastas
mkdir -p src/config src/controllers src/models src/repositories src/routes src/services src/utils tests

# Iniciar projeto Node
npm init -y

# Instalar dependências essenciais
npm install express dotenv pg @prisma/cliente
npm install -D typescript ts-node-dev @types/node @types/express @types/pg prisma
npm install @prisma/client

# Criar tsconfig inicial
npx tsc --init

# Sobrescrever tsconfig.json com configuração customizada
cat <<EOF > tsconfig.json
{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules", "src/tests/**/*.ts"]
}
EOF

# Criar tsconfig.build.json
cat <<EOF > tsconfig.build.json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist"
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules", "src/tests/**/*.ts"]
}
EOF

# Inicializar Prisma (gera a pasta prisma e arquivo schema.prisma)
npx prisma init --datasource-provider postgresql

# Criar arquivo .env com valores prontos para banco PostgreSQL
cat <<EOF > .env
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DATABASE=mydatabase
JWT_SECRET=sua_chave_secreta

# IMPORTANTÍSSIMO: valor fixo da URL para o Prisma conectar!
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/mydatabase?schema=public
EOF

# Subir containers docker (ajuste o nome do serviço caso necessário)
sudo docker-compose -f docker-compose.dev.yml up -d --build

# Rodar migração dentro do container api (criar tabelas no banco)
sudo docker-compose exec api npx prisma migrate dev --name init

# Gerar cliente Prisma (para usar no código)
sudo docker-compose exec api npx prisma generate

echo "✅ Configuração completa! Projeto pronto para desenvolvimento."#!/bin/bash

# Criar estrutura de pastas
mkdir -p src/config src/controllers src/models src/repositories src/routes src/services src/utils tests

# Iniciar projeto Node
npm init -y

# Instalar dependências essenciais
npm install express dotenv pg
npm install -D typescript ts-node-dev @types/node @types/express @types/pg prisma
npm install @prisma/client

# Criar tsconfig inicial
npx tsc --init

# Sobrescrever tsconfig.json com configuração customizada
cat <<EOF > tsconfig.json
{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules", "src/tests/**/*.ts"]
}
EOF

# Criar tsconfig.build.json
cat <<EOF > tsconfig.build.json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist"
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules", "src/tests/**/*.ts"]
}
EOF

# Inicializar Prisma (gera a pasta prisma e arquivo schema.prisma)
npx prisma init --datasource-provider postgresql

# Criar arquivo .env com valores prontos para banco PostgreSQL
cat <<EOF > .env
POSTGRES_USERNAME=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DATABASE=mydatabase
JWT_SECRET=sua_chave_secreta

# IMPORTANTÍSSIMO: valor fixo da URL para o Prisma conectar!
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/mydatabase?schema=public
EOF

# Subir containers docker (ajuste o nome do serviço caso necessário)
sudo docker-compose -f docker-compose.dev.yml up -d --build

# Rodar migração dentro do container api (criar tabelas no banco)
sudo docker-compose exec api npx prisma migrate dev --name init

# Gerar cliente Prisma (para usar no código)
sudo docker-compose exec api npx prisma generate

echo "✅ Configuração completa! Projeto pronto para desenvolvimento."