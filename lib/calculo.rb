# To change this template, choose Tools | Templates
# and open the template in the editor.

module Calculo
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
    puts(vector)
  end
end
