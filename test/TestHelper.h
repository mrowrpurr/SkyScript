#pragma once

#define _INC_WINDOWS
#include <SKSE/Impl/PCH.h>
#include <RE/Skyrim.h>
#include <SKSE/SKSE.h>
#include <REL/Relocation.h>
#undef _INC_WINDOWS

#define NOMINMAX
#include <Windows.h>

#include <ShlObj_core.h>
#include <Psapi.h>
#include <stdexcept>
#include <format>
#include <filesystem>
#include <fstream>
#include <utility>
#include <stdio.h>
#include <stdlib.h>

#include <gtest/gtest.h>

#include <SkyScript/Context.h>
#include <SkyScript/Evaluator.h>

namespace fs = std::filesystem;

using namespace SkyScript;

class SkyScriptTestBase : public ::testing::Test {
private:
	std::string _testTempFolder;

protected:
   void TearDown() override {
      if (fs::is_directory(_testTempFolder)) {
         fs::remove_all(_testTempFolder);
      }
   }

	Context Eval(Context& context, const std::string& yamlText) {
		return context;
	}

   Context Eval(const std::string& yamlText) {
	   auto context = Context();
	   return Evaluator::Evaluate(context, yamlText);
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

   std::string Path(const std::string& relativePath) {
	   return GetTestTempFolderPath().append(relativePath).string();
   }

private:

	fs::path GetTestTempFolderPath() {
		if (! fs::is_directory(_testTempFolder)) {
			char buffer[256];
			tmpnam_s(buffer, sizeof(buffer));
			_testTempFolder = buffer;
			fs::create_directory(_testTempFolder);
		}
		return {_testTempFolder};
	}
};
