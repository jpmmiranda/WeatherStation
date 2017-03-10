  require 'socket'
  require 'mysql'
  require './baseDados'
  require './interface'

  class Servidor

      def initialize(port)
          @server = TCPServer.open(port)  
          #my = Mysql.new(hostname, username, password, databasename)  
          @bd = BaseDados.new('localhost', 'root', 'ruiborges', 'Leituras') 
          @arrayClientes = Array.new
          @int = Interface.new

      end

      def start
        loop {
          Thread.start(@server.accept) do |client|
            contadorLeituras = -1 
            long = client.gets.chomp
            lat = client.gets.chomp
            puts "Cliente com longitude #{long} e latitude #{lat} conectou-se ao sistema"
            @bd.insereCliente(long,lat)
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

      def listarClientes #Apresenta lista de clientes que estão ligados e a sua localização
        y = @arrayClientes.each_slice(2).to_a
        y.each{ |coords| puts "Cliente | [Longitude, Latitude]: "+coords.to_s}
      end

      def valoresSensorTemperatura(long,lat) # Apresentar valores recolhidos de temperatura de um dado xdk
        valores = @bd.mostraValoresTemperatura(long,lat)
        contador=0
        index=0
        arrayAux = Array.new

        valores.each do |row|
        linha = row.join("\s")
        arrayAux.push( linha)
        end
        
        tamanho = arrayAux.size
        @int.imprimeQuery(arrayAux,contador,index,tamanho)
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
        @int.imprimeQuery(arrayAux,contador,index,tamanho)
      end

      def close
        @bd.close
        @server.close
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

  bd = BaseDados.new('localhost', 'root', 'ruiborges', 'Leituras') 
  int = Interface.new

  while true do
   
    int.imprimeMenuPrincipal 
    n = gets.chomp.to_i

    if n!=0 && n!=1 && n!=2
      printf("Comando inválido\n")
    else
      if n == 0
        puts 'Servidor vai à vida' ##Tratar do bug
      else
            
      if n == 1
        x=server.listarClientes
      else 

        if n == 2
          int.imprimeMenuListar
          n = gets.chomp.to_i
          if n == 1
            int.imprimeMenuSelecionarCliente
            valores=bd.mostraClientes
            puts "------- Clientes --------"
            valores.each do |row|
              puts row.join("\s")
            end
            puts "-------------------------"
            puts "Longitude: "
            long = gets.chomp
            puts "Latitude: "
            lat = gets.chomp
            res=bd.verificaClienteExiste(long,lat)
            if(res==1) 
               server.valoresSensorRuido(long,lat)
             end
           else 

            if n==2
              int.imprimeMenuSelecionarCliente
              valores=bd.mostraClientes
              puts "------- Clientes --------"

              valores.each do |row|
                puts row.join("\s")
              end

              puts "-------------------------"
              puts "Longitude: "
              long = gets.chomp
              puts "Latitude: "
              lat = gets.chomp
              res=bd.verificaClienteExiste(long,lat)
              if(res==1) 
                 server.valoresSensorTemperatura(long,lat)
              end

            else 
              if n!=0
                printf("Comando inválido\n")
              end     
            end 
          end
        end
      end
    end
  end
end
}

serverThread.join
menuThread.join