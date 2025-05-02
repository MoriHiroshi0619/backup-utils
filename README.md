# &#128451; Backup de arquivos de configuração

---

## &#128421; oh my zsh

[Documentação](https://ohmyz.sh/)

Plugin para o terminal Linux, substitui o shell `bash` pelo `zsh`.  
O arquivo de configuração importa todos os comandos bash para serem compatíveis no novo shell `zsh`.  
comando para reconfigurar o powerlevel10k (tema)
```bash
p10k configure
```
&#128721; Ainda é necessário seguir a documentação para instalação das dependências.

---

## &#128433; logid

[Documentação](https://github.com/PixlOne/logiops)

Driver open-source criado por um santo para oferecer suporte a gestos dos mouses da linha 'MX' da Logitech em sistemas Linux.  
O arquivo de configuração salva os gestos rastreados para teclas de atalho do Ubuntu.  
&#128721; Ainda é necessário seguir a documentação para instalação das dependências.
<br> Após seguir a documentação e instalar o driver no sistema, para configurar o driver siga os passo

- crie o arquivo de configuração
  ```bash
  sudo nano /etc/logid.cfg
  ```
  copie e cole o conteudo salvo nesse repositório em `backup-utils/mx-master-3/logid.cfg`
  <br>PS: caso o scroll do mouse fique muito rápido ou muito lento, tente modificar as linhas
  ``` bash
  hiresscroll:
    {
        hires: true;
        invert: false;
        target: false;
    };
  ```
- reinicie o serviço para ver as mudanças sendo aplicadas
  ```bash
  sudo systemctl restart logid.service
  ```


---

## &#9000; Micro

[Documentação](https://github.com/zyedidia/micro)

Plugin open-source para terminais. Substitui o Nano como editor default do terminal.  
- Plugin de tema para o micro [Gothan](https://github.com/novln/micro-gotham-colors)

Copie o arquivo 'bashrc' em `~/.bashrc` e depois recarregue o bash com `source ~/.bashrc`.  
Como o oh-my-zsh pega do bash os comandos, rode também um `source ~/.zshrc`.  
&#128721; Ainda é necessário seguir a documentação para instalação das dependências.
