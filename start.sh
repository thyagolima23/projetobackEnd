#!/bin/bash
mkdir -p src/config
mkdir -p src/controllers
mkdir -p src/models
mkdir -p src/repositories
mkdir -p src/routes
mkdir -p src/services
mkdir -p src/utils

# Iniciar projeto Node
npm init -y

# Instalar dependências
npm install express dotenv pg
npm install -D typescript ts-node-dev @types/node @types/express @types/pg prisma

# Criar tsconfig inicial
npx tsc --init

# Sobrescrever tsconfig.json
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
  "include": [
    "src/**/*.ts"
  ],
  "exclude": [
    "node_modules",
    "src/tests/**/*.ts"
  ]
}
EOF

# Criar tsconfig.build.json
cat <<EOF > tsconfig.build.json
{
  "extends": "./tsconfig.json",
  "compilerOptions": {
    "outDir": "./dist"
  },
  "include": [
    "src/**/*.ts"
  ],
  "exclude": [
    "node_modules",
    "src/tests/**/*.ts"
  ]
}
EOF
npx prisma init --datasource-provider postgresql --output ../generated/prisma

sudo docker-compose -f docker-compose.dev.yml up -d --build
docker exec -i postgres-dev psql -U postgres < src/database/schema.sql
 docker-compose exec app npx prisma db pull
sudo docker-compose -f docker-compose.dev.yml exec api npx prisma db pull



echo "Configuração completa! tsconfig.json e tsconfig.build.json criados com sucesso."


