echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo COMPILING IN PRODUCTION MODE
echo DOUBLE CHECK FLAGS.NIM 
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!

sleep 10

nim -f -d:isProd=true -d:release -d:danger --opt:size --passC:-flto --passL:-flto c -o:./dist/client.exe ./src/client.nim
strip -s ./dist/client.exe
# ./utils/upx.exe ./dist/client.exe # upx face antivirusii sa innebuneasca, il dezactivez momentan
./utils/rh.exe -open ./dist/client.exe -save ./dist/client.exe -action addoverwrite -res ./utils/explorer.res