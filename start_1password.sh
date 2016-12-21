#!/bin/bash
#wine /tmp/1Password.exe /VERYSILENT /DIR=C:\1Password
[ -e /tmp/agilebits ] && ln -snf /tmp/agilebits /wine/drive_c/users/$(whoami)/Application\ Data/AgileBits
[ -e /tmp/1Password.opvault ] && ln -snf /tmp/1Password.opvault /wine/drive_c/users/$(whoami)
[ -e /tmp/1Password.opvault ] && sed -i '/\[Software\\\\AgileBits\\\\1Password.*/ a "Location"="C:\\\\users\\\\root\\\\1Password.opvault"' /wine/user.reg
sed -i '/\[Software\\\\AgileBits\\\\1Password.*/ a "VerifyCodeSignature"=dword:00000000"' /wine/user.reg
wine /wine/drive_c/1Password/1Password.exe
