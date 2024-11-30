#!/bin/bash

#
#	Compilador para linguagem C feito em Shell!
#

#		Exibe arte da ferramenta.
cat ART.txt || echo "Não foi possível encontrar a arte da ferramenta..."


#		Mostra Mensagem de Ajuda.
MENSAGEM="

uso do compilador:

	./compiler.sh -f arquivo.c -x nomeExecutavel

	-h | --help			Mostra Mensagem de Ajuda.
	-f | --file			Recebe arquivo .c
	-x | --executable		Declara Nome executável.


"

#		Inicia laço de repetição do sistema shift.
while test -n "$1"
do
	case "$1" in

	-h | --help)
		echo "$MENSAGEM"
		exit
	;;

	-f | --file)
		CFILE=$2

	;;

	-x | --executable)
		XFILE=$2

	;;


 esac
shift
done

#		Verificando arquivo .c
TESTAFILE=$(file "$CFILE" | grep "C source")
	[ -z "$TESTAFILE" ] && {
        	echo -e '\033[31;1m[!] Erro, Arquivo fornecido inválido!\033[m'
		exit

	}

#               Verificando nome do executável.
        [ -z "$XFILE" ] && {
                echo -e '\033[31;1m[!] Erro, Nome para executável invalido!\033[m'
                exit

        }


#		Início do processo de compilação.
echo -e "\033[34;1m[*] Iniciando compilação do arquivo $CFILE ...\033[m"
echo -e "\033[34;1m[*] Gerando código intermediário...\033[m"

clang -S -emit-llvm "$CFILE" -o "$CFILE.ll"	#	Fases da compilação concluídas(4/7): Análise Léxica, Análise Sintática, Análise Semântica, Geração de código intermediário.

echo -e "\033[32;1m[$] Código intermediário $CFILE.ll gerado com sucesso!\033[m"
echo -e "\033[34;1m[*] Gerando código assembler...\033[m"


llc "$CFILE.ll" -o "$CFILE.s"			#	Fases da compilação concluídas(6/7): Análise Léxica, Análise Sintática, Análise Semântica, Geração de código intermediário, Otimização, Geração de código de Máquina.

echo -e "\033[32;1m[$] Código assembler $CFILE.s gerado com sucesso!\033[m"
echo -e "\033[34;1m[*] Gerando arquivo executável e combinando arquivos de objeto...\033[m"

as -o "$CFILE.o" "$CFILE.s" 2> /dev/null	#	Fases da compilaçõa concluídas(7/7):
gcc -o "$XFILE" "$CFILE.o" 2> /dev/null		#	Análise Léxica, Análise Sintática, Análise Semântica, Geração de Código intermediário, Otimização, Geração de código de máquina, Montador e Link Editor. 

echo -e "\033[32;1m[$] Processo de compilação concluído! execute o arquivo $XFILE \033[m"
