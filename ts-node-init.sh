#!/bin/sh

# Check if a command is available
checkCommand() {
  command -v $1 >/dev/null 2>&1 || {
    echo >&2 "I require $1 but it's not installed. Aborting."; exit 1;
  }
}

checkCommand node
checkCommand npm

PROJECT_NAME=$1

mkdir $PROJECT_NAME

# Create package.json
cat << EOF > $PROJECT_NAME/package.json
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "description": "",
  "main": "src/index.ts",
  "scripts": {
    "start": "NODE_PATH=./src ts-node src/index.ts"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
EOF

# Create tsconfig.json
cat << EOF > $PROJECT_NAME/tsconfig.json
{
  "compilerOptions": {
    "sourceMap": true,
    "alwaysStrict": true,
    "strict": true,
    "lib": ["esnext"],
    "module": "commonjs",
    "moduleResolution": "node",
    "target": "es2019",
    "allowJs": true,
    "resolveJsonModule": true,
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "baseUrl": "src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
EOF

# Create .gitignore
cat << EOF > $PROJECT_NAME/.gitignore
.DS_Store
node_modules
npm-debug.log
EOF

cd $PROJECT_NAME

# Create initial source file
mkdir src
touch src/index.ts

# Install dependencies
npm install --save-dev \
@types/node \
ts-node \
typescript

echo "All done! Have fun writing your Node app! 🎉"