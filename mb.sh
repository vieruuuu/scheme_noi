nim c -f -d:isProd=true -d:release -d:danger --opt:size --passC:-flto -o:./dist/master.exe ./src/master.nim
strip -s ./dist/master.exe