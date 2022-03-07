#pragma once

#define _INC_WINDOWS
#include <SKSE/Impl/PCH.h>
#include <RE/Skyrim.h>
#include <SKSE/SKSE.h>
#include <REL/Relocation.h>
#undef _INC_WINDOWS

#include <ShlObj_core.h>
#include <Windows.h>
#include <Psapi.h>
#include <stdio.h>
#include <stdexcept>

#include <format>
#include <gtest/gtest.h>
#include <filesystem>
#include <fstream>

namespace fs = std::filesystem;

class SkyScriptTestBase : public ::testing::Test {
protected:

   std::string _testTempFolder;

   void TearDown() override {
      if (fs::is_directory(_testTempFolder)) {
         fs::remove_all(_testTempFolder);
      }
   }

   std::string CurrentFolder() {
      return GetTestTempFolderPath().string();
   }

   std::string MkDir(std::string relativePath) {
      auto folderPath = GetTestTempFolderPath().append(relativePath);
      if (! fs::is_directory(folderPath))
         fs::create_directories(folderPath);
      return folderPath.string();
   }

   std::string Touch(std::string relativePath) {
      auto filePath = GetTestTempFolderPath().append(relativePath);
      if (! fs::is_directory(filePath.parent_path()))
         fs::create_directories(filePath.parent_path());
      std::ofstream(filePath.string());
      return filePath.string();
   }

   std::string WriteToFile(std::string relativePath, std::string textContent) {
      auto filePath = GetTestTempFolderPath().append(relativePath);
      if (! fs::is_directory(filePath.parent_path()))
         fs::create_directories(filePath.parent_path());
      std::ofstream output(filePath.string());
      output << textContent;
      return filePath.string();
   }

   std::string Path(std::string relativePath) {
	   return GetTestTempFolderPath().append(relativePath).string();
   }

private:

   fs::path GetTestTempFolderPath() {
      if (! fs::is_directory(_testTempFolder)) {
         _testTempFolder = std::tmpnam(nullptr);
         fs::create_directory(_testTempFolder);
      }
      return fs::path(_testTempFolder);
   }
};
