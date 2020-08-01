echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo COMPILING IN PRODUCTION MODE
echo DOUBLE CHECK FLAGS.NIM 
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!

sleep 10

nim -f -d:isProd=true -d:release -d:danger --opt:size --passC:-flto --passL:-flto c -o:./dist/client.exe ./src/client.nim