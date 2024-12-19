#!/bin/bash

# Descrição: Criptografa arquivos usando o openssl
# Argumentos:
# [1] '-h' exibe ajuda.
# [2] Caminho do arquivo a ser protegido.
#     -r: Remove o arquivo original após criptografia.

# Função para exibir a ajuda
exibir_ajuda() {
  echo "Uso: $0 -h | <caminho_do_arquivo> [-r]"
  echo "Opções:"
  echo "  -h: Exibe esta ajuda e sai."
  echo "  -r: Remove o arquivo original após a criptografia."
  exit 0
}

# Verifica o primeiro argumento
if [ "$1" == "-h" ]; then
  exibir_ajuda
elif [ -z "$1" ]; then
  echo "Erro: O caminho do arquivo é obrigatório ou use -h para ajuda."
  exit 1
fi

# Caminho do arquivo a ser protegido
arquivo="$1"

# Verifica se o arquivo existe
if [ ! -f "$arquivo" ]; then
  echo "Erro: O arquivo '$arquivo' não foi encontrado."
  exit 1
fi

# Flag para remoção do arquivo original
remover_original=false
if [ "$2" == "-r" ]; then
  remover_original=true
fi

# Solicita a senha para proteger o arquivo
echo -n "Digite a senha para proteger o arquivo: "
read -s senha
echo

echo -n "Confirme a senha: "
read -s confirmacao
echo

# Verifica se as senhas coincidem
if [ "$senha" != "$confirmacao" ]; then
  echo "Erro: As senhas não coincidem. Tente novamente."
  exit 1
fi

# Nome do arquivo protegido
arquivo_protegido="${arquivo}.enc"

# Criptografa o arquivo
openssl enc -aes-256-cbc -salt -in "$arquivo" -out "$arquivo_protegido" -pass pass:"$senha"

# Verifica se a operação foi bem-sucedida
if [ $? -eq 0 ]; then
  echo "Arquivo protegido com sucesso: $arquivo_protegido"

  # Remove o arquivo original se a flag estiver ativa
  if $remover_original; then
    echo "Excluindo o arquivo original: $arquivo"
    rm "$arquivo"
    echo "Arquivo original removido com sucesso."
  fi
else
  echo "Erro: Falha ao proteger o arquivo."
  exit 1
fi
