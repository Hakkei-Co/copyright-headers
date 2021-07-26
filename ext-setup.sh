#!/bin/bash

# Check for VSCode
if ! [ -x "$(command -v code)" ]; then
  echo 'Error: VSCode is not installed.' >&2
  exit 1
else
  echo "vscode found. OK"
fi

# This script relies on jq
REQUIRED_PKG="jq"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG | grep "install ok installed")

# Check for jq and install if not found
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG found. Setting up $REQUIRED_PKG."
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # being lazy, sorry
  code --install-extension psioniq.psi-header
  sudo apt-get --yes install $REQUIRED_PKG
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # being lazy, sorry
  code --install-extension psioniq.psi-header
  brew install $REQUIRED_PKG
else
  echo "Unsupported OS. Sorry."
  exit 0
fi


# fullname="USER INPUT"
read -p "Enter fullname: " fullname
# user="USER INPUT"
read -p "Enter email: " email
# fullname="USER INPUT"
read -p "Enter initials: " initials
# user="USER INPUT"
read -p "Enter github username: " username

echo jq --arg fullname "$fullname" --arg email "$email" --arg \ username "$username" --arg initials "$initials" '.fullname, .email, .username, .initials' '
  {
    "psi-header.variables": [
      ["company", "Hakkei Co."],
      ["author", "'$fullname'"],
      ["authoremail", "'$email'"],
      ["website", "https://hakkei.co"],
      ["initials", "'$initials'"],
      ["projectCreationYear", "2021"],
      ["github-org", "github/hakkei-co"],
      ["github-user", "'$username'"]
    ],
    "psi-header.config": {
      "forceToTop": true,
      "blankLinesAfter": 4
    },
    "psi-header.changes-tracking": {
      "autoHeader": "autoSave",
      "isActive": true,
      "modAuthor": "@lastModifiedBy:   ",
      "modDate": "@lastModifiedTime: ",
      "include": [],
      "includeGlob": [],
      "exclude": ["markdown", "yaml", "yml", "json", "jsonc", "shellscript"],
      "excludeGlob": ["./**/*/ignoreme.*"],
      "enforceHeader": true,
      "replace": ["Filename:", "Project"],
      "updateLicenseVariables": false
    },
    "psi-header.lang-config": [
      {
        "language": "javascript",
        "begin": "/*",
        "prefix": "",
        "suffix": " ",
        "lineLength": 80,
        "end": " */",
        "forceToTop": true,
        "blankLinesAfter": 3,
        "beforeHeader": [],
        "afterHeader": [],
        "rootDirFileName": "package.json",
        "modAuthor": "Modified By:",
        "modDate": "Last Modified:",
        "modDateFormat": "dd/MM/yyyy hh:nn:ss",
        "replace": ["Filename:", "Project"],
        "ignoreLines": []
      },
      {
        "language": "typescript",
        "mapTo": "javascript"
      },
      {
        "language": "markdown",
        "begin": "\n",
        "prefix": "[//]: <> ",
        "suffix": "",
        "end": " ",
        "forceToTop": true,
        "blankLinesAfter": 2
      }
    ],
    "psi-header.templates": [
      {
        "language": "*",
        "template": [
          "Copyright (c) <<year>> <<company>> <<github-org>>",
          "",
          "Created Date: <<filecreated('\'dddd, MMMM Do YYYY, h:mm:ss a\'')>>",
          "Author: <<author>> <<github-user>>",
          "",
          "Redistribution and use in source and binary forms, with or without",
          "modification, are permitted provided that the following conditions are",
          "met:",
          "",
          "1. Redistributions of source code must retain the above copyright notice,",
          "this list of conditions and the following disclaimer.",
          "",
          "2. Redistributions in binary form must reproduce the above copyright",
          "notice, this list of conditions and the following disclaimer in the",
          "documentation and/or other materials provided with the distribution.",
          "",
          "3. Neither the name of the copyright holder nor the names of its",
          "contributors may be used to endorse or promote products derived from this",
          "software without specific prior written permission.",
          "",
          "THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS AS",
          "IS AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,",
          "THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR ",
          "PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR",
          "CONTRIBUTORS BE",
          "LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR",
          "CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF",
          "SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS",
          "INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN",
          "CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)",
          "ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF",
          "THE POSSIBILITY OF SUCH DAMAGE.",
          "",
          "HISTORY:",
          "Date      \tBy\tComments",
          "----------\t---\t----------------------------------------------------------"
        ],
        "changeLogCaption": "HISTORY:",
        "changeLogHeaderLineCount": 2,
        "changeLogEntryTemplate": ["<<dateformat('YYYY-MM-DD')>>\t<<initials>>\t"]
      }
    ]
  }
' > psioniq-header-settings.json
