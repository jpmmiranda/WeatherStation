class Interface


	def imprimeQuery(valores, contador, index, tamanho)

	         n = 0,i=0

	         printf("---------- Valores Recolhidos ------------\n");
	         while i<20 && index < tamanho do
	            printf("| %s \t\t |\n",valores[index])
	            contador+=1
	            index+=1
	            i+=1
	         end
	        
	         printf("------------------------------------------\n")
	         printf("| 1. Continuar.                          |\n")
	         printf("| 2. Retroceder.                         |\n")
	         printf("| 0. Sair.                               |\n")
	         printf("------------------------------------------\n")
	         printf(">")

	          n = gets.chomp.to_i
	          if(n==0)  
	                printf("\033c");
	                return 0
	          else            
	            if n == 1 && contador != tamanho
	              index++
	              imprimeQuery(valores, contador, index,tamanho)
	            else 
	              if(n == 1 && contador == tamanho)
	                if index<20
		                printf("Impossível continuar.\n")
		                imprimeQuery(valores, contador-index, 0,tamanho)
	                else
	                	printf("Voltou ao início\n")
	                	imprimeQuery(valores, contador-index, index-index,tamanho)
	              	end
	              else 
	                if(n == 2 && (contador-40) >= 0)
	                  
	                  imprimeQuery(valores, contador-40, index-40,tamanho)
	              
	                else 
	                  if(n == 2 && (contador-40) <= 0)
	                    if index<20
		                    printf("Impossível retroceder.\n")
		                    imprimeQuery(valores, contador-index,0,tamanho)
	                	else
	                		printf("Impossível retroceder.\n")
	                   		imprimeQuery(valores, contador-index,contador-index,tamanho)
	                	end
	                  else 
	                      if(n != 0)
	                          printf("\033c")
	                          printf("Comando inválido\n")
	                          imprimeQuery(valores, contador-20, index-20,tamanho)
	                      end
	                  end
	                end
	              end
	            end
	          end
	       end

	def imprimeMenuPrincipal
		 puts "----------------------------------------------"
    	 puts "| 1. Listar clientes                         |"
     	 puts "| 2. Listar valores de um determinado sensor |"
    	 puts "| 0. Sair                                    |"
  	     puts "----------------------------------------------"
  	     printf(">")
	end

	def imprimeMenuListar
		 puts "----------------------------------------------"
         puts "| 1. Listar valores do sensor de ruído       |"
         puts "| 2. Listar valores do sensor de temperatura |"
         puts "| 0. Sair                                    |"
         puts "----------------------------------------------"
         printf(">")
	end

	def imprimeMenuSelecionarCliente
		 puts "----------------------------------------------------------"
         puts "| Selecione cliente inserindo a sua longitude e latitude |"
         puts "----------------------------------------------------------"
	end
end
