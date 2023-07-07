$\color{green}\textsf{\large \&#129438; Configuración fácil de nuevo PC}$ 

![sho600](https://user-images.githubusercontent.com/197329/234124658-535eade7-84a6-43d4-a333-7ca90109d092.png)

### 1. Desactivar acoplamiento y activar `[Impr Pant]`
* Abrir [Multitarea▶️](https://0o.cl/multitask) y en `Acoplar ventanas` deasctivar 3er "... al arrastrar una ventana a la parte superior"

* Abrir [Teclado▶️](https://0o.cl/keyboard) y en `Teclado en pantalla, teclas de acceso..` activar "Utilizar el botón Impr Pant.."


### 2. Abrir `PowerShell` como administrador
* Tecla <kbd>⊞</kbd>, escribir `PW` y presionar <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Enter</kbd>

### 3. Instalar **WSL2**
```
wsl --install
```

Mientras se instala, abrir otro PowerShell de admin y continuar:

### 4. Utilidades Windows
<details>
<summary>¿Qué es esto?</summary>

**Son 3 archivos que se copiarán en tu $HOME (C:\Users\...)**

| Archivo | Descripción |
|-|-|
| choko.bat | Permite ejecutar `choko <programa>` para instalar programa desde Chocolatey, el cual pedirá permisos de administración
| shoko.bat | Permite hacer búsquedas de programas con `shoko <texto>`
| .wslconfig | Configura WSL para usar máximo 8gb de RAM
| seb.reg | Modifica el registro de windows para: <br>👉 Mostrar opción "Administrador de tareas" en click secundario de barra inferior <br>👉 Activar los menús clasicos al hacer clic derecho
</details>

```bat
Invoke-WebRequest -Uri "https://gist.githubusercontent.com/sebolio/b38f7ef6db673fd32b5f5366f0d97e86/raw/bd3eea8019b3803c59ce5415d92e88d0f56fb474/choko.bat" -OutFile "$HOME\choko.bat"
Invoke-WebRequest -Uri "https://gist.githubusercontent.com/sebolio/b38f7ef6db673fd32b5f5366f0d97e86/raw/bd3eea8019b3803c59ce5415d92e88d0f56fb474/shoko.bat" -OutFile "$HOME\shoko.bat"
Invoke-WebRequest -Uri "https://gist.githubusercontent.com/sebolio/b38f7ef6db673fd32b5f5366f0d97e86/raw/bd3eea8019b3803c59ce5415d92e88d0f56fb474/wslconfig" -OutFile "$HOME\.wslconfig"
Invoke-WebRequest -Uri "https://gist.githubusercontent.com/sebolio/b38f7ef6db673fd32b5f5366f0d97e86/raw/a28fccff561fc20595a04260f5c87be343337904/utils.reg" -OutFile "$HOME\seb-utils.reg"
reg import $HOME\seb-utils.reg
```

### 5. Instalar Chocolatey
```bat
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### 6. Instalar mis programas favoritos:
```bat
choco install -y --allow -empty-checksums --ignore-checksum googlechrome googledrive authy-desktop winrar vscode spotify slack telegram qbittorrent firefox tableplus epicgameslauncher steam battle.net goggalaxy vlc evernote postman treesizefree auto-dark-mode
```

### 7. Instalar fuentes (🖱️)
1. [Descargar aquí](https://1drv.ms/u/s!An9eKsg-lFZRsJIzweujNblNSrMUQg?e=3K7l8C) (no descomprimir)
2. Ejecutar esto para instalar:
```
Expand-Archive -Path "$HOME\Downloads\Fuentes Terminal.zip" -DestinationPath $ENV:TEMP\Fuentes
$SourceFolder = "$HOME\AppData\Local\Temp\Fuentes"
Add-Type -AssemblyName System.Drawing
$WindowsFonts = [System.Drawing.Text.PrivateFontCollection]::new()
Get-ChildItem -Path $SourceFolder -Include *.ttf, *.otf -Recurse -File |
Copy-Item -Destination "$env:SystemRoot\Fonts" -Force -Confirm:$false -PassThru |
ForEach-Object {
$WindowsFonts.AddFontFile($_.fullname)
$RegistryValue = @{
Path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'
Name = $WindowsFonts.Families[-1].Name
Value = $_.Fullname
}
$RemoveRegistry = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
Remove-ItemProperty -name $($WindowsFonts.Families[-1].Name) -path $RemoveRegistry
New-ItemProperty @RegistryValue
}
```

<table><tr><td> $\color{red}\textsf{\Large Ahora reinicia tu PC}$ </td></tr></table>

$\color{red}\textsf{Ubuntu se instalará automáticamente al reiniciar}$


```powershell
shutdown /r /t 0 /f
```

---

### 8. Configurar Terminal
* Abrir [Windows Terminal ➡️](http://0o.cl/powershell) y seguir instrucciones para dejarlo como predeterminado
* Elegir Ubunutu 🐧 como default, guardar y abrir una nueva pestaña del terminal

### 9. Habilitar sudo sin password
```
sudo sed -i 's/) ALL/) NOPASSWD:ALL/' /etc/sudoers
```

### 10. Instalar Zsh y configuraciones
Instalar zsh, dejarlo default y ejecutarlo
```
sudo apt install zsh -y
```
```
chsh -s $(which zsh)
```
```
zsh
```

Una vez en zsh, instalar ohmyzsh + p10k + node
```
curl https://gist.githubusercontent.com/sebolio/b38f7ef6db673fd32b5f5366f0d97e86/raw/3d2d9802708bb276a5360dd8356bc1bebea2074a/z-p10k.zsh -o .p10k.zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Se solicitará presionar <kbd>Enter</kbd> y cuando termine, pegar esto para implementar `nvm`, `fuente`, `p10k` y `alias`.
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
. $HOME/.nvm/nvm.sh
nvm install --lts
WINDIR=`cmd.exe /c echo %systemdrive%%homepath% 2> /dev/null | tr -d '\r' | xargs -0 wslpath`           
sed -i 's/robbyrussell/powerlevel10k\/powerlevel10k/' .zshrc
sed -i '1s/^/source "${XDG_CACHE_HOME:-$HOME\/.cache}\/p10k-instant-prompt-${(%):-%n}.zsh"\n/' .zshrc
sed -i 's/"name": "Ubuntu",/"name": "Ubuntu", "font": { "face": "CaskaydiaCove Nerd Font", "size": 10 },/' $WINDIR/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
echo "
#alias y comandos
unalias gp
function gp { git add -A; git commit -m \"\$*\"; git push }
alias d=\"npm run dev\"
alias dev=\"npm run dev\"
alias doc=\"npm run storybook\"
alias json=\"npm run stub\"
alias stub=\"npm run stub\"
alias pu=\"git pull\"
alias p=\"ping nic.cl\"
\n#powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
\n#google drive
[[ ! -d /mnt/g ]] && sudo mkdir /mnt/g
sudo mount -t drvfs G: /mnt/g">>~/.zshrc
```
Ignorar el error de `operation not permitted`

### 11. Instalaciones por click

* **[WhatsApp](http://0o.cl/whatsapp) [▶️](http://0o.cl/whatsapp)**
* **[TransulcentTB](http://0o.cl/translucenttb) [▶️](http://0o.cl/translucenttb)**
* **[QuickLook](http://0o.cl/quicklook) [▶️](http://0o.cl/quicklook)**
* **[Wallpaper Engine](http://0o.cl/wallpaperengine) [▶️](http://0o.cl/wallpaperengine)**

### 12. `gh` y repos

```
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```

<details>
<summary></summary>
Añadir llaves

```
WINDIR=`cmd.exe /c echo %systemdrive%%homepath% 2> /dev/null | tr -d '\r' | xargs -0 wslpath`
mkdir ~/.ssh
cp $WINDIR/OneDrive/.ssh/* ~/.ssh
chmod 600 ~/.ssh/*
```

Clonar
```
git clone git@github.com:sebolio/seb.cl.git
git clone -b main git@github.com:sebolio/fichero.git fichero
git clone -b master git@github.com:sebolio/fichero.git vetmaster
git clone git@github.com:afex-tc/plus-base.git --recursive
```
</details>

![](https://raw.githubusercontent.com/javascript-obfuscator/javascript-obfuscator/master/images/logo.png)

| FIN 😉 |
| --- |

