nim -d:isProd=true -d:release -d:danger --opt:size --passC:-flto --passL:-flto c -o:./dist/client.exe ./src/client.nim