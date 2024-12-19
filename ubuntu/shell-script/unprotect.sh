#!/bin/bash

# Descrição: Descriptografa arquivos encriptados com OpenSSL.
# Argumentos:
# [1] '-h' exibe ajuda.
# [2] Caminho do arquivo .enc a ser descriptografado.
#     Opções adicionais:
#     -r: Remove o arquivo .enc original após descriptografia.
#     -v: Exibe o conteúdo descriptografado no terminal e remove o arquivo descriptografado.

# Função para exibir a ajuda
exibir_ajuda() {
  echo "Uso: $0 -h | <caminho_do_arquivo>.enc [-r|-v]"
  echo "Opções:"
  echo "  -h: Exibe esta ajuda e sai."
  echo "  -r: Exclui o arquivo .enc após a descriptografia."
  echo "  -v: Exibe o conteúdo descriptografado e exclui o arquivo descriptografado."
  exit 0
}

# Verifica o primeiro argumento
if [ "$1" == "-h" ]; then
  exibir_ajuda
elif [ -z "$1" ]; then
  echo "Erro: O caminho do arquivo é obrigatório ou use -h para ajuda."
  exit 1
fi

# Caminho do arquivo criptografado
arquivo_enc="$1"

# Verifica se o arquivo .enc existe
if [ ! -f "$arquivo_enc" ]; then
  echo "Erro: O arquivo '$arquivo_enc' não foi encontrado."
  exit 1
fi

# Nome do arquivo descriptografado (removendo a extensão .enc)
arquivo_dec="${arquivo_enc%.enc}"

# Variáveis para controlar as ações
remover_enc=false
visualizar_apenas=false

# Verifica o segundo argumento
case "$2" in
  -r)
    remover_enc=true
    ;;
  -v)
    visualizar_apenas=true
    ;;
  "")
    # Nenhum argumento extra é válido
    ;;
  *)
    echo "Erro: Argumento desconhecido '$2'."
    exibir_ajuda
    ;;
esac

# Solicita a senha para descriptografar o arquivo
echo -n "Digite a senha para descriptografar o arquivo: "
read -s senha
echo

# Tenta descriptografar o arquivo
openssl enc -aes-256-cbc -d -in "$arquivo_enc" -out "$arquivo_dec" -pass pass:"$senha"

# Verifica se a descriptografia foi bem-sucedida
if [ $? -eq 0 ]; then
  echo "Arquivo descriptografado com sucesso: $arquivo_dec"

  if $visualizar_apenas; then
    echo
    echo -e "\e[32mConteúdo do arquivo descriptografado:\e[0m"
    echo
    echo -e "\e[36m$(cat "$arquivo_dec")\e[0m"
    echo
    rm "$arquivo_dec"
  elif $remover_enc; then
    rm "$arquivo_enc"
    echo "Arquivo descriptografado removido."
  fi
else
  echo "Erro: Falha ao descriptografar o arquivo. Verifique a senha."
  # Remove o arquivo descriptografado, caso tenha sido criado incorretamente
  [ -f "$arquivo_dec" ] && rm "$arquivo_dec"
  exit 1
fi
