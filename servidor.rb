  require 'socket'
  require 'mysql'
  require './baseDados'

  class Servidor
    #include Enumerable

    def initialize(port)
        @server = TCPServer.open(port)  
        #my = Mysql.new(hostname, username, password, databasename)  
        @bd = BaseDados.new('localhost', 'root', 'ruiborges', 'Leituras') 
        @arrayClientes = Array.new
    end

    def start
      loop {
        Thread.start(@server.accept) do |client|
          contadorLeituras = -1 
          # Faz coisas
          long = client.gets.chomp
          lat = client.gets.chomp
          puts "Cliente com longitude #{long} e latitude #{lat} conectou-se ao sistema"
          @bd.verificaClienteExiste(long,lat)
          @arrayClientes.push(long,lat)

          while true do

            leitura = client.gets.chomp

            if(leitura == "Fim")
              client.close
              @arrayClientes.delete(long)
              @arrayClientes.delete(lat)
              puts "Cliente : longitude #{long} e latitude #{lat} desconectou-se do sistema com #{contadorLeituras} leituras."
            else

              if(leitura=="T")
                leituraT = client.gets.chomp

                timestamp = client.gets.chomp

                contadorLeituras = contadorLeituras + 1
                @bd.adicionaRegistoTemperatura(leituraT,timestamp,long,lat)
              
              else leituraR = client.gets.chomp
                timestamp = client.gets.chomp
                contadorLeituras = contadorLeituras + 1
                @bd.adicionaRegistoRuido(leituraR,timestamp,long,lat)
              end

              
            
            end
          end

        end
      }
    end

      def close
        @bd.close
        @server.close
      end

      

      def listarClientes #Apresenta lista de clientes que estão ligados e a sua localização
        y = @arrayClientes.each_slice(2).to_a
        y.each{ |coords| puts "Cliente | [Longitude, Latitude]: "+coords.to_s}
      end

      def valoresSensorTemperatura(long,lat) # Apresentar valores recolhidos de temperatura de um dado xdk
        
      end


      def valoresSensorRuido(long,lat) # Apresentar valores recolhidos de ruido de um dado xdk
        valores = @bd.mostraValoresRuido(long,lat)
        contador=0
        index=0
        arrayAux = Array.new

        valores.each do |row|
        linha = row.join("\s")
        arrayAux.push( linha)
        end
        
        tamanho = arrayAux.size
        printQuery(arrayAux,contador,index,tamanho)
      end


      def printQuery( valores,  contador,  index,tamanho)

         n = 0,i=0

         printf("################## Valores de Ruido ######################\n");
         while i<20 && index < tamanho do
            printf("# %s \t\t\t\t #\n",valores[index])
            contador+=1
            index+=1
            i+=1
         end
        
         printf("##########################################################\n")
         printf("# 1. Continuar.                                          #\n")
         printf("# 2. Retroceder.                                         #\n")
         printf("# 0. Sair.                                               #\n")
         printf("##########################################################\n")
         printf(">")

          n = gets.chomp.to_i
          if(n==0)  
                printf("\033c");
                return 0
          else            
            if n == 1 && contador != tamanho
              index++
              printQuery(valores, contador, index,tamanho)
            else 
              if(n == 1 && contador == tamanho)
                
                printf("Impossível continuar.\n")
                printQuery(valores, contador-20, index-20,tamanho)
              
              else 
                if(n == 2 && (contador-40) >= 0)
                  
                  printQuery(valores, contador-40, index-40,tamanho)
              
                else 
                  if(n == 2 && (contador-40) <= 0)

                    printf("Impossível retroceder.\n")
                    printQuery(valores, contador-20, index-20,tamanho)
                
                  else 
                      if(n != 0)
                          printf("\033c")
                          printf("Comando inválido\n")
                          printQuery(valores, contador-20, index-20,tamanho)
                      end
                  end
                end
              end
            end
          end
       end

end

  

  server = Servidor.new(8000)

  # Signal catching
  def shut_down
    puts "\nShutting down server..."
  end

  # Trap ^C 
  Signal.trap("INT") { 
    shut_down
    server.close
    exit
  }

  # Trap `Kill `
  Signal.trap("TERM") {
    shut_down
    server.close
    exit
  }

serverThread=Thread.new{
  server.start
}
system "clear"

menuThread=Thread.new{
  while true do
    puts "----------------------------------------------"
    puts "| 1. Listar clientes                         |"
    puts "| 2. Listar valores de um determinado sensor |"
    puts "| 0. Sair                                    |"
    puts "----------------------------------------------"
    
    n = gets.chomp.to_i
    if n == 1
      x=server.listarClientes
    else 
      if n == 2
        server.valoresSensorRuido("41.569504","-8.433332")  #Alterar isto
      else 
        if n == 0
          puts "Servidor vai à vida"
        else
           printf("Comando inválido\n")
        end
      end
    end
  end
}

serverThread.join
menuThread.join