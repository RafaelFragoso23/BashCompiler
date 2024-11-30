![presentetion](https://github.com/user-attachments/assets/e1fe1e0b-4e46-414d-9411-dd8f6e681c26)


# BashCompiler 
Compilador para linguagem C que mistura recursos de vários outros compiladores, específico para rodar em ambientes Linux ou WSL com arquitetura Debian.

# Dependências
O BashCompiler usa uma série de pacotes debian para o seu funcionamento, para baixar-los automaticamente execute o código dependency.sh como super usuário.

# Funcionamento
Para utilizar o BashCompiler execute-o com os seus devidos parâmetros especificando o código fonte em c e um nome para o arquivo executável, assim como mostrado em:
```bash
./compiler.sh -f [arquivo.c] -x [executavel]

