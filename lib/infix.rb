
class Infix
  def infix()
    puts("ENTRE COM A STRING INFIXA")
    array = STDIN.gets()
    vector = array.split(%r{\s*})
    aberto = 0
    posfixa = String.new
    pilha = Array.new
    count=0
    for i in vector
      if i =~ /[0-9]/
        posfixa+=i
      elsif i == '+' || i == '-' || i == '*' || i == '/'
        if pilha.size == 0
          pilha.push(i)
        else
          #Prioridade do mais a esquerda
          if (pilha.last=='+' || pilha.last=='-') && (i=='+' || i=='-')
            if vector[count-1] == "+" || vector[count-1] == "-"
              puts("ERRO: DOIS OPERADORES COLOCADOS EM SEGUIDA")
              exit
            end
            posfixa+=pilha.last
            pilha.pop
            pilha.push(i)
          end

          if (pilha.last=='/' || pilha.last=='*') && (i=='*' || i=='/')
            posfixa+=pilha.last
            pilha.pop
            pilha.push(i)
          end

          #Entrando nas prioridades pilha para posfixa
          if (pilha.last=='*' || pilha.last=='/') && (i=='+' || i=='-')
            posfixa+=pilha.last
            pilha.pop
           # if (pilha.last=='+' || pilha.last=='-')
            #  posfixa+=pilha.last
            #  pilha.pop
            #end
            pilha.push(i)
          end
          #Entrando nas prioridades infixa para pilha
          if (pilha.last=='+' || pilha.last=='-') && (i=='*' || i=='/')
            pilha.push(i)
          end
          if pilha.last=='(' && (i == '+' || i == '-' || i == '*' || i == '/')
            pilha.push(i)
          end
        end
      elsif i=='('
        if (vector[count-1]=~ /[0-9]/) && count-1 > 0
          puts("ERRO: ABERTURA DE PARENTESES COLOCADA ERRONEAMENTE!")
          exit
        end
        if vector[count+1] == '*' || vector[count+1] == '+' || vector[count+1] == '/' || vector[count+1] == '-'
          puts("ERRO: OPERADOR COLOCADO APÓS ABERTURA DE PARENTESES")
          exit
        end
        pilha.push(i)
        aberto+=1
      elsif i==')'
        aberto-=1
        if aberto < 0
          puts("ERRO: FECHAMENTO DE PARANTESES COLOCADO ERRONEAMENTE")
          exit
        end
        if (vector[count-1] == '+' || vector[count-1] == '-' || vector[count-1] == '*' || vector[count-1] == '/')
          puts("ERRO: PARENTESE COLOCADO ERRONEAMENTE APÓS O CARACTERE -> #{vector[count-1]}")
          exit
        end
        posfixa+=pilha.last
        pilha.pop #TIRANDO O )
        until pilha.last=='('
          if pilha.last=='+' || pilha.last=='-' || pilha.last=='/' ||pilha.last=='*'
            posfixa+=pilha.last
            pilha.pop
          end
        end
        pilha.pop #TIRANDO O (
      end
      count+=1
    end
    if aberto > 0
      puts("ERRO: ERRO NA ABERTURA DE PARANTESES. FALTA(M) FECHAR #{aberto} PARENTESE(S).")
      exit
    end
    if pilha.size > 0
      for resto in pilha
        posfixa+=resto
        pilha.pop
      end
    end
    puts("STRING POSFIXA -> #{posfixa}")
    calcula(posfixa)
  end

  def calcula(str)
    #str = "453*+48*3/+"
    vector = str.split(%r{\s*})
    count=0
    while count < vector.size
      if vector[count] == '*'
        aux1 = vector[count-1].to_i
        aux2 = vector[count-2].to_i
        result = aux2 * aux1
        vector[count] = result
        tamanho = vector.slice!(count-2..count-1)
        count-= tamanho.size
      elsif vector[count] == '+'
        aux1 = vector[count-1].to_i
        aux2 = vector[count-2].to_i
        result = aux2 + aux1
        vector[count] = result
        tamanho = vector.slice!(count-2..count-1)
        count-= tamanho.size
      elsif vector[count] == '/'
        aux1 = vector[count-1].to_i
        aux2 = vector[count-2].to_i
        result = aux2 / aux1
        vector[count] = result
        tamanho = vector.slice!(count-2..count-1)
        count-= tamanho.size
      elsif vector[count] == '-'
        aux1 = vector[count-1].to_i
        aux2 = vector[count-2].to_i
        result = aux2 - aux1
        vector[count] = result
        tamanho = vector.slice!(count-2..count-1)
        count-= tamanho.size
      end
      count+=1
    end
    puts("CALCULO DA STRING POSFIXA #{str} = #{vector}")
  end
end
